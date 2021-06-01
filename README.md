
# R_project

1.Moje wybrane produkty:
1)	Jeansy
2)	Ryż
3)	Ciepła woda za m3
4)	Piwo
5)	Czekolada
2.Podczas pracy korzystałem z takich bibliotek

install.packages("httr")
install.packages("rjson")
install.packages("xml2")
install.packages("jsonlite")

library(httr)
library(rjson)
library(xml2)
library(jsonlite)

3.Dokonałem połączenia Po API i pobrałem potrzebne dane z GUSU
apiKey <- "1A6B2AB1-0DF0-4DAC-74A3-07D7C07FC3BE"
result <- GET("https://bdl.stat.gov.pl/api/v1/data/by-variable/3643?",
              add_headers(Authorization = paste("temat", apiKey)))
tutaj sprawdzam, czy połączenie działa, jeśli skrypt wypluje nam inną wartość niż 200 tzn, że mamy błąd.

result$status_code

Id wybranych produktow 387718,387464,387282,387500, 387391/567453
Pobieranie wartosci i podmiana na dataframe 

ryz<-"https://bdl.stat.gov.pl/api/v1/data/by-variable/387718?unit-level=2&page=0&page-size=100"
ramka <- fromJSON(ryz)
ryz<-as.data.frame(ramka[6])
piwo <-"https://bdl.stat.gov.pl/api/v1/data/by-variable/387464?unit-level=2&page=0&page-size=100"
ramka <- fromJSON(piwo)
piwo<-as.data.frame(ramka[6])
ciepla_woda <- "https://bdl.stat.gov.pl/api/v1/data/by-variable/387282?unit-level=2&page=0&page-size=100"
ramka <- fromJSON(ciepla_woda)
ciepla_woda<-as.data.frame(ramka[6])
czekolada <- "https://bdl.stat.gov.pl/api/v1/data/by-variable/387500?unit-level=2&page=0&page-size=100"
ramka <- fromJSON(czekolada)
czekolada<-as.data.frame(ramka[6])
jeansy_1 <- "https://bdl.stat.gov.pl/api/v1/data/by-variable/387391?unit-level=2&page=0&page-size=100"
ramka <- fromJSON(jeansy_1)
jeansy_1<-as.data.frame(ramka[6])
jeansy_2 <-"https://bdl.stat.gov.pl/api/v1/data/by-variable/567453?unit-level=2&page=0&page-size=100"
ramka <- fromJSON(jeansy_2)
jeansy_2<-as.data.frame(ramka[6])
jeansy_1 <- "https://bdl.stat.gov.pl/api/v1/data/by-variable/387391?unit-level=2&page=0&page-size=100"
ramka <- fromJSON(jeansy_1)
jeansy_1<-as.data.frame(ramka[6])
4. moje problemy podczas tworzenia projektu. 


Podczas importu danych przez API jeansy z GUSU były podzielone jako 2 produkty jeden gdzie dane były od (2006-2017) i drugi gdzie dane były od (2018-2019). Problem polegał na mergowaniu tych dwóch dataframe’ow i zgranie,poradziłem sobie z tym problemem i zrobiłem to w pętli:
x<-0
while(x<=15){
x<-x+1
jeansy_full2[[3]][[x]] <- rbind(jeansy_1[[3]][[x]], jeansy_2[[3]][[x]])
}


Kolejny problem był z obliczeniem średniej i utworzenie osobnych 16 dataframe’ow dla każdego z województw


malopolska<-data.frame(year=2006:2019)
malopolska$wartosci<-(ost4[[3]][[1]][2]+ost4[[4]][[1]][2]+ost4[[5]][[1]][2]+ost4[[6]][[1]][2]+ost4[[7]][[1]][2])/5
slaskie<-data.frame(year=2006:2019)
slaskie$wartosci <-(ost4[[3]][[2]][2]+ost4[[4]][[2]][2]+ost4[[5]][[2]][2]+ost4[[6]][[2]][2]+ost4[[7]][[2]][2])/5
lubuskie<-data.frame(year=2006:2019)
lubuskie$wartosci <-(ost4[[3]][[3]][2]+ost4[[4]][[3]][2]+ost4[[5]][[3]][2]+ost4[[6]][[3]][2]+ost4[[7]][[3]][2])/5
wielkopolskie<-data.frame(year=2006:2019)
wielkopolskie$wartosci <-(ost4[[3]][[4]][2]+ost4[[4]][[4]][2]+ost4[[5]][[4]][2]+ost4[[6]][[4]][2]+ost4[[7]][[4]][2])/5
zachodnio_pomorskie<-data.frame(year=2006:2019)
zachodnio_pomorskie$wartosci <-(ost4[[3]][[5]][2]+ost4[[4]][[5]][2]+ost4[[5]][[5]][2]+ost4[[6]][[5]][2]+ost4[[7]][[5]][2])/5
dolno_slaskie<-data.frame(year=2006:2019)
dolno_slaskie$wartosci<-(ost4[[3]][[6]][2]+ost4[[4]][[6]][2]+ost4[[5]][[6]][2]+ost4[[6]][[6]][2]+ost4[[7]][[6]][2])/5
opolskie<-data.frame(year=2006:2019)
opolskie$wartosci <-(ost4[[3]][[7]][2]+ost4[[4]][[7]][2]+ost4[[5]][[7]][2]+ost4[[6]][[7]][2]+ost4[[7]][[7]][2])/5
Kujawsko_pomorskie<-data.frame(year=2006:2019)
Kujawsko_pomorskie$wartosci <-(ost4[[3]][[8]][2]+ost4[[4]][[8]][2]+ost4[[5]][[8]][2]+ost4[[6]][[8]][2]+ost4[[7]][[8]][2])/5
pomorskie<-data.frame(year=2006:2019)
pomorskie$wartosci <-(ost4[[3]][[9]][2]+ost4[[4]][[9]][2]+ost4[[5]][[9]][2]+ost4[[6]][[9]][2]+ost4[[7]][[9]][2])/5
warminsko_mazurskie<-data.frame(year=2006:2019)
warminsko_mazurskie$wartosci <-(ost4[[3]][[10]][2]+ost4[[4]][[10]][2]+ost4[[5]][[10]][2]+ost4[[6]][[10]][2]+ost4[[7]][[10]][2])/5
lodzkie<-data.frame(year=2006:2019)
lodzkie$wartosci <-(ost4[[3]][[11]][2]+ost4[[4]][[11]][2]+ost4[[5]][[11]][2]+ost4[[6]][[11]][2]+ost4[[7]][[11]][2])/5
swietokrzyskie<-data.frame(year=2006:2019)
swietokrzyskie$wartosci <-(ost4[[3]][[12]][2]+ost4[[4]][[12]][2]+ost4[[5]][[12]][2]+ost4[[6]][[12]][2]+ost4[[7]][[12]][2])/5
lubelskie<-data.frame(year=2006:2019)
lubelskie$wartosci <-(ost4[[3]][[13]][2]+ost4[[4]][[13]][2]+ost4[[5]][[13]][2]+ost4[[6]][[13]][2]+ost4[[7]][[13]][2])/5
podkarpackie<-data.frame(year=2006:2019)
podkarpackie$wartosci <-(ost4[[3]][[14]][2]+ost4[[4]][[14]][2]+ost4[[5]][[14]][2]+ost4[[6]][[14]][2]+ost4[[7]][[14]][2])/5
podlaskie<-data.frame(year=2006:2019)
podlaskie$wartosci <-(ost4[[3]][[15]][2]+ost4[[4]][[15]][2]+ost4[[5]][[15]][2]+ost4[[6]][[15]][2]+ost4[[7]][[15]][2])/5
mazowieckie<-data.frame(year=2006:2019)
mazowieckie$wartosci <-(ost4[[3]][[16]][2]+ost4[[4]][[16]][2]+ost4[[5]][[16]][2]+ost4[[6]][[16]][2]+ost4[[7]][[16]][2])/5


Średnie 5 produktów w poszczególnych województwach i ich rosnąca tendencja

![1](https://user-images.githubusercontent.com/49531926/120366324-cdd2c480-c30f-11eb-848d-8187c1050bea.png)

Jak widzimy średnia cen największa jest w woj. Mazowieckim natomiast najmniejsza średnia cen występuje w woj. Zachodnio-Pomorskim.
 
![2](https://user-images.githubusercontent.com/49531926/120366359-daefb380-c30f-11eb-9f32-07eaed7e1989.png)
