EmoMat
======

Emotiv connector for Matlab

eeglogger.m -> Copyright (c) May 2010 The Johns Hopkins University Applied Physics Laboratory (JHU/APL).

EmotivEEG.m -> Copyright (c) 2012, Gavin

You would need the following files to run these files:

1. edk.dll
2. edk.h
3. edk_utils.dll
4. edkErrorCode.h
5. EmoStateDLL.h

All these are available with Emotiv SDK.

Go to [Emotiv](http://www.emotiv.com) website for more information.


Installing `mex` compiler?
==========================

1. Open Matlab (this has been tested on R2013a).
2. Add the folder and all the DLL and .h files to the path.
3. Use mex to install c/c++ compiler by doing the following
* `mex -setup` (Please make sure the required compilers are installed eg: Visual Studio 2010 pro for Matlab R2013a or Microsoft Windows SDK 7.1)
  * 
```
Welcome to mex -setup.  This utility will help you set up  
a default compiler.  For a list of supported compilers, see  
http://www.mathworks.com/support/compilers/R2013a/win32.html 
 
Please choose your compiler for building MEX-files: 
 
Would you like mex to locate installed compilers [y]/n?
```
* Enter `y` and press enter
* Then you should get the following 
```
Select a compiler: 
[1] Lcc-win32 C 2.4.1 in C:\PROGRA~2\MATLAB\R2013A~1\sys\lcc 
[2] Microsoft Visual C++ 2010 in c:\Program Files (x86)\Microsoft Visual Studio 10.0 
 
[0] None 
 
Compiler: 
```
* Enter the number of the compiler which you want to install and then press enter, eg: `2`; then you will get the following
```
Please verify your choices: 
 
Compiler: Microsoft Visual C++ 2010  
Location: c:\Program Files (x86)\Microsoft Visual Studio 10.0 
 
Are these correct [y]/n? 
```
* enter `y` and press enter. Then you will get the following
```
*************************************************************************** 
  Warning: MEX-files generated using Microsoft Visual C++ 2010 require 
           that Microsoft Visual Studio 2010 run-time libraries be  
           available on the computer they are run on. 
           If you plan to redistribute your MEX-files to other MATLAB 
           users, be sure that they have the run-time libraries. 
*************************************************************************** 
 
 
Trying to update options file: C:\Users\gollahalli\AppData\Roaming\MathWorks\MATLAB\R2013a\mexopts.bat 
From template:              C:\PROGRA~2\MATLAB\R2013A~1\bin\win32\mexopts\msvc100opts.bat 
 
Done . . . 
 
************************************************************************** 
  Warning: The MATLAB C and Fortran API has changed to support MATLAB 
           variables with more than 2^32-1 elements.  In the near future 
           you will be required to update your code to utilize the new 
           API. You can find more information about this at: 
           http://www.mathworks.com/help/matlab/matlab_external/upgrading-mex-files-to-use-64-bit-api.html  
           Building with the -largeArrayDims option enables the new API. 
************************************************************************** 
```
* This means you have successfully installed the compiler for Matlab.
* (OR)
* If you select `1`, **Note: This is only applicable for Windows** you will get
```
Please verify your choices: 
 
Compiler: Lcc-win32 C 2.4.1 
Location: C:\PROGRA~2\MATLAB\R2013A~1\sys\lcc 
 
Are these correct [y]/n? 
```
* Enter `y` then you will get
```
Trying to update options file: C:\Users\gollahalli\AppData\Roaming\MathWorks\MATLAB\R2013a\mexopts.bat 
From template:              C:\PROGRA~2\MATLAB\R2013A~1\bin\win32\mexopts\lccopts.bat 
 
Done . . . 
 
************************************************************************** 
  Warning: The MATLAB C and Fortran API has changed to support MATLAB 
           variables with more than 2^32-1 elements.  In the near future 
           you will be required to update your code to utilize the new 
           API. You can find more information about this at: 
           http://www.mathworks.com/help/matlab/matlab_external/upgrading-mex-files-to-use-64-bit-api.html  
           Building with the -largeArrayDims option enables the new API. 
************************************************************************** 
```
* This means you have installed the compiler for Matlab.

