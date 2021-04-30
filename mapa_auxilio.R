#### AULA MAPA AUXÍLIO EMERGENCIAL  ###


## Pacotes ##

library(tidyverse)
library(geobr)


## Arquivos ##

auxilio <- read.csv("auxilio_2020.csv")

mean(mapa_auxilio$auxilio_pc)

mapa_auxilio <- left_join(mapa_magnitude, auxilio, by = c("code_muni" = "id_municipio"))


mapa_auxilio <- left_join(mapa_auxilio, Variaveis_externas_munic_2018, by = c("code_muni" = "IBGE7"))


## criar variável auxilio per capita ##

mapa_auxilio <- mapa_auxilio %>% 
  mutate(auxilio_pc = f0_ / POP_EST )



## Produzir o mapa ##

mapa_auxilio %>% 
  ggplot()+
  geom_sf(aes(fill = auxilio_pc), col = NA)+
  geom_sf(data = estado, alpha = 0, col = "#595959")+
  scale_fill_continuous(high = "#132B43", low = "#56B1F7")+
  theme_classic()+
 
  labs(title = "Auxílio emergencial per capita por município em 2020",
       fill = "")+
  theme(legend.position = "bottom",
        plot.title = element_text(size = 28))
  

