/* use a DATA step to subset data test more comments*/
data localCars;
  set sashelp.cars(where=(origin="USA"));
run;asdf

title "All USA cars, all variables";
/* produces a report of all numeric variables */
proc means data=localCars
  mean stddev median mode n;
run;

title "All USA cars, just MPG numbers";
/* narrows the processing to just two variables more comment */
proc means data=localCars
  mean stddev median mode n;
var mpg_highway mpg_city;
run;

title "All USA cars, just MPG numbers";
title2 "by type?";
proc means data=localCars  
  mean stddev median mode n;
var mpg_highway mpg_city;
/* would produce an error because data is not sorted */
/* by type; */
run;

title "All USA cars, just MPG numbers";
title2 "by type";
/* so let's sort the data first another comment*/
proc sort data=localCars
  out=sortcars;
by type;
proc means /*sortcars data is implied and antother commetn */
  mean stddev median mode n;
var mpg_highway mpg_city;
by type;
run;