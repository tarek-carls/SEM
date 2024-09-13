library(tidyverse)
df <- haven::read_dta("Audi_t1_t2_t3_t4_t5_full.dta")


dfx <- df %>% 
  select(
    Bout_t1,Psysa_t1,Recov_t1,Detach_t1,bout_1_t1,bout_2_t1,bout_3_t1,bout_4_t1,
    psysa_1_t1,psysa_2_t1,psysa_3_t1,psysa_4_t1,
    recov_1_t1,recov_2_t1,recov_3_t1,recov_4_t1,
    age_t1,sex_t1,OE_t1,QID_t1
  ) %>% 
  rename(
    cluster_id = OE_t1
  )

dft <- dfx %>% 
  group_by(cluster_id) %>% 
  summarise(
    age_sd = sd(age_t1,na.rm=T)
  )

dfx <- full_join(dft,dfx,by="cluster_id")
dfx <- dfx[1:1000,] %>% 
  na.omit()

write.csv(dfx,file="test.csv")
