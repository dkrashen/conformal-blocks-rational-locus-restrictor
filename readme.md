#Conformal Blocks Restrictor Instructions#

##Description##

The purpose of this script is to provide some functions to compute the ranks of conformal blocks divisors over curves of positive genus, using the functions provided by [Dave Swinarski](http://faculty.fordham.edu/dswinarski/)'s [Conformal Blocks](http://faculty.fordham.edu/dswinarski/conformalblocks/) package for genus 0.

In particular, in order to use this script it is necessary to have installed both the LieTypes.m2 and ConformalBlocks.m2 packages. These are both available on [Dave Swinarki's website](http://faculty.fordham.edu/dswinarski/conformalblocks/)

This script is written in the [Macaulay2](http://www.math.uiuc.edu/Macaulay2/) language, and was tested on version 1.1.99.

##Loading##

This is not a "package" for M2, so you don't need to install it. To load it to use its functions simply type into M2:

	load "cbr.m2"
	
from the same directory that the <code>cbr.m2</code> file is in.

##Usage##

####Syntax for weights####
 
weights (always assuming lie algebras of type A) are entered as lists in the form <code>{c1, c2, ..., cm}</code> where the entry <code>ci</code> is the coefficient of the fundamental weight $$$\omega_i$$$. 


####Function: makecbvb####


	makecbvb(rankplusone, level, weights)
this just runs Swinarski's program to construct a conformal blocks vector bundle on genus 0 curves as usual, for the group $$$sl\_{\\text{rankplusone}}$$$.
 
####Function: findcbrank####
 
	findcbrank(rankplusone, level, numpairs, lambdas)
	
Here, <code>lambdas</code> is a list of weights, entered as <code>{lambda<sub>1</sub>, lambda<sub>2</sub>, ..., lambda<sub>t</sub>}</code>, where each <code>lambda<sub>i</sub></code> is a weight in the format described above. The function then computes the rank of the conformal blocks vector bundle on the moduli space $$$\\overline M\_{s, t}$$$, where $$$s$$$=<code>numpairs</code> by factorization at a point in the rational locus. That is, in the image of the map from $$$\overline M\_{0, 2s + t}$$$ given by attaching $$$s$$$=<code>numpairs</code> pairs of points.

####Function: findcbrankverbose####

 	
	findcbrankverbose(rankplusone, level, numpairs, lambdas)

shows the details for how the findcbrank function is working, by explicitly listing all possible assignments of attaching weights to the paired points of the $$$2s + t$$$-pointed rational curves, and showing the rank contribution of each of these associated conformal blocks on $$$\overline M\_{0, 2s + t}$$$.
 	
<br />
<br />


<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.

<br />
<br />
<br />




