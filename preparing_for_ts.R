## tutorial based on
## http://www.stat.pitt.edu/stoffer/tsa3/R_toot.htm

require(astsa) 
data(jj)  # load the data - you don't have to do this anymore with astsa, but you do in general
jj        # print it to the screen

plot(jj, ylab="Earnings per Share", main="J & J") 

plot(jj, type="o", col="blue", lty="dashed")
plot(diff(log(jj)), main="logged and diffed") 

############################################################
x = -5:5                  # sequence of integers from -5 to 5
y = 5*cos(x)              # guess
par(mfrow=c(3,2))         # multifigure setup: 3 rows, 2 cols
#---  plot:
plot(x, main="plot(x)")
plot(x, y, main="plot(x,y)")
#---  plot.ts:
plot.ts(x, main="plot.ts(x)")
plot.ts(x, y, main="plot.ts(x,y)")
#---  ts.plot:
ts.plot(x, main="ts.plot(x)")
ts.plot(ts(x), ts(y), col=1:2, main="ts.plot(x,y)")  # note- x and y are ts objects 

############################################################
## Smooting
par(mfrow=c(1,1))

k = c(.5,1,1,1,.5)            # k is the vector of weights
(k = k/sum(k))       
[1] 0.125 0.250 0.250 0.250 0.125
fjj = filter(jj, sides=2, k)  # ?filter for help [but you knew that already]
plot(jj)
lines(fjj, col="red")         # adds a line to the existing plot
lines(lowess(jj), col="blue", lty="dashed")

############################################################
#Let's difference the logged data and call it dljj. Then we'll play with dljj:
    dljj = diff(log(jj))        # difference the logged data
plot(dljj)                  # plot it (not shown)
shapiro.test(dljj)          # test for normality 


############################################################
#Now a histogram and a Q-Q plot, one on top of the other (but in a nice way):
    par(mfrow=c(2,1))        # set up the graphics 
hist(dljj, prob=TRUE, 12)   # histogram    
lines(density(dljj))     # smooth it - ?density for details 
qqnorm(dljj)             # normal Q-Q plot  
qqline(dljj)             # add a line    

############################################################
#Let's check out the correlation structure of dljj using 
#various techniques. First, we'll look at a grid of scatterplots 
#of dljj(t-lag) vs dljj(t) for lag=1,2,...,9.
par(mfrow=c(1,1))
lag.plot(dljj, 9, do.lines=FALSE)  
lag1.plot(dljj, 9)  # if you have astsa loaded (not shown) 
# why the do.lines=FALSE? Because you get a phase plane if it's TRUE 
#   a little phase plane aside - try this on your own
x = cos(2*pi*1:100/4) + .2*rnorm(100)
plot.ts(x)
dev.new()
lag.plot(x, 4)

############################################################
#Now let's take a look at the ACF and PACF of dljj:
par(mfrow=c(2,1)) # The power of accurate observation is commonly called cynicism 
                  #     by those who have not got it. - George Bernard Shaw
acf(dljj, 20)     # ACF to lag 20 - no graph shown... keep reading
pacf(dljj, 20)    # PACF to lag 20 - no graph shown... keep reading
# !!NOTE!! acf2 on the line below is ONLY available in astsa and tsa3
acf2(dljj)        # this is what you'll see below

############################################################
#let's try a structural decomposition of log(jj) = trend + season + error using lowess.
plot(dog <- stl(log(jj), "per"))

############################################################
#We're going to fit the regression
#   log(jj)= β*time + α1*Q1 + α2*Q2 + α3*Q3 + α4*Q4 + ε
#where Qi is an indicator of the quarter i = 1,2,3,4. Then we'll inspect the residuals.
Q = factor(cycle(jj))   # make (Q)uarter factors
trend = time(jj)-1970   # not necessary to "center" time, but the results look nicer
reg = lm(log(jj)~0+trend+Q, na.action=NULL)  # run the regression without an intercept
#-- the na.action statement is to retain time series attributes
summary(reg)

model.matrix(reg)

plot(log(jj), type="o")   # the data in black with little dots 
lines(fitted(reg), col=2) # the fitted values in bloody red - or use lines(reg$fitted, col=2)

par(mfrow=c(2,1))
plot(resid(reg))      # residuals - reg$resid is same as resid(reg) 
acf(resid(reg),20)    # acf of the resids 



data(cmort, part)
ded = ts.intersect(cmort,part,part4=lag(part,-4))              # align the series first
fit = lm(cmort~part+part4, data=ded, na.action=NULL)           # now the regression will work
summary(fit)  

require(dynlm)                          # load the package
fit = dynlm(cmort~part + lag(part,-4))  # assumes cmort and part are ts objects, which they are
# fit = dynlm(cmort~part + L(part,4))  is the same thing.
summary(fit)





x = arima.sim(list(order=c(1,0,1), ar=.9, ma=-.5), n=100) # simulate some data
(x.fit = arima(x, order = c(1, 0, 1)))   # fit

#... forecast 10 ahead:
    x.fore = predict(x.fit, n.ahead=10)  
# plot the forecasts
U = x.fore$pred + 2*x.fore$se
L = x.fore$pred - 2*x.fore$se
minx=min(x,L)
maxx=max(x,U)
ts.plot(x,x.fore$pred,col=1:2, ylim=c(minx,maxx))
lines(U, col="blue", lty="dashed")
lines(L, col="blue", lty="dashed") 

require(astsa)   # if it's not loaded already
plot(gtemp)      # graph the series (not shown here) 
#... long story short, the data appear to be an ARIMA(1,1,1) with a drift of about +.6 oC per century. Let's fit the model:
arima(gtemp, order=c(1,1,1))   

#So what's wrong? .... well, there's no estimate of the drift!! 
#With no drift, the global warming hypothesis is kaput (technical term)... 
#that is, the temps are just basically taking a random walk. How do you get the estimate of drift?... do this:
arima(diff(gtemp), order=c(1,0,1))  # diff the data and fit an arma to the diffed data

#What happened? The two runs should have given the same results, 
#but the default models for the two cases are different. I won't go into detail 
#here because the details can be found on the R Issues page (see Issues 2 and 3). 
#And, of course, this problem continues if you try to do forecasting. There are remedies. 
#One remedy is to use sarima from astsa:
    sarima(gtemp, 1, 1, 1) # partial output shown (easy, huh?)