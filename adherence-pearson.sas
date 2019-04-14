
/*
Data Analysis for Functional Health Literacy on Treatment Adherence among Type 2 Diabetic Clients using Pearson Correlation.
Author: Alfeo Sabay
*/
DATA adh;
	INFILE "/folders/myfolders/adherence/adherence_recoded-2.csv" firstobs=2;
	INPUT @;
	literacy=SCAN(_INFILE_, 19, ',');
	adherence=SCAN(_INFILE_, 26, ',');
	conv_lit=INPUT(literacy, 4.);
	conv_adh=INPUT(adherence, 4.);
	DROP literacy;
	DROP adherence;
	RENAME conv_lit=literacy;
	RENAME conv_adh=adherence;
RUN;
/*
PROC PRINT DATA=adh;
RUN;
*/

/*
PROC PRINT DATA=adh;
RUN;

PROC CONTENTS DATA=adh;
RUN;

*/

/* Exploratory Data Analysis Section */

TITLE "ADHERENCE VS LITERACY SCATTERPLOT";
PROC SGSCATTER DATA=adh;
	MATRIX adherence literacy;
RUN;



proc sgplot data=adh;
  reg x=literacy y=adherence / degree=1 clm='CL Mean'; 

  /* position the legend inside the top-right corner of the plot area */
  keylegend / location=outside position=topright across=1;

  /* show grid lines on both axes */
  xaxis grid;
  yaxis grid;
  TITLE "LITERACY VS ADHERENCE LINEAR FIT PLOT";
run;

proc sgplot data=adh;
  reg x=adherence y=literacy / degree=1 clm='CL Mean'; 

  /* position the legend inside the top-right corner of the plot area */
  keylegend / location=outside position=topright across=1;

  /* show grid lines on both axes */
  xaxis grid;
  yaxis grid;
  TITLE "ADHERENCE VS LITERACY FIT PLOT";
run;

/* Summary Statistics */
TITLE "SUMMARY STATISTICS FOR ADHERENCE GROUPING";
PROC MEANS DATA=adh;
	CLASS adherence;
	VAR literacy;
RUN;

TITLE "SUMMARY STATISTICS FOR LITERACY GROUPING";
PROC MEANS DATA=adh;
	CLASS literacy;
	VAR adherence;
RUN;

/*
PROC UNIVARIATE DATA=adh plots;
	CLASS adherence;
	VAR literacy;
RUN;
*/
/* Bar Plots */
TITLE 'MEAN OR AVERAGE ADHERENCE BY LITERACY';
PROC SGPLOT DATA=adh;
  VBAR literacy / response=adherence stat=mean;
run;

TITLE 'MEAN OR AVERAGE LITERACY BY ADHERENCE';
PROC SGPLOT DATA=adh;
  VBAR adherence / response=literacy stat=mean;
run;

PROC SGPLOT data=adh;
    vbar literacy;
    TITLE "HISTOGRAM FOR LITERACY - N OBSERVATIONS PER GROUP";
run;

PROC SGPLOT data=adh;
    vbar adherence;
    TITLE "HISTOGRAM FOR ADHERENCE - N OBSERVATIONS PER GROUP";
run;

/* Box plots */
proc sgplot data=adh;
  vbox adherence / category=literacy group=literacy
    lineattrs=(pattern=solid) whiskerattrs=(pattern=solid); 
  yaxis grid;
  keylegend / location=outside position=topright across=1;
  TITLE "BOXPLOT FOR ADHERENCE BY LITERACY GROUPINGS";
run;

proc sgplot data=adh;
  vbox literacy / category=adherence group=adherence
    lineattrs=(pattern=solid) whiskerattrs=(pattern=solid); 
  yaxis grid;
  keylegend / location=outside position=topright across=1;
  TITLE "BOXPLOT FOR LITERACY BY ADHERENCE GROUPINGS";
run;



/*
Pearson  Correlation Test
*/
TITLE "PEARSON PRODUCT-MOMENT CORRELATION ANALYSIS";
ODS TRACE ON;
PROC CORR DATA=adh;
	VAR adherence literacy;
RUN;


