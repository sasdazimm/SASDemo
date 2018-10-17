/* Chrome Version 32.0.1700.102 m*/
%let name=mandelbrot;
filename odsout '.';

/*
SAS/Graph version of
http://rosettacode.org/wiki/Mandelbrot_set#Fortran
*/

%let x_min=-2.5;
%let x_max=1.5;
%let y_min=-1.5;
%let y_max=1.5;
%let i_points=800;
%let j_points=600;

/* ------------------------------------------------------------ */
/*
annotate a 3x3 grid, with the href to drilldown using SAS/Intrnet
*/
data anno_grid;
    length html $500;
    xsys='1';
    ysys='1';
    when ='b';

    /* draw grid before/behind the graph, so it's "invisible" */
    line=0;
    style='empty';
    color='pink';

    do i=0 to 2*(100/3) by (100/3);

        do j=0 to 2*(100/3) by (100/3);
            html='href='||quote('http://sww.sas.com/sww-bin/broker9?_service=appdev92&_program=ctntest.mandelbrot.sas'||
    '&x_min='||trim(left(&x_min+(i/100)*(&x_max-&x_min)))||
    '&x_max='||trim(left(&x_min+(i/100)*(&x_max-&x_min) 
                + (&x_max-&x_min)/3))||
    '&y_min='||trim(left(&y_min+(j/100)*(&y_max-&y_min)))||
    '&y_max='||trim(left(&y_min+(j/100)*(&y_max-&y_min) 
                + (&y_max-&y_min)/3)) );
            function='move';
            x=i;
            y=j;
            output;
            function='bar';
            x=i+(100/3);
            y=j+(100/3);
            output;
        end;
    end;
run;

/* ------------------------------------------------------------ */
data mandelbrot (keep=j i colorvar);
    width=&x_max-&x_min;
    height=&y_max-&y_min;
    x_centre=&x_min+(width/2);
    y_centre=&y_min+(height/2);

    /*
    n_max is the number of levels of color to use.
    You'll need to assign a color for each one in your annotated points.
    */
    n_max=41;

    /*
    Although the plot looks like smooth/continuous color, it is really
    composed of lots of individual 'points' - if you use enough points,
    and pack them together dense enough, then they will look like solid
    colors. (i = x direction, and j = y direction)
    */
    i_points=&i_points;
    j_points=&j_points;
    dx_di=width/i_points;
    dy_dj=height/j_points;
    x_offset=x_centre - 0.5*(i_points+1)*dx_di;
    y_offset=y_centre - 0.5*(j_points+1)*dy_dj;

    do j=1 to j_points;
        y_0=y_offset + dy_dj * j;

        do i=1 to i_points;
            x_0=x_offset + dx_di * i;
            x=0.0;
            y=0.0;
            n=0;

            do while (1=1);
                x_sqr=x**2;
                y_sqr=y**2;

                /* outside */
                if (x_sqr+y_sqr > 4.0) then
                    do;
                        colorvar=(n_max-n)+1;
                        output;
                        leave;
                    end;

                /* inside */
                if (n eq n_max) then
                    do;
                        colorvar=(n_max-n)+1;
                        output;
                        leave;
                    end;
                y=y_0 + 2.0*x*y;
                x=x_0 + x_sqr - y_sqr;
                n+1;
            end;
        end;
    end;
run;

goptions noborder;
goptions gunit=pct ftitle="albany amt/bold" ftext="albany amt" htitle=18pt 
    htext=12pt;

/*
Gplot is a little slow when plotting the mandelbrot data as
"plot j*i=colorvar", therefore I'm using brute force and
annotating all the colored dots.
*/
/* You should assign as many colors/symbols as you have n_max.  */
data anno_dots (rename=(i=x j=y));
    set mandelbrot;
    length function color $8;
    xsys='2';
    ysys='2';
    when ='a';
    function='point';

    if colorvar=1 then
        color="black";
    else if colorvar=2 then
        color="CXCC99FF";
    else if colorvar=3 then
        color="CX9966CC";
    else if colorvar=4 then
        color="CX663399";
    else if colorvar=5 then
        color="CX003366";
    else if colorvar=6 then
        color="CXCC99FF";
    else if colorvar=7 then
        color="CX9966CC";
    else if colorvar=8 then
        color="CX663399";
    else if colorvar=9 then
        color="CX003366";
    else if colorvar=10 then
        color="CXCC99FF";
    else if colorvar=11 then
        color="CX9966CC";
    else if colorvar=12 then
        color="CX663399";
    else if colorvar=13 then
        color="CX003366";
    else if colorvar=14 then
        color="CXCC99FF";
    else if colorvar=15 then
        color="CX9966CC";
    else if colorvar=16 then
        color="CX663399";
    else if colorvar=17 then
        color="CX003366";
    else if colorvar=18 then
        color="CXCC99FF";
    else if colorvar=19 then
        color="CX9966CC";
    else if colorvar=20 then
        color="CX663399";
    else if colorvar=21 then
        color="CX003366";
    else if colorvar=22 then
        color="CXFF99CC";
    else if colorvar=23 then
        color="CXCC6699";
    else if colorvar=24 then
        color="CX993366";
    else if colorvar=25 then
        color="CX660033";
    else if colorvar=26 then
        color="CXFFCC99";
    else if colorvar=27 then
        color="CXCC9966";
    else if colorvar=28 then
        color="CX996633";
    else if colorvar=29 then
        color="CX663300";
    else if colorvar=20 then
        color="CXCCFF99";
    else if colorvar=31 then
        color="CX99CC66";
    else if colorvar=32 then
        color="CX669933";
    else if colorvar=33 then
        color="CX336600";
    else if colorvar=34 then
        color="CX99FFCC";
    else if colorvar=35 then
        color="CX66CC99";
    else if colorvar=36 then
        color="CX339966";
    else if colorvar=37 then
        color="CX006633";
    else if colorvar=38 then
        color="CX99CCFF";
    else if colorvar=39 then
        color="CX6699CC";
    else if colorvar=40 then
        color="CX336699";
    else if colorvar=41 then
        color="CX003366";
run;

title1 ls=1.5 "SAS/Graph Mandelbrot";
footnote1 "Created using Data Step and Annotated Colored Points";

/* This creates a 'blank' plot axes, to annotate my dots in */
data foo;
    x=&x_min;
    y=&y_min;
run;

symbol1 value=none interpol=none color=white;
axis1 order=(0 to &j_points) label=none value=none major=none minor=none 
    offset=(0, 0);
axis2 order=(0 to &i_points) label=none value=none major=none minor=none 
    offset=(0, 0);

proc gplot data=foo anno=anno_grid;
    plot y*x=1 / vaxis=axis1 haxis=axis2 nolegend anno=anno_dots des='' 
        name="&name";
    run;
quit;