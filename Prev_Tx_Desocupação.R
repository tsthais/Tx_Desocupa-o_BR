# Análise da taxa de desocupação no Brasil 

# Bibliotecas utilizadas
pacotes <- c('readxl','tseries','forecast',
             'ggplot2', 'patchwork', 'gridExtra')

lapply(pacotes, library, character.only = T)

# Leitura de dados utilizando uma função do pacote readxl
dados <- read_excel("SeriesMensalizadasPnadContinua_Jan2012aAgo2021.xlsx", skip = 4)

# Selecionando as colunas 1 e 39, com os dados de mês/ano e taxa de desocupação
dados <- dados[,c(1,39)]

# Renomeando as colunas da base dados
names(dados) <- c("mes_ano", "tx_desocupacao")

# Transformando o banco de dados para o formato de série temporal

desocupacao <- ts(dados[,2], start = c(2012,1), frequency = 12)

# Gráfico da taxa de desocupação no Brasil

autoplot(desocupacao, size = .8, alpha = .8)+
  theme_light()+
  labs(title = "Taxa de desocupação. Brasil, 2012 a 2021",
       x = "Ano", y= "Taxa de desocupação")+
  theme(plot.subtitle = element_text(color = 'gray', 
                                     size = 10,    
                                     face = 'bold'))

# Gráfico de meses para estudo da sazonalidade da série

ggmonthplot(desocupacao) +
  theme_minimal()+
  labs(title = "Sazonalidade da série de taxa de desocupação. Brasil, 2012 a 2021",
       x = "Meses", y= "Taxa de desocupação")+
  theme(plot.subtitle = element_text(color = 'gray', 
                                     size = 10,    
                                     face = 'bold'))

# Decomposição aditiva da série

decompose(desocupacao) %>% 
  autoplot()+
  theme_light() +
  labs(title = "Decomposição da série de Taxa de desocupação", x="Ano")

# Gráfico de autocorrelação da série

acf <- ggAcf(desocupacao)+
  labs(title = "ACF da série de Taxa de desocupação. Brasil, 2012 a 2021")+
  theme_light() 

# Gráfico de autocorrelação parcial da série

pacf <- ggPacf(desocupacao)+
  labs(title = "PACF da série de Taxa de desocupação. Brasil, 2012 a 2021")+
  theme_light() 

grid.arrange(arrangeGrob(acf,
                         pacf, 
                         nrow = 2))

# Teste de raiza unitária

ndiffs(desocupacao)

# Diferenciando a série

dif_desocupacao <- diff(desocupacao)

# Não precisa de mais uma diferenciação para tendência

ndiffs(dif_desocupacao)

# Precisa de uma diferenciação sazonal

nsdiffs(dif_desocupacao)

# Diferenciando a série

dif_desocupacao <- diff(dif_desocupacao)

# Não é mais necessário diferenciar a série

ndiffs(dif_desocupacao)
nsdiffs(dif_desocupacao)

# Gráfico da série diferenciada (estacionária)

autoplot(dif_desocupacao, size = .8, alpha = .8)+
  theme_light()+
  labs(title = "Taxa de desocupação. Brasil, 2012 a 2021",
       x = "Ano", y= "Taxa de desocupação")+
  theme(plot.subtitle = element_text(color = 'gray', 
                                     size = 10,    
                                     face = 'bold'))

# Gráfico de autocorrelação da série diferenciada

acf <- ggAcf(dif_desocupacao)+
  labs(title = "ACF da série de Taxa de desocupação diferenciada. Brasil, 2012 a 2021")+
  theme_light() 

# Gráfico de autocorrelação parcial da série diferenciada

pacf <- ggPacf(dif_desocupacao)+
  labs(title = "PACF da série de Taxa de desocupação diferenciada. Brasil, 2012 a 2021")+
  theme_light() 

grid.arrange(arrangeGrob(acf,
                         pacf, 
                         nrow = 2))
# SARIMA(0,1,3)x(0,1,1)

mod <- arima(desocupacao, order = c(0,1,3), seasonal = c(0,1,1),
             include.mean = F)

# Resíduos do modelo

erros <- mod$residuals

# Gráfico dos resíduos

erros_plot <- autoplot(erros)+
  labs(title = "Gráfico dos erros")+
  theme_light()

# ACF dos erros

acf_erro <- ggAcf(erros) +
  labs(title = "ACF")+
  theme_light()

# PACF dos erros

pacf_erro <- ggPacf(erros) +
  labs(title = "PACF")+
  theme_light()

# Gráfico de quantis

qqplot.data <- function (vec) # argument: vector of numbers
{
  # following four lines from base R's qqline()
  y <- quantile(vec[!is.na(vec)], c(0.25, 0.75))
  x <- qnorm(c(0.25, 0.75))
  slope <- diff(y)/diff(x)
  int <- y[1L] - slope * x[1L]
  
  d <- data.frame(resids = vec)
  
  ggplot(d, aes(sample = resids)) + stat_qq() + geom_abline(slope = slope, intercept = int)
  
}

qq_erro <- qqplot.data(erros) +
  labs(title = "Gráfico de quantis")+
  theme_light()

grid.arrange(arrangeGrob(erros_plot,
                         qq_erro,
                         acf_erro, 
                         pacf_erro,
                         nrow = 2), 
             top = textGrob("Gráfico 11: Diagnóstico dos Resíduos do Modelo 3"))

# Testes

kpss.test(erros) # kpss
Box.test(erros, lag = 20, type = 'Ljung-Box', fitdf = 2) # box
shapiro.test(erros) # shapiro

# Gráfico de previsão

mod %>% forecast(h=18, level = 95) %>% 
  autoplot() + theme_light()+
  theme(legend.position = "bottom",  
        plot.subtitle = element_text(color = 'gray', 
                                     size = 10,
                                     face = 'bold'), 
        plot.caption = element_text(hjust=c(0)))+
  labs(title = "Previsão da série de taxa de desocupação. Brasil", 
       caption = "Nota: Considerou- se o modelo Sarima com parâmetros (0,1,3)x(0,1,1) e 95% de confiabilidade na previsão.", 
       y = "Taxa de desocupação", x = "Ano")
