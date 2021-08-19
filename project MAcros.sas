%let path=/folders/myfolders/Data sets/ecmac193; 
libname orion "&path";
    

/*Assigning LIBNAME and FILENAME statements to the CSV files*/
%let path=/folders/myfolders/Data sets; 
%let fpath=/folders/myfolders/certprep/gunviolence_mass.csv;
libname p "&path";
Filename Project "&fpath";

/* Using Automatic Macro Variables, %Put statement and Symbolgen option*/
option symbolgen;
%put &=SYSLIBRC &=SYSERR &=SYSPARM ;



/*Using noexec option/
Proc sql noexec;
describe table p.gunviolence_mass;
quit;

/*Looking at the column attributes of the tables using Describe Statement*/
Proc sql;
describe table p.gunviolence_mass;
quit;


/*using Macro Charector functions*/
%let date=10/01/2017;
%let location= Lasvegas,NV;

proc sql outobs=1;
select Location,
date,%substr(&date,1,2) as month format=5.,
from p.gunviolence_mass;
quit;


/*user defined Macro variables

%let location= Lasvegas,NV;

proc sql outobs=1;
select Location,(%scan(%superq(&location),2,","))
from p.gunviolence_mass;
quit;*/


/*using user defined macro variables*/
%let year=1982
/*using options and SUM function*/
PROC SQL number;
CREATE table p.Totalvictims as
select &year as year 'Year' format=4.,sum(total_victims)as Totalvictims
from p.GUNVIOLENCE_MASS
WHERE YEAR=&year ;
quit;



/*using options and SUM function*/
/*Title "Report produced on %sysfunc(today(),weekdate.)";*/
%put Title;
PROC SQL number;
CREATE table p.Totalvictims as
select year 'Year' format=4.,count(*)as freq
from p.GUNVIOLENCE_MASS
group by year
order by freq,year ;
quit;

/*using macrocharector functions*/
%let dsn=p.gunviolence_mass;
%let dsn=%upcase(&dsn);
%let lib=%scan(&dsn,1);
%let mem=%scan(&dsn,2);
proc sql;
   select year,freq
   	from dictionary.tables
	where libname="&lib" and
	memname="&mem";
quit;

/*using Macro evaluation functions*/
%let thisyear=%substr(&sysdate9,6);
%let lastyear=%eval(&thisyear-1);
option symbolgen;
%put &=lastyear;
proc sql;
Title "number of incidents between &lastyear and &thisyear";
select year, count(*) as no_incidents
from p.gunviolence_mass
where year between &thisyear and &lastyear
group by year;
quit;

/*using functions with macro variables*/
Title "report produced on %sysfunc(today(),weekdate.)";
proc sql ;
select Location,%sysfunc(scan(location,2,',')) 'state' format=20.
from p.gunviolence_mass;
quit;


/*using macro quoting functions*/
proc sql;
select gender,count(*) as gendercount
from p.gunviolence_mas
where gender = 'M'or gender = 'F' or gender=%nrstr(M&F)
group by gender;
quit;

/*data step with %symputx*/
%let year=2017

data p.traggic;
set p.frequency end=final;
where year=&year;
if statefreq ge 40 then number+1;
if final then do;
put number=;
if number = 0 then do;
 call symputx(foot,no tragic events);
 if number ne 0 then do;
 call symputx(foot,some traggic events)
 end;
 end;
 run;
 
 proc print data=p.traggic;
 title"most tragic shootings for &year";
 footnote "&foot";
 run;
 
 
 /*data lookup table*/
/*using NOEXEC options and SUM function*/
%let year= 1982;
options MPRINT;
PROC SQL ;

select sum(total_victims)
      into :total 
from p.GUNVIOLENCE_MASS
WHERE YEAR= &year ;
quit;

title "Total victims for the &year";
footnote "Total Victims: &total";

proc print data=p.gunviolence_mass;
where year=&year;
run;


/*storing list of values in a macro variable*/

proc sql noprint;
select distinct state
into :ST
separated by ','
from p.mg_state;
quit;

%put &st;

/* using macro definition*/
options mcompilenote = all;
%macro puttime;
%put the current time is %sysfunc(time(), timeampm.).;
%mend puttime;

proc catalog cat=p.sasmacr;
contents;
title "My temporary macros";
quit;

/*calling macros*/
options MPRINT;
%puttime

/* using option MPRINT */
%let thisyear = %substr(&sysdate9,6);
%let lastyear = %eval (&thisyear - 10);
%put &=thisyear &=lastyear;
options MPRINT;
proc freq data=p.gunviolence_mass;
where year between &lastyear and &thisyear;
table Total_Victims;
title "orders from &thisyear to &lastyear;
run;


/*using positional parameters*/

%let year1 = 2017;
%let  year2= 2007;
%macro countvictims(year1,year2);
options MPRINT;
proc sql;
select year,Total_victims,count(Total_Victims) as totalvictims
from p.gunviolence_mass;
where year=&year1 and year=&year2
group by year;
title "orders from &year1 to &year2;
run;
%mend countvictims;

options mprint;
%countvictims(2017,2007)






 
 
 
 
 
 
 





 
 













/*using NOEXEC options and SUM function*/
%let year=&var
PROC SQL ;
CREATE table p.Totalvictims1982 as
select sum(total_victims)as Totalvictims into :TV1-:TV32
from p.GUNVIOLENCE_MASS
WHERE year=&var;
quit;

data_null_;
select sum(total_)
from P.gunviolence_mass




%MACRO YEARLOOP (START,END)
PROC SQL; 
     %DO year=&start. %TO &end.; 
       CREATE TABLE TOTALVICTIMS&START as 
       SELECT SUM(TOTAL_VICTIMS) 
       FROM P.GUNVIOLENCE_MASS 
       WHERE year=&start; 
     %END; 
   QUIT;
%mend; 


/*mlogic, Mprint, Mprint, Symbolgen, %put statement*/
/* Macro Eval function*/
/*23. Create macro variables with a list of values.
24. Use indirect reference to macro variables.
25. Generate repetitive macro calls using the 
%DO loop, macro variable, and the EXECUTE routine.*/







