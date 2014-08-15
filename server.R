library(shiny)
#library(UsingR)
library(xts)
library(astsa)
library(qcc)
library(lubridate)
library(xts)

observations<-read.csv("dol_1.csv", sep="\t")
rownames(observations) = observations[,1]
observations<-observations[, "COUNT", drop=FALSE]

observations.ts<-as.xts(observations)

#data(galton)

shinyServer(

    function(input, output) {
        
        output$start_date_df <- renderPrint({input$start_date})
        output$cut_date_df <- renderPrint({input$cut_off_point})
        output$end_date_df <- renderPrint({input$finish_date})

        base_data<- reactive({
            window(observations.ts, 
                   start=parse_date_time(input$start_date, "%y-%m-%d"),
                   end=parse_date_time(input$cut_off_point, "%y-%m-%d"))
        })
        new_data <- reactive({
                window(observations.ts, 
                    start=parse_date_time(input$cut_off_point, "%y-%m-%d"),
                    end=parse_date_time(input$finish_date, "%y-%m-%d"))
        })
        output$newQcc <- renderPlot({qcc (data=base_data(), newdata=new_data(), type="xbar.one", title="Number of observations", xlab="day")})        

    }
)