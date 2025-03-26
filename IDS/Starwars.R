starwars %>%
  select (species, height) %>%
  mutate (species_group = case_when(
    species == "Human" ~ "Human",
    species == "Droid" ~ "Droid",
    TRUE ~ "Other" )) %>%
  group_by(species_group) %>%
  summarise (
    count = n(),
    avg_height = mean(height, na.rm = TRUE))
  
  
mutate(starwars, 
       bmi = 10000 * mass / height^2,
       species_grp = 
         case_when(
           species == "Human" ~ "Human",
           species == "Droid" ~ "Droid",
           TRUE ~ "Other"
         ))

library(tidyverse)
us_rent_income %>% filter (variable == "income") %>% select (estimate)%>%
  mutate (avgmoe = mean (estimate, na.rm = TRUE))

my_list <- list(
  item1 = seq(from = 0, to = 10, by = 2),
  item2 = c("variable", "estimate", "moe"),
  item3 = c(TRUE, FALSE),
  item4 = diag(3)
)

library(tidyverse)
household %>% count (is.na = TRUE)

sum(is.na(household))
