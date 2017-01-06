/******
Programmer: Lian Hu
Description: 
1. use transport.xpt in CTN0031A to generate sas datasets
2. link education variables in parent study (CTN031, ASI2) to child study (CTN031A DEM)___failed. Will report.
****/
 
/***CTN31A downloaded from CTN data share on 12/8/2016***/

option nofmterr;
*libname CTN031A "E:\CTN\CCTN DATASHARE DOWNLOAD\CTN0031A\Sasdata";  ***change path to actual path**;
libname CTN031A "X:\project2016\SAS-related\spss";
*filename importin "E:\CTN\CCTN DATASHARE DOWNLOAD\CTN0031A\Xptdata\transport.xpt"; ***change path to transport.xpt to actual path**;
filename importin "X:\project2016\SAS-related\spss\transport.xpt";


proc cimport infile=importin library=CTN031A  memtype=data;
run;
****a total of 28 sas data sets. Use DEM to locate demographics including age, gender, ethnicity and race****;
data dem;
set CTN031A.dem;
keep patdeid DEM01DT DEM02 DEM03 DEM04 DEM04A DEM04B 
     DEM04C DEM04D DEM04E DEM04F DEM04G;
run;  ***obs=244***;




libname CTN031 "E:\CTN\CCTN DATASHARE DOWNLOAD\CTN0031\SASdata_newdownload";***change to actual path**;
filename importin "E:\CTN\CCTN DATASHARE DOWNLOAD\CTN0031\SASdata_newdownload\sas-transport-crf-files_nida-ctn-0031\transport.xpt";  **change to actual path***;
proc cimport infile=importin library=CTN031 memtype=data;
run;

data edu_ctn31;
set CTN031.asi2;
keep ASL0E1A patdeid;
run; ***ASL0E1A is “years of education” in parent study***;
