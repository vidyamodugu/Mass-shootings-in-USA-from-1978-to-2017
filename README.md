This analysis provides comprehensive information regarding Mass Shootings from 1982-2017 like frequency of occurrence, weapons used, possession of weapons (legal/illegal) and mental health condition of the shooter along with the information regarding many people dead and injured in every incident. 
The data collected  has been uploaded into SAS studio, "import data" option is used to convert the datasets into SAS datasets for the analysis. This analysis uses "PROC SQL" steps to produce reports and "SAS Macros "to save the SQL steps and to repeat them as necessary for increased efficiency and flexibility.


**METHODOLOGY**:
The data file is provided as CSV file, which has been imported into SAS studio. The following methodologies were used in the analysis to create reports.
 1.PROC IMPORT, to import the data and convert the CSV file to SAS datasets.
 2.DICTIONARY.COLUMNS is used to see the contents of the data for further analysis.
 3. Tables were combined using INNER JOIN and sub query steps for further analysis.
 4.CASE Expressions were used to define the data into different levels using conditions for easy understanding.
 5. CREATE TABLE is used to create new tables with the new columns created from the existing columns.
 6.MACRO variables global and local were used to substitute text in the code that is repeated for every year information.
 7.MACRO definitions using %MACRO and %MEND was created to save the SAS steps and SAS steps which is repeated like PROC print step or PROC SQL steps for reducing   redundancy and increasing efficiency and computational time.
**REPORTS DESCRIPTION**
Different reports were produced combining the datasets using PROC SQL joins and tables were created to save and retrieve the data for further analysis. Further Macros variables, functions and programs were created to automate the data in the process of creating reports for every year of mass shootings. 

**SQL DESCRIPTION**:
 	The Process of analysis starts with combining datasets using INNER JOIN, specifying the variables that are needed for the analysis from the two tables. PROC SQL step with summary function count has been used on dataset MG_VICTIMS, to count the number of victims per every year from 1982 to 2017. To continue with PROC SQL step with summary function count is used on dataset MG_YEAR, MG_STATE, to count the no of incidents per each year, to gives us a report of frequency of occurrence of incidents every year, to produces a report which has the information regarding number many incidents occurred in each state, to create columns that count number of weapons obtained legally and illegally, to create column that has count weather mass shooter has any mental conditions.  
New columns were created using a summary function to produce the count of weapons obtained legally and illegally, count of male and female shooters and the information regarding whether the mass shooter has any previous mental condition. CREATE TABLE is used to create a new table called weapons which stores the count of different weapons used and no of weapons used in each incident by the mass shooter. A case expression is used to designate levels according to the weapons used by mass shooters for each incident.


**MACROS DESCRIPTIONS**:
>-To start with Macros variables were created to save the path of the files imported as text and then the text is substituted in the libname and filename statements to assign library.
>-Automatic Macro variables &syslibrc, &syserr, &sysparm with the %put statement were used to check if the library is successfully assigned, they write value 0 to the SAS log if the library is successfully assigned and a value of 1 if the library assignment is failed. User-defined variables were created and saved to automate the PROC SQL steps. Macro definitions were created using %MACRO and %MEND statements for the SAS code that is repeated. For Example: creating a table that shows a total number of victims each year. System options like Mcompilenote = all is used, which writes the compilation information to the SAS log. To continue with, the macro definition is called is called along with positional parameters to create reports for each year from 1982 to 2017. Mprint system option is used along with the call, which displays the code that is sent for compiling in the log and the sas statements displayed by macro execution.
>-To decrease the number of macros functions or to limit the number of the macro functions %if %then statement and %do loop is used to write complete and partial SAS steps on conditions along with If then clauses. MLOGIC system option is used while calling a macro function which writes to SAS log the information about macros resolved during execution. Mlogic option identifies the macro execution path, which helps us to debug the problem.

**ENVIRONMENT**:
* **[SAS On Demand](https://www.sas.com/en_ca/curiosity.html?utm_source=google&utm_medium=cpc&utm_campaign=brand-global&utm_content=GMS-158646-gbc-cf&gclid=Cj0KCQjwpf2IBhDkARIsAGVo0D1Chh8BouufuF3t0xMFH_H3XM-W8YkwGYCBOAOFJ9YlsjZylhcDl5UaAmcUEALw_wcB)**

**REQUIRMENTS**:
* **[SAS Studio](https://www.sas.com/en_ca/software/studio.html)**
* **[SAS Enterprise Guide](https://support.sas.com/en/software/enterprise-guide-support.html)**






