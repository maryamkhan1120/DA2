rm(list=ls())

# Import libraries
library(tidyverse)
library(lspline)
library(cowplot)
library(boot)
library(estimatr)
library(huxtable)
library(stargazer)
library(modelsummary)
install.packages("lspline")
install.packages("cowplot")
install.packages("estimatr")
install.packages("huxtable")
install.packages("stargazer")
getwd()

#import data (state must be as character: it's a mix of double and character in raw)
data_all <- read_csv(paste0("/Users/maryamkhan/Data_Analysis2/morg-2014-emp.csv"), 
                     col_types = cols(.default = "?", 
                                      state = "c"))
janitor::tabyl(data_all$state)

#SELECT OCCUPATION
# keep only two occupation types: Market research analysts and marketing specialists 
#and Computer and Mathematical Occupations
data <- data_all %>% filter(occ2012==0840)

tabulate(data_all$sample)

#gen female variable
#gen wage variables
data <- data %>% mutate(female=as.numeric(sex==2)) %>%
  mutate(w=earnwke/uhours) %>%
  mutate(lnw=log(w)) %>%
  mutate(agesq=age^2)

#SET SAMPLE - Choose one of the occupations!
#Market research analysts and marketing specialists -1
#Computer and Mathematical Occupations-2


write_csv(data,paste("/Users/maryamkhan/Data_Analysis2/","earnings_inference.csv",sep=""))

