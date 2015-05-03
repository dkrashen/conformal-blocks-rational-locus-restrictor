#Conformal Blocks Restrictor Instructions#

##Loading##

This is not a "package" for M2, so you don't need to install it. To load it to use its functions simply type into M2:

	load "cbr.m2"
	
from the same directory that the <code>cbr.m2</code> file is in.

##Usage##

####Syntax for weights####
 
weights (always assuming lie algebras of type A) are entered as lists in the form <code>{c1, c2, ..., cm}</code> where the entry <code>ci</code> is the coefficient of the fundamental weight $$$\omega_i$$$. 


####Function: makecbvb####


	makecbvb(rankplusone, level, weights)
this just runs Dave's program to construct a conformal blocks vector bundle on genus 0 curves as usual, for the group $$$sl\_{\\text{rankplusone}}$$$.
 
####Function: findcbrank####
 
	findcbrank(rankplusone, level, numpairs, lambdas)
	
Here, <code>lambdas</code> is a list of weights, entered as <code>{lambda<sub>1</sub>, lambda<sub>2</sub>, ..., lambda<sub>t</sub>}</code>, where each <code>lambda<sub>i</sub></code> is a weight in the format described above. The function then computes the rank of the conformal blocks vector bundle on the moduli space $$$\\overline M\_{s, t}$$$, where $$$s$$$=<code>numpairs</code> by factorization at a point in the rational locus. That is, in the image of the map from $$$\overline M\_{0, 2s + t}$$$ given by attaching $$$s$$$=<code>numpairs</code> pairs of points.

####Function: findcbrankverbose####

 	
	findcbrankverbose(rankplusone, level, numpairs, lambdas)

shows the details for how the findcbrank function is working, by explicitly listing all possible assignments of attaching weights to the paired points of the $$$2s + t$$$-pointed rational curves, and showing the rank contribution of each of these associated conformal blocks on $$$\overline M\_{0, 2s + t}$$$.
 	
<br />
<br />
<br />




