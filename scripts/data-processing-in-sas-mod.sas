
option nofmterr;
*libname CTN031A "E:\CTN\CCTN DATASHARE DOWNLOAD\CTN0031A\Sasdata";  ***change path to actual path**;
libname CTN031A "X:\project2016\SAS-related\spss";
*filename importin "E:\CTN\CCTN DATASHARE DOWNLOAD\CTN0031A\Xptdata\transport.xpt"; ***change path to transport.xpt to actual path**;
filename importin "X:\project2016\SAS-related\spss\transport.xpt";


proc cimport infile=importin library=CTN031A  memtype=data;
run;
****a total of 28 sas data sets. Use DEM to locate demographics including age, gender, ethnicity and race****;

/*

option nofmterr;
data dem.mod;
set CTN031A.dem;
run;
/*
keep patdeid DEM01DT DEM02 DEM03 DEM04 DEM04A DEM04B 
     DEM04C DEM04D DEM04E DEM04F DEM04G;
run;  ***obs=244***;

