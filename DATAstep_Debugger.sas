proc sort data=sashelp.cars out=cars;
by make;
run;

data testme;
set cars(where=(cylinders eq 8)) nobs=numObs;
format dollarsPerHorse dollar20.2 runningAverageHorsepower 6.1;
retain runningHorses;
by make;
if _n_ eq 1 then runningHorses=0; else runningHorses=runningHorses+Horsepower;
runningAverageHorsepower=runningHorses/_n_;
dollarsPerHorse=invoice/Horsepower;
run;

proc print;
run;

data _null_;
y=(0.1 + 0.2) + 0.3;
z=0.1 + (0.2 + 0.3);
if y eq z then do;
	put "equal";
end;
run;

data a;
set sashelp.class;
if sex eq "F";
  output;
run;

data b;
set sashelp.class;
where sex eq "F";
run;