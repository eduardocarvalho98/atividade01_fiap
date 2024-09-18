library(kableExtra)
library(httr)
library(jsonlite)

# 1. Ler o arquivo CSV com os dados de culturas
df <- read.csv("C:\\Users\\dzn1\\PycharmProjects\\pythonProject\\.venv\\Scripts\\Projeto_Atv01\\dados_culturas.csv", 
               header = TRUE, sep = ",")

# Verificar os nomes das colunas
print("Nomes das colunas:")
print(names(df))

# 3. Filtrar por cultura "Soja" e calcular métricas específicas
df_soja <- subset(df, Cultura == "Soja")
print("Dados para a cultura Soja:")
print(df_soja)

# Cálculos para Soja
media_area_soja <- mean(df_soja$Area..m2., na.rm = TRUE)
media_cloreto_soja <- mean(df_soja$Qtd.Cloreto.Kg., na.rm = TRUE)
desvio_area_soja <- sd(df_soja$Area..m2., na.rm = TRUE)
desvio_cloreto_soja <- sd(df_soja$Qtd.Cloreto.Kg., na.rm = TRUE)

# 4. Filtrar por cultura "Cacau" e calcular métricas específicas
df_cacau <- subset(df, Cultura == "Cacau")
print("Dados para a cultura Cacau:")
print(df_cacau)

# Cálculos para Cacau
media_area_cacau <- mean(df_cacau$Area..m2., na.rm = TRUE)
media_cloreto_cacau <- mean(df_cacau$Qtd.Cloreto.Kg., na.rm = TRUE)
desvio_area_cacau <- sd(df_cacau$Area..m2., na.rm = TRUE)
desvio_cloreto_cacau <- sd(df_cacau$Qtd.Cloreto.Kg., na.rm = TRUE)

# 5. Calcular a média e o desvio padrão da Área e Cloreto de Potassio para todas as culturas (geral)
media_area_total <- mean(df$Area..m2., na.rm = TRUE)
media_cloreto_total <- mean(df$Qtd.Cloreto.Kg., na.rm = TRUE)
desvio_area_total <- sd(df$Area..m2., na.rm = TRUE)
desvio_cloreto_total <- sd(df$Qtd.Cloreto.Kg., na.rm = TRUE)

# Exibir os resultados gerais no console
print(paste("Média da Área (geral):", media_area_total))
print(paste("Média do Cloreto de Potassio (geral):", media_cloreto_total))
print(paste("Desvio padrão da Área (geral):", desvio_area_total))
print(paste("Desvio padrão do Cloreto de Potassio (geral):", desvio_cloreto_total))

# 6. Exibir os dados originais e os resultados de forma organizada e bonita com kableExtra

# Criar a tabela com os dados originais
tabela_original <- kable(df, format = "html", caption = "Dados Originais das Culturas") %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive"))

# Criar a tabela com os resultados
resultados <- data.frame(
  Cultura = c("Soja", "Cacau", "Geral"),
  Media_Area = c(media_area_soja, media_area_cacau, media_area_total),
  Media_Cloreto = c(media_cloreto_soja, media_cloreto_cacau, media_cloreto_total),
  Desvio_Area = c(desvio_area_soja, desvio_area_cacau, desvio_area_total),
  Desvio_Cloreto = c(desvio_cloreto_soja, desvio_cloreto_cacau, desvio_cloreto_total)
)

# Criar a tabela formatada com kableExtra para os resultados
tabela_resultados <- kable(resultados, format = "html", caption = "Médias e Desvios por Cultura") %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive")) %>%
  column_spec(2, bold = TRUE, color = "blue") %>%  # Coluna de Média da Área em negrito e azul
  row_spec(0, bold = TRUE, background = "lightgray") %>%  # Cabeçalho em negrito com fundo cinza claro
  add_header_above(c(" ", "Métricas da Área" = 2, "Métricas do Cloreto" = 2))  # Agrupar cabeçalhos

# Exibir as tabelas
print(tabela_original)
print(tabela_resultados)

# Parte da API
# Definir a chave da API
api_key <- "e8d58b7f450c5620c483f1cab9aa8367"

# Definir a cidade
cidade <- "Fortaleza"

# Construir a URL da API
url <- paste0("http://api.openweathermap.org/data/2.5/weather?q=", cidade, "&appid=", api_key, "&units=metric&lang=pt_br")

resposta <- GET(url)

# Verificar o status da resposta
if (status_code(resposta) == 200) {
  # Parsear os dados JSON retornados
  dados_climaticos <- fromJSON(content(resposta, "text"), flatten = TRUE)
  
  # Exibir a estrutura dos dados para depuração
  str(dados_climaticos)
  
  # Acesso seguro aos dados climáticos
  temperatura <- dados_climaticos$main$temp
  descricao <- dados_climaticos$weather[1, "description"]
  umidade <- dados_climaticos$main$humidity
  vento <- dados_climaticos$wind$speed
  
  # Exibir as informações no terminal
  cat("Informações meteorológicas para", cidade, ":\n")
  cat("Temperatura atual:", temperatura, "°C\n")
  cat("Descrição:", descricao, "\n")
  cat("Umidade:", umidade, "%\n")
  cat("Velocidade do vento:", vento, "m/s\n")
} else {
  # Caso a requisição falhe, exibir a mensagem de erro
  cat("Erro ao obter dados meteorológicos. Verifique a chave da API ou a cidade.")
}
