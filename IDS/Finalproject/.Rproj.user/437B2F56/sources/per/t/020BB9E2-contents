library(tidyverse)
library(readr)
age_sex<- read_csv("C:/Users/dnndo/Desktop/IDS/Finalproject/20231212-mental-health-inpatient-activity-age-sex.csv")
view(age_sex)

patients_by_age_yearly <- age_sex%>% 
  select (FinancialYear,Sex, AgeGroup,PatientsCount)

view(patients_by_age_yearly)

patients_per_year<-summarise((group_by (select(patients_by_age_yearly, FinancialYear, PatientsCount), FinancialYear)), patients_per_year= sum (PatientsCount) )

view(patients_per_year)

female_patients_per_year<- summarise((group_by (select(filter(patients_by_age_yearly, Sex== "Female"), FinancialYear, PatientsCount), FinancialYear)), female_patients_per_year= sum (PatientsCount) )
view(female_patients_per_year)

male_patients_per_year<- summarise((group_by (select(filter(patients_by_age_yearly, Sex== "Male"), FinancialYear, PatientsCount), FinancialYear)), male_patients_per_year= sum (PatientsCount) )
view(male_patients_per_year)

patients_per_year_per_sex <-full_join(female_patients_per_year,male_patients_per_year, by = "FinancialYear")
view(patients_per_year_per_sex)

patients_by_sex_proportionate<-full_join(patients_per_year_per_sex, patients_per_year, by = "FinancialYear")
view(patients_by_sex_proportionate)

percentage<- patients_by_sex_proportionate%>%
  mutate(male_percentage = male_patients_per_year / patients_per_year*100)
percentage<-percentage%>%
  mutate(female_percentage = female_patients_per_year / patients_per_year*100)
view(percentage)

comparison_psychos_by_sex<- percentage%>%
  summarise(avg_female_percentage= mean(female_percentage),avg_male_percentage= mean(male_percentage) )
view(comparison_psychos_by_sex)

ratio_men_women_psychos<- comparison_psychos_by_sex%>%
  mutate(ratio=avg_male_percentage/avg_female_percentage)
view(ratio_men_women_psychos)

child_patients_per_year<- summarise((group_by (select(filter(patients_by_age_yearly, AgeGroup== "0-17 years"), FinancialYear, PatientsCount), FinancialYear)), child_patients_per_year= sum (PatientsCount) )
view(child_patients_per_year)

young_adult_patients_per_year<- summarise((group_by (select(filter(patients_by_age_yearly, AgeGroup== "18-24 years"), FinancialYear, PatientsCount), FinancialYear)), young_adult_patients_per_year= sum (PatientsCount) )
view(young_adult_patients_per_year)

medium_adult_patients_per_year<- summarise((group_by (select(filter(patients_by_age_yearly, AgeGroup== "25-39 years"), FinancialYear, PatientsCount), FinancialYear)), medium_adult_patients_per_year= sum (PatientsCount) )
view(medium_adult_patients_per_year)

middle_aged_patients_per_year<- summarise((group_by (select(filter(patients_by_age_yearly, AgeGroup== "40-64 years"), FinancialYear, PatientsCount), FinancialYear)), middle_aged_patients_per_year= sum (PatientsCount) )
view(middle_aged_patients_per_year)

elderly_patients_per_year<- summarise((group_by (select(filter(patients_by_age_yearly, AgeGroup== "65plus years"), FinancialYear, PatientsCount), FinancialYear)), elderly_patients_per_year= sum (PatientsCount) )
view(elderly_patients_per_year)

agegroups <- full_join(child_patients_per_year, young_adult_patients_per_year, by = "FinancialYear") %>%
  full_join(medium_adult_patients_per_year, by= "FinancialYear")%>%
  full_join(middle_aged_patients_per_year, by="FinancialYear")%>%
  full_join(elderly_patients_per_year, by = "FinancialYear")%>%
  full_join(patients_per_year, by = "FinancialYear")
view(agegroups)

ggplot(data=patients_by_age_yearly,
       mapping=aes(x= patients_per_year, y= FinancialYear), na.rm=TRUE, size = patients_per_year)+
  geom_point()+
  facet_wrap(~AgeGroup, ncol=3)

