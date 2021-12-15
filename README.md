<h1> Previsão da Taxa de desocupação no Brasil </h1>

<h3>➡ Sobre o projeto... </h3>

Frequentemente noticiada, a taxa de desocupação se tornou de grande preocupação no contexto atual do Brasil. Segundo notícia da [Folha de São Paulo](https://www1.folha.uol.com.br/mercado/2021/11/desemprego-no-brasil-e-o-dobro-da-media-mundial-em-ranking-de-mais-de-40-paises.shtml), 
publicada em agosto de 2021, a taxa de desemprego (desocupação) no País é o dobro da média internacional. Além disso, a taxa de desocupação brasileira é a quarta maior de uma lista de 43 economias.
Dessa forma, a fim de conhecer mais o problema, eu fiz uma análise da série temporal da taxa de desocupação.

#

<h3>➡ Objetivos do projeto </h3>

- Analisar a taxa de desocupação no Brasil;
- Propor um modelo que consiga descrever a série da taxa de desocupação;
- Prever os valores da taxa de desocupação para os próximos meses.

#

<h3>➡ Séries temporais </h3>

- Uma série temporal é uma coleção de observações feitas sequencialmente ao longo do tempo;
- Uma característica importante das séries temporais é a estacionariedade. Quando uma série apresenta média, variância e autocorrelação constantes ao longo do tempo, ela pode ser dita estacionária;
- Componentes como tendência, sazonalidade e ciclo são uma forma de caracterizar a série;
- Uma série temporal pode ser aditiva ou multiplicativa; 
- Existem dois modelos muito comuns para previsão: os modelos de Alisamento Exponencial e os modelos Arima.

#

<h3>➡ Análise da série de taxa de desocupação </h3>

A taxa de desocupação esteve em aumento ao longo dos anos. Entre os anos de 2015 e 2017 houve um forte aumento desta taxa. Durante os anos em análise observou- se um 
comportamento sazonal, em que nos últimos meses do ano a taxa de desocupação diminui. É possível que ocorra essa variação na taxa pela grande oferta de empregos temporários 
no final de ano. 

<p align="center">
  <img src="https://github.com/tsthais/Tx_Desocupa-o_BR/blob/main/im1.png" />
</p>

Para estudar melhor a sazonalidade foi elaborado um gráfico da taxa de desocupação por meses do ano. Com base nesta figura é possível verificar que o número médio da taxa 
de desocupação diminui nos últimos meses do ano. Além disso, pelas linhas verticais nota- se mudanças na variabilidade da taxa ao longo do ano. Dessa forma, pode- se 
inferir que essa série não é estacionária, já que sua média e variabilidade não são constantes.


<p align="center">
  <img src="https://github.com/tsthais/Tx_Desocupa-o_BR/blob/main/im2.png" />
</p>

Em dezembro de 2013 foi observada a menor taxa de desocupação do período estudado, 5,9% e a maior, em março de 2021, 15,1%. A série é fortemente afetada pela componente 
de tendência, a sazonalidade também está presente. Como a sazonalidade parece ser constante, essa série pode ser considerada aditiva. Ademais, os erros apresentam resquícios
de sazonalidade.

<p align="center">
  <img src="https://github.com/tsthais/Tx_Desocupa-o_BR/blob/main/im3.png" />
</p>


Fazendo todo o tratamento da série para que ela se tranforme em uma série estacionária, foi possível obter um modelo Arima Sazonal com parâmetros (0,1,3)x(0,1,1). A respeito 
deste modelo, os erros seguem distribuição Gaussiana, são estacionários e tem variação constante; atendendo, assim, todos os requisitos diagnósticos propostos. Utilizando este
modelo como base, a previsão da taxa de desocupação foi feita para os próximos 18 meses. A figura abaixo apresenta esta previsão.

<p align="center">
  <img src="https://github.com/tsthais/Tx_Desocupa-o_BR/blob/main/im7.png" />
</p>

Com base nesta previsão, a taxa de desocupação continuará caindo até o final do ano de 2021. Um aumento é previsto já nos primeiros meses de 2022, seguido de uma queda até o final 
deste ano.


