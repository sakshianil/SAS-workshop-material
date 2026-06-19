%include "&project_root/shared/setup.sas";

data work.safety;
  set adam.adsl;
  where saffl="Y";
  length treatment $20;
  treatment=trt01a;
  output;
  treatment="Total";
  output;
run;

proc sql;
  create table work.age_stats as
  select treatment,
         count(age) as n,
         mean(age) as mean,
         std(age) as sd,
         median(age) as median,
         min(age) as min,
         max(age) as max
  from work.safety
  group by treatment;

  create table work.sex_counts as
  select treatment, sex, count(*) as count
  from work.safety
  group by treatment, sex;

  create table work.race_counts as
  select treatment, race, count(*) as count
  from work.safety
  group by treatment, race;
quit;

data work.demog_display;
  length section $20 rowlabel $60 treatment $20 value $30;
  set work.age_stats;
  section="Age";
  rowlabel="Mean (SD)";
  value=cats(put(mean,5.1)," (",put(sd,5.2),")");
  output;
  rowlabel="Median";
  value=strip(put(median,5.1));
  output;
  rowlabel="Min, Max";
  value=cats(put(min,3.),", ",put(max,3.));
  output;
  keep section rowlabel treatment value;
run;

proc sql;
  insert into work.demog_display
  select "Sex", cats("  ",put(sex,$sexfmt.)), treatment, strip(put(count,8.))
  from work.sex_counts;
  insert into work.demog_display
  select "Race", cats("  ",propcase(race)), treatment, strip(put(count,8.))
  from work.race_counts;
quit;

proc sort data=work.demog_display;
  by section rowlabel treatment;
run;

ods html path="&project_root/output/tlf" file="table_14_1_1.html";
%report_header(title=Table 14.1.1 - Demographics - Safety Population);
proc report data=work.demog_display nowd;
  columns section rowlabel treatment,value;
  define section / group order=data;
  define rowlabel / group order=data;
  define treatment / across;
  define value / display;
run;
ods html close;
title;
footnote;

