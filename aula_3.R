##########   AULA 3 - PERFIL MUNICIPAL #########

#### Pacotes ####

library(tidyverse)
library(geobr)
library(ggthemes)
library(rgl)

#### Roteiro  ####

### 0 - Explorar sites com bancos de dados de 2ª geração

## IBGE

("https://www.ibge.gov.br/estatisticas/sociais/saude/10586-pesquisa-de-informacoes-basicas-municipais.html?edicao=25506&t=o-que-e")

## IPEADATA

("http://ipeadata.gov.br/beta3/")

## IBAM

("http://municipios.ibam.org.br/")


## Meu município 



### 1 - Visitar site do TSE 


("https://www.tse.jus.br/eleicoes/estatisticas/repositorio-de-dados-eleitorais-1")


## objetivo => baixar arquivos de manigitude dos distritos para vereador

## comparar Câmaras Municipais entre 2008 e 2012


### 2 - Explorar basedosdados.org

## objetivo => baixar arquivos unificados de vagas para vereador

## relacionar tabelas e produzir os mapas




### Abrir arquivo de códigos ###

cod <- read.csv("codigos.csv")


## Baixar arquivo com magnitudes do bigquery

SELECT * 
  FROM `basedosdados.br_tse_eleicoes.vagas` 
WHERE cargo = 'vereador'

## abre arquivo long do bigquery

magnitude <- read.csv("magnitude.csv")

## cria banco wide

magnitude_wider <- magnitude %>% 
  pivot_wider(values_from = vagas, names_from = ano) %>% 
  rename(m_2000 = '2000',
         m_2004 = '2004',
         m_2008 = '2008',
         m_2012 = '2012',
         m_2016 = '2016',
         m_2020 = '2020'
         )

## cria variavel das diferenças

magnitude_wider <- magnitude_wider %>% 
  mutate(dif_12_08 = m_2012 - m_2008,
         dif_16_12 = m_2016 - m_2012)





### baixar o shape do geobr

mun <- read_municipality(code_muni = "all", year = 2020)

estado <- read_state(code_state = "all")

## unificar tabelas 

magnitude_wider <- left_join(magnitude_wider, cod, by = "id_municipio_tse")

mapa_magnitude <- left_join(mun, magnitude_wider, by = c("code_muni" = "id_municipio"))


mapa_magnitude %>% 
  ggplot()+
  geom_sf(aes(fill = dif_12_08), col = "NA")+
  geom_sf(data = estado, alpha = 0, color = "BLACK" )+
  scale_fill_distiller(direction = 1)
  

### Construir tabela ###


tab <- magnitude %>% 
  group_by(ano) %>% 
  count(vagas) %>% 
  pivot_wider(values_from = n, names_from = ano)




## Elemento institucional


# Art. 29 da CF/88 original

Art. 29. O Município reger-se-á por lei orgânica, votada em dois turnos, com o interstício mínimo de dez dias, e aprovada por dois terços dos membros da Câmara Municipal, que a promulgará, atendidos os princípios estabelecidos nesta Constituição, na Constituição do respectivo Estado e os seguintes preceitos:
  
 IV - número de Vereadores proporcional à população do Município, observados os seguintes limites:
  a) 	mínimo de nove e máximo de vinte e um nos Municípios de até um milhão de habitantes;
b) 	mínimo de trinta e três e máximo de quarenta e um nos Municípios de mais de um milhão e menos de cinco milhões de habitantes;
c) 	mínimo de quarenta e dois e máximo de cinqüenta e cinco nos Municípios de mais de cinco milhões de habitantes; ""

# resolucao TSE de abril de 2004  (Ministério Público X Municipio de Mira Estrela - SP)

https://www.tse.jus.br/legislacao-tse/res/2004/RES217022004.html


# emenda constitucional de 2009 (restabelece os critérios)
http://www.planalto.gov.br/ccivil_03/constituicao/emendas/emc/emc58.htm

https://ambitojuridico.com.br/cadernos/direito-constitucional/a-controversia-da-fixacao-do-numero-de-vereadores-pelo-tribunal-superior-eleitoral/