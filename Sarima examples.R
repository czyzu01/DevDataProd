doladowania<-read.csv("dol_1.csv", sep="\t")
rownames(doladowania) = doladowania[,1]
doladowania<-doladowania[, "COUNT", drop=FALSE]

library(xts)
doladowania.ts<-as.xts(doladowania)


?xts
temp<-as.date(doladowania[,"DAY"])
library(lubridate)

plot(doladowania.ts)

library(astsa)
## teoretycznie model z założoną sezonowością tygodniową
doladowania.sarima<-sarima(doladowania.ts,1,0,0,1,0,0,7)

## teoretycznie model z założoną sezonowością tygodniową
doladowania.sarima.monthly<-sarima(doladowania.ts,1,0,0,1,0,0,30)

## teoretycznie model z założoną sezonowością polroczna
doladowania.sarima.monthly<-sarima(doladowania.ts,1,0,0,1,0,0,183)


sarima.for(doladowania.ts,7,1,0,0,1,0,0,7)


library(qcc)

parse_date_time("2014-07-01", "%y-%m-%d")

plot(window(doladowania.ts, end=parse_date_time("2014-07-01", "%y-%m-%d")))

dane_bazowe<-window(doladowania.ts, end=parse_date_time("2014-07-01", "%y-%m-%d"))
dane_testowe<-window(doladowania.ts, start=parse_date_time("2014-07-01", "%y-%m-%d"))

qcc_results<-qcc (data=dane_bazowe, newdata=dane_testowe, type="xbar.one", title="Number of observations", xlab="day")


