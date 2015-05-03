needsPackage"LieTypes"
needsPackage"ConformalBlocks"

makecbvb = (slrankplusone, level, weights) -> (
  m = slrankplusone;
	la = simpleLieAlgebra(sl_m);
	conformalBlockVectorBundle(la, level, weights, 0))

--- this outputs a list {stuff_1, stuff_2, ...} where each entry stuff_i
--- is a tuple {a_1, a_2, ..., a_m} where m = numentries and where the
--- sum of the a_i is no more than maxsum. order is important, so we count
--- {0, 1, 2} and {0, 2, 1} as distinct tuples.
makeboundedtuples = (numentries, maxsum) -> (
  tuples := {};
  for i from 0 to maxsum do (
    starter := {i};
    tuples = append(tuples, starter);
  );
  if numentries == 1 then 
    return tuples
  else
    tuples = {};
    for i from 0 to maxsum do (
      partialtuples = makeboundedtuples(numentries-1, maxsum - i);
      for p in partialtuples do (
        starter := {i};
        tuple = starter | p;
        tuples = append(tuples, tuple);
      );
    );
    return tuples;
)

--- the weights, which are assigned to marked points, are described by
--- lists of the form: {c_1, c_2, ..., c_r} which represents the linear
--- combination of the fundamental weights omega_i where the coefficient
--- in front of the ith fundamental weight is c_i. the star operation
--- reverses this list. the point here is that when pairs of points are
--- attached, the two attached weights must be stars of each other.
makestar = (weight) -> (
  return reverse(weight);
)

--- this produces all pairs of complementary weights for a pair of points
--- to be attached. that is, the output is a list whose elements are pairs
--- {w, w*} consisting of a weight and its star, and where the weight runs
--- through all possible weights.
makestars = (rank, level) -> (
  weights := makeboundedtuples(rank, level);
  mypairs = {};
  for t in weights do (
    tstar = reverse(t);
    pair = {t, tstar};
      mypairs = append(mypairs, pair);
  );
  return mypairs;
)

--- outputs a list whose entries are all possible combinations of
--- assignment of weights and their star complements to numpairs pairs of
--- points. a typical element of the list has the form: 
--- {w_1, w_1*, w_2, w_2*, ..., w_numpairs, w_numpairs*} 
makepairsdata = (rank, level, numpairs) -> (
  if numpairs == 0 then (
    return {};
    ) 
  else (
    mypairs = makestars(rank, level);
    if numpairs == 1 then (
      return mypairs;
    ) 
    else (
      remainingpairs = makepairsdata(rank, level, numpairs - 1);
      pairdata = {};
      for myfirst in mypairs do (
        for rest in remainingpairs do (
          newdata = myfirst | rest;
          pairdata = append(pairdata, newdata);
        );
      );
      return pairdata;
    );
  );
)

--- this will output a list whose elements are all possible data on genus
--- 0 curves which will contribute to the rank computation for the rank
--- of a conformal blocks bundle on a curve with the lambdas describing
--- weight data on some marked points, and numpairs of pairs of points
--- attached. to do this, we are generating all possible ways of assigning
--- weights to a marked genus 0 curve, where the first 2*numpairs 
--- points are marked in pairs with *-complementary weights, and the
--- remining points are marked with the lambdas. 
--- 
makerestrictiondata = (rank, level, numpairs, lambdas) -> (
  pairsdata = makepairsdata(rank, level, numpairs);
  restrictiondata = {};
  for d in pairsdata do (
    weights = d | lambdas;
    restrictiondata = append(restrictiondata, weights)
  );
  return restrictiondata;
)

showweights = (rank, level, numpairs, weights) -> (
  for i from 1 to numpairs do (
    myfirst = 2*i-2;
    second = 2*i-1;
    << "w_" << i << "=" << weights#myfirst << ", ";
    << "w_" << i << "*=" << weights#second;
    if i != numpairs then
      << ", ";
  );
  numjoined = 2*numpairs;
  numlambdas = length(weights) - numjoined;
  if numlambdas != 0 then
    << ", ";
  for i from 1 to numlambdas do (
    j = numjoined + i - 1;
    << "lambda_" << i << "=" << weights#j;
    if i != numlambdas then
      << ", ";
  );
)

showrestrictiondata = (rank, level, numpairs, rd) -> (
  for weights in rd do (
    showweights(rank, level, numpairs, weights);
    print "";
  );
)

findcbrank = (rankplusone, level, numpairs, lambdas) -> (
  rank := rankplusone - 1;
  rd = makerestrictiondata(rank, level, numpairs, lambdas);
  cbrank = 0;
  for weights in rd do (
    v = makecbvb(rank + 1, level, weights);
    r = conformalBlockRank(v);
    cbrank = cbrank + r;
  );
  return cbrank;
)

findcbrankverbose = (rankplusone, level, numpairs, lambdas) -> (
  rank := rankplusone - 1;
  rd = makerestrictiondata(rank, level, numpairs, lambdas);
  cbrank = 0;
  for weights in rd do (
    showweights(rank, level, numpairs, weights);
    << " ==> ";
    v = makecbvb(rank + 1, level, weights);
    r = conformalBlockRank(v);
    cbrank = cbrank + r;
    << " + " << r << " (=" << cbrank << ")";
    print "";
  );
  return cbrank;
);

