# Instalar e carregar o pacote dplyr e tidyr
install.packages("tidyr")
library(tidyr)
library(dplyr)

# Vamos usar os comandos gather() e spread() do pacote tidyr para converter 
# um data frame de formato "largo" para "longo" e vice-versa.

# dataframe largo
# id: Identificador do registro
# data: Data do registro
# valor1: Valor da variável 1
# valor2: Valor da variável 2

# Criar um data frame de formato "largo"
dados <- data.frame(
  id = c(1, 2, 3, 4, 5),
  data = c("2023-07-20", "2023-07-21", "2023-07-22", "2023-07-23", "2023-07-24"),
  valor1 = c(10, 20, 30, 40, 50),
  valor2 = c(20, 40, 60, 80, 100)
)

print(dados)
# Convertendo de formato "largo" para "longo"
# Para converter o data frame de formato "largo" para "longo", podemos usar o 
# comando gather(). O comando gather() usa as seguintes especificações:

# key: Nome da coluna que conterá os nomes das variáveis
# value: Nome da coluna que conterá os valores das variáveis
# id: Colunas que não devem ser incluídas no formato "longo"

# Convertendo de formato "largo" para "longo"
dados_longos <- dados %>%
  gather(key = variavel, value = valor, -id, -data)

# Visualizar as primeiras linhas do dataframe "dados_longos" 
head(dados_longos)

# Convertendo de formato "longo" para "largo"
# Para converter o data frame de formato "longo" para "largo", podemos usar 
# o comando spread(). O comando spread() usa as seguintes especificações:
# key: Nome da coluna que contém os nomes das variáveis
# value: Nome da coluna que contém os valores das variáveis

dados_largos <- dados_longos %>%
  spread(key = variavel, value = valor)

# Visualizar as primeiras linhas do dataframe "dados_largos" 
head(dados_largos)


# Carregue a biblioteca dplyr
library(dplyr)

# Crie um data frame com valores ausentes
vendas_loja <- data.frame(
  data_venda = c("2023-01-01", "2023-01-02", "2023-01-03", "2023-01-04", "2023-01-05"),
  produto = c("A", "B", "A", NA, "C"),
  quantidade = c(10, 15, NA, 20, 25),
  receita = c(100, 150, 200, NA, 250)
)

# Identifique e conte os valores ausentes em cada coluna
valores_ausentes <- colSums(is.na(vendas_loja))
print(valores_ausentes)

print("ola mundo")