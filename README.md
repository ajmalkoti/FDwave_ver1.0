# FDwave ver. 1.0

The pacakage was developed to demostrate the use of vectorized fd operator 
for the simulation of elastic seismic waves.


#### Authors: 
Ajay Malkoti (AcSIR-NGRI, Hyderabad, India-500007) 

Nimisha Vedanti and Ram Krishna Tiwari (CSIR-NGRI, Hyderabad, India-500007)


#### Contact:  
ajmalkoti@gmail.com

#### Characterstics of code:

1) 2D finite difference time domain modelling over- staggered grid.
2) It can simulate the seismic wave propagation in the elastic media.
3) It uses very efficient vectorized finite difference operator. 


#### Content in package:
**FDWAVE**: 	This directory contains all the programs & functions related to seismic modelling.

**SCRIPTS**: 	This directory contains all the file containing commands used for the modelling. 

#### How to run the program 
The code doesnt require any special installation.

However, the subroutine *FDwave_initialize* should be included in the beginning of scripts.
Further, to avoid any (remote) possibility of confilct with other subroutines while running other codes,  
*FDwave_deinitialize* can be included at the end of scripts.


Packages developed by others, viz. SEGYMAT can be added to directory *FDwave\Other_packages*

#### How to run the program
Sample scripts are provided in the script directory.

Further help about a function (with name say fun_name) can be obtained by typing  function name  i.e. "**help fun_name**".

#### References:

1) Malkoti, A., Vedanti, N., Tiwari, R. K., 2018. An algorithm for fast elastic wave simulation using a vectorized finite difference operator. Computers & Geosciences 116, 23-31

2) Malkoti, A., Vedanti, N., Tiwari, R. K., 2018. Viscoelastic modeling with a vectorized finite difference operator. 




