doladowania<-read.csv("dol_1.csv", sep="\t")
rownames(doladowania) = doladowania[,1]
doladowania<-doladowania[, "ILE_NUMEROW", drop=FALSE]

library(xts)
doladowania.ts<-as.xts(doladowania)


?xts
temp<-as.date(doladowania[,"DZIEN"])
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
