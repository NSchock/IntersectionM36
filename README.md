# IntersectionM36
Code for the article "Intersection theory of the stable pair compactification of the moduli space of six lines in the plane"

There are two files
1) 'BoundaryComplex.sage' computes the 1-skeleta of the boundary complexes for $\overline{M}(3,6)$ and $\widetilde{M}_1(3,6)$
2) 'ChowM36.sage' defines the Chow ring of $\widetilde{M}_1(3,6)$ and contains code for computing the products of psi classes.

A portion of 'ChowM36.sage' dealing with checking the products of psi classes was written in part by Valery Alexeev, as indicated in the file. The rest was written by Nolan Schock.

To check/compute all products of psi classes, load 'ChowM36.sage' in sage, and run the function check_permutation_invariance()
