
libname data "/r/sanyo.unx.sas.com/vol/vol101/u101/sawals/Steamboat/";

ods noproctitle;

proc qlim data=DATA.HMEQ covest=hessian method=quanew plots(only)=(predicted 
        proball);
    model MORTDUE=LOAN / discrete(distribution=probit);
run;
