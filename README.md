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


How to use?
===========

1. Open Matlab (this has been tested on R2013a).
2. Add the folder and all the DLL and .h files to the path.
3. Use mex to install c/c++ compiler by doing the following
  * `mex -setup` (Please make sure the required compilers are installed eg: Visual Studio 2010 pro for Matlab R2013a or Microsoft Windows SDK 7.1)
  * ```
Welcome to mex -setup.  This utility will help you set up  
a default compiler.  For a list of supported compilers, see  
http://www.mathworks.com/support/compilers/R2013a/win32.html 
 
Please choose your compiler for building MEX-files: 
 
Would you like mex to locate installed compilers [y]/n?
```
  * Enter 'y' and press enter
  * Then you should get the following ```Select a compiler: 
[1] Lcc-win32 C 2.4.1 in C:\PROGRA~2\MATLAB\R2013A~1\sys\lcc 
[2] Microsoft Visual C++ 2010 in c:\Program Files (x86)\Microsoft Visual Studio 10.0 
 
[0] None 
 
Compiler: ```
..* Enter the number of the compiler which you want to install and then press enter.
