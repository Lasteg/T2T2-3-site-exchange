# T2T2-3-site-exchange
MATLAB NMR T2-T2 sequence 3-site exchange simulator 

Please check Vadzim Yermakou's "Study of the transport of water in the
nanopores of C–S–H by 1H NMR" Thesis from University of Surrey for details.

The T2−T2 experiment is known to be effective for exchange monitoring. It consists of
two encodings of the T2 magnetisation decay at two successive times separated by a short
magnetization storage interval during which only T1 relaxation occurs. The time between
two encodings tex is varied to explore the time of the exchange. A 2D inverse Lapace
transformation of the data is made. This converts the the data to a map of T2 in the first
encoding interval against T2 in the second. On the plot diagonal peaks show nuclei which
do not move between pores of different size during the tex, that is they have the same T2 in
both encoding periods. Off-diagonal peaks indicate presence of exchange between pores of
different size (Washburn and Callaghan, 2006). That is T2 is different in the two encoding
periods.
