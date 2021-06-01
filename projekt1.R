#instalowanie potrzebnych bibliotek

install.packages("httr")
install.packages("rjson")
install.packages("xml2")
install.packages("jsonlite")

library(httr)
library(rjson)
library(xml2)
library(jsonlite)

#polaczenie do API
apiKey <- "1A6B2AB1-0DF0-4DAC-74A3-07D7C07FC3BE"
result <- GET("https://bdl.stat.gov.pl/api/v1/data/by-variable/3643?",
              add_headers(Authorization = paste("temat", apiKey)))
#sprawdzanie czy API dziala jesli api dziala wyrzuci wartosc 200 kazda inna wartosc mowi nam ze jest jakis blad

result$status_code

#Wywoanie metoda GET danych za pomoca REST API
#k15
#g188
#P2917
#nazwy  wybranych przezemnie produktow Ryż , piwo jasne pelne, ciepla woda za 1ma3, czekolada mleczna za 100g spodnie (6-11lat) typu jeans

# id wybranych produktow 387718,387464,387282,387500, 387391(raczej ta wartosc: 567453)

# sprawdzanie id przedmiotow ktore wybralem do projektu
url_bazy <- "https://bdl.stat.gov.pl/api/v1/Variables?subject-id=P2917&page=1&page-size=100"
siemano <- GET(url_bazy)
str(content(siemano))

#pobieranie wartosci i podmiana na dataframe :)
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

#laczenie jeansow!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
jeansy_full2 <-jeansy_1
x<-0
while(x<=15){
x<-x+1
jeansy_full2[[3]][[x]] <- rbind(jeansy_1[[3]][[x]], jeansy_2[[3]][[x]])
}

#jeansy_full2
#piwo
#ryz
#czekolada
#ciepla_woda
#funkcja mergujaca wszystkie przedmioty w calosc

ost4<-data.frame()
ost4 <- merge(jeansy_full2, piwo, by = c("results.id","results.name"),  suffix = c("_jeansy","_piwo"))
ost4 <- merge(ost4, ryz, by = c("results.id","results.name"),  suffix = "_ryzusiek")
ost4 <- merge(ost4, czekolada, by = c("results.id","results.name"), suffix = "_czekolada") 
ost4 <- merge(ost4, ciepla_woda, by = c("results.id","results.name"), suffix = "_ciepla.woda") 
#ost4 to ostateczny dataframe z latami i cenami w poszczegolnych latach
ost4
#przypisywanie danych do wojewodztw

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

woj<-list(malopolska,slaskie,lubuskie,wielkopolskie,zachodnio_pomorskie,dolno_slaskie,opolskie,Kujawsko_pomorskie,
                 pomorskie,warminsko_mazurskie,lodzkie,swietokrzyskie,lubelskie,podkarpackie,podlaskie,mazowieckie)
wojewodztwa <- c("Malopolska","Slaskie","Lubuskie","Wielkopolskie","Zachodnio_pomorskie","Dolno_slaskie","Opolskie","Kujawsko_pomorskie",
                 "Pomorskie","Warminsko_mazurskie","Lodzkie","Swietokrzyskie","Lubelskie","Podkarpackie","Podlaskie","Mazowieckie")
attach(mtcars)
par(mfrow=c(4,4))
x<-1
for(i in woj){
plot(as.matrix(i), type = "b", pch = 19,
     col = "red", xlab = wojewodztwa[x], ylab = "y", 
     lty = 1, lwd = 1,font=2)
x <- x+1
}
par(mfrow=c(2,1))
plot(as.matrix(mazowieckie), type = "b", pch = 19,
     col = "red", xlab = "Mazowieckie", ylab = "y", 
     lty = 1, lwd = 1,font=2)

plot(as.matrix(zachodnio_pomorskie), type = "b", pch = 19,
     col = "red", xlab = "Zachodnio_pomorskie", ylab = "y", 
     lty = 1, lwd = 1,font=2)