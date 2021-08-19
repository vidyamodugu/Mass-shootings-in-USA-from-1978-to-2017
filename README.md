Proc Sql code:

/*Assigning LIBNAME and FILENAME statements to the CSV files*/
%let path=/folders/myfolders/Data sets; 
%let fpath=/folders/myfolders/certprep/gunviolence_mass.csv;
libname p "&path";
Filename Project "&fpath";

/*Looking at the column attributes of the tables using Describe Statement*/
Proc sql;
describe table p.GMVICTIM_INFORMATION,P.GM_YEAR,P.GM_VICTIMS;
quit;

/*using NOEXEC options and SUM function*/
PROC SQL noexec;
CREATE table p.Totalvictims as
select sum(total_victims)as Totalvictims
from p. GUNVIOLENCE_MASS
WHERE YEAR= 1982;
quit;

/*Summary function Count*/
proc sql;
select gender,count(*) as gendercount
from p. gunviolence_mass
where gender = 'M'or gender = 'F'
group by gender;
quit;

/*Summary function Count*/
proc sql;
select venue,count(*) as occurance
from p. gunviolence_mass
where venue='Other' or venue ='Workplace' or venue= 'Religious' 
or venue = 'School' or venue = 'Military'
group by venue;
quit;

/*Summary function Count*/
proc sql;
select Weapons_Obtained_legally,count(*) as legal_illegal
from p. gunviolence_mass
where Weapons_Obtained_legally='Yes' or Weapons_Obtained_legally='No'  
or Weapons_Obtained_legally='Unknown'
group by Weapons_Obtained_legally;
quit;
/*Summary function Count*/
proc sql;
select MentalHealth_issues,count(*) as Mentalhealth
from p. gunviolence_mass
where MentalHealth_issues='Yes' or MentalHealth_issues='No'  or
 MentalHealth_issues = “Unknown"
or Weapons_Obtained_legally='Unknown'
group by MentalHealth_issues;
quit;

Proc sql;
select type_of_weapons,count(*)
from p.GVIOLENCE
group by TYPE_OF_WEAPONs;
quit;

/*Inner Join*/
Proc sql;
CREATE TABLE P.MG_STATE AS
select A.*,B.state
from P. gunviolence_mass as A
      INNER JOIN
     P.GM_state as B
ON A.instance=B.instance;
quit;

/*Summary function Count*/
proc sql Number;
/*create table p.frequency as*/
select state,count(*) as statefreq 'statefreq' format=comma2.
from P.MG_STATE
group by state
order by   statefreq desc ;
quit;

/*INNER join to join tables*/
proc sql;
Create table p.VICTIMS_YEARJOIN as
select V. instance,V.location,date,year,fatalities,injured,total_victims
from p.MG_Victims as V inner join P.MG_Year AS Y
on V.instance=Y.instance
   ;
quit;
          
proc sql;
 create table p.weapons
 			  (Instance char format=$35.5,
 			   handguns num format=20.5, handguns_level char format=$20.,
 			   shotguns num format=20.5, shotguns_level char format=$20.,
 			    semiautomatic num format=20.5, semiautomatic_level char format=$20.,
 			    Assault_Rifiles num format=20.5, AssaultRifiles_level char format=$20.);


proc sql;
 insert into p.weapons
 select instance format=$35., 
 		handguns,
 		case 
 		   when handguns =. then "missing"
           when handguns =0 then "low"
           when handguns ge 1 then "medium"
           when handguns ge 2 then "high"
                  
                end as handguns_level,
                shotguns,
          case 
           when shotguns =. then "missing"
           when shotguns =0 then "low"
           when shotguns ge 1 then "medium"
           when shotguns ge 2 then "high"
           
           end as shotguns_level,
 		semiautomatic,
 		case 
 		   when semiautomatic =. then "missing"
           when semiautomatic =0 then "low"
           when semiautomatic ge 1 then "medium"
           when semiautomatic ge 2 then "high"
                   
             end as semiautomatic_level,
 		Assault_Rifiles,
 		case 
 		   when Assault_Rifiles =. then "missing"
           when Assault_Rifiles =0 then "low"
           when Assault_Rifiles ge 1 then "medium"
           when Assault_Rifiles ge 2 then "high"
              
           end as Assaultrifiles_level
          from p.weapons_shootings;
         quit;

/*using NOEXEC options and SUM function*/
PROC SQL nonumber;
CREATE table p.Totalvictims as
select sum(total_victims) as Totalvictims
from p.MG_victims;
quit;
MACROS:
%let path=/folders/myfolders/Data sets/ecmac193; 
libname orion "&path";

/*Assigning LIBNAME and FILENAME statements to the CSV files*/
%let path=/folders/myfolders/Data sets; 
%let fpath=/folders/myfolders/certprep/gunviolence_mass.csv;
libname p "&path";
Filename Project "&fpath";

/* Using Automatic Macro Variables, %Put statement and Symbolgen option*/
option symbolgen;
%put &=SYSLIBRC &=SYSERR &=SYSPARM;

/*Looking at the column attributes of the tables using Describe Statement*/
Proc sql;
describe table p. gunviolence_mass;
quit;

/*using Macro Charector functions*/
%let date=10/01/2017;
%let location= Lasvegas, NV;

proc sql outobs=1;
select Location,
date, %substr(&sysdate9,1,2) as month format=5.,
from p. gunviolence_mass;
quit;

/*user defined Macro variables
%let location= Lasvegas, NV;
proc sql outobs=1;
select Location, (%scan(%superq(&location),2,","))
from p. gunviolence_mass;
quit; */

/*using user defined macro variables*/
%let year=1982
/*using options and SUM function*/
PROC SQL number;
CREATE table p.Totalvictims as
select &year as year 'Year' format=4., sum(total_victims) as Totalvictims
from p. GUNVIOLENCE_MASS
WHERE YEAR=&year;
quit;

/*using options and SUM function*/
/*Title "Report produced on %sysfunc(today(),weekdate.)";*/
%put Title;
PROC SQL number;
CREATE table p.Totalvictims as
select year 'Year' format=4., count (*)as freq
from p. GUNVIOLENCE_MASS
group by year
order by freq,year ;
quit;

/*using macrocharector functions*/
%let dsn=p. gunviolence_mass;
%let dsn=%upcase(&dsn);
%let lib=%scan(&dsn,1);
%let mem=%scan(&dsn,2);
proc sql;
   select year, freq
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
select year, count (*) as no_incidents
from p. gunviolence_mass
where year between &thisyear and &lastyear
group by year;
quit;

/*using functions with macro variables*/
Title "report produced on %sysfunc(today(),weekdate.)";
proc sql ;
select Location, %sysfunc(scan(location,2,',')) 'state' format=20.
from p. gunviolence_mass;
quit;

/*using macro quoting functions*/
proc sql;
select gender,count(*) as gendercount
from p. gunviolence_mass
where gender = 'M'or gender = 'F' 
group by gender;
quit;

/*data step with %symputx*/
%let year=2017
data p. traggic;
set p.frequency end=final;
where year=&year;
if statefreq ge 40 then number+1;
if final then do;
put number=;
if number = 0 then do;
 call symputx (foot,no tragic events);
 if number ne 0 then do;
 call symputx (foot,some traggic events)
 end;
 end;
 run;
 
 proc print data=p. traggic;
 title"most tragic shootings for &year";
 footnote "&foot";
 run;
 
 /*data lookup table*/
/*using NOEXEC options and SUM function*/
%let year= 1982;
options MPRINT;
PROC SQL;

select sum(total_victims)
      into: total 
from p. GUNVIOLENCE_MASS
WHERE YEAR= &year;
quit;

title "Total victims for the &year";
footnote "Total Victims: &total";


proc print data=p. gunviolence_mass;
where year=&year;
run;

/*storing list of values in a macro variable*/
proc sql noprint;
select distinct state
into: ST
separated by ','
from p.mg_state;
quit;

%put &st;
/* using macro definition*/
options mcompilenote = all;
%macro puttime;
%put the current time is %sysfunc(time (), timeampm.).;
%mend puttime;

proc catalog cat=p. sasmacr;
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
proc freq data=p. gunviolence_mass;
where year between &lastyear and &thisyear;
table Total_Victims;
title "orders from &thisyear to &lastyear;
run;

/*using positional parameters*/

%let year1 = 2017;
%let year2= 2007;
%macro countvictims(year1, year2);
options MPRINT;
proc sql;
select year, Total_victims,count(Total_Victims) as totalvictims
from p. gunviolence_mass;
where year=&year1 and year=&year2
group by year;
title "orders from &year1 to &year2;
run;
%mend countvictims;

options mprint;
%countvictims(2017,2007)

