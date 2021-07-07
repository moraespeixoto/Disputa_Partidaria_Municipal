
library(tidyverse)


### Trazer dados Variaveis Externas 2019 ###

var_externa <- read_csv("var_externa_2019.csv") %>% 
  mutate(CLASSE_POP = str_sub(`CLASSE POP`, 1, 2),
         CAT_POP = str_sub(`CLASSE POP`, 5, 35),
         Regiao = str_sub(REGIAO, 5, 18))


### Abrir banco vacinação ###

url <- "https://s3-sa-east-1.amazonaws.com/ckan.saude.gov.br/PNI/vacina/uf/2021-05-04/uf%3DRJ/part-00000-88e7add3-b2f7-480f-815a-7ae9f8b55aad.c000.csv"
download.file(url)

vacinacao <- read_csv2("part-00000-88e7add3-b2f7-480f-815a-7ae9f8b55aad.c000.csv")



vacina_campos <- vacinacao %>% 
  filter(estabelecimento_municipio_codigo == 330100)

