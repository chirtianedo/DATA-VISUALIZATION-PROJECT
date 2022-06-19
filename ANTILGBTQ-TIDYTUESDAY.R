
library(pacman)
p_load (tidyverse, tidytuesdayR, ggtext, showtext, janitor, gt, gtExtras, treemap)

Tuesdata<- tidytuesdayR::tt_load('2022-06-07')

list2env(Tuesdata, .GlobalEnv)

head(pride_aggregates)
head(fortune_agg)
head(static_list)

contr_short<- contribution_data_all_states %>%  
  drop_na(Company) %>% 
  select(-c(Comments, `ARCHIVE - Company Manually Determined (May Not Match Pride Sponsors List)`)) %>%
  group_by(State, Company) %>% summarize(Sponsorship = sum(Amount))


contr_short$State <-state.name[match(contr_short$State,state.abb)]


png(filename = "contr_short.png", width = 700, height = 400)
treemap<-treemap(contr_short,
                 index=c("State", "Company"),
                 vSize="Sponsorship",
                 type="index",
                 palette="Reds",
                 title="States with the highest ANTI-LGBTQ sponsors in America",
                 fontsize.title = 25,
                 fontsize.labels=c(20,16), 
                 fontcolor.labels=c("Grey","Black"),    
                 fontface.labels=c(2,2),                 
                 overlap.labels=1,                      
                 inflate.labels=F)

dev.off()