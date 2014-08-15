library(shiny)

shinyUI(pageWithSidebar(
#     headerPanel("Illustrating markup"),
#     sidebarPanel(
#         numericInput('id1', 'Numeric input, labeled id1', 0, min = 0, max = 10, step = 1),
#         checkboxGroupInput("id2", "Checkbox",
#                            c("Value 1" = "1",
#                              "Value 2" = "2",
#                              "Value 3" = "3")),
#         dateInput("date", "Date:") 
#     ),
#     
#     mainPanel(
#         h3('Illustrating outputs'),
#         h4('You entered'),
#         verbatimTextOutput("oid1"),
#         h4('You entered'),
#         verbatimTextOutput("oid2"),
#         h4('You entered'),
#         verbatimTextOutput("odate")
#     )
    
    headerPanel("QCC"),
    sidebarPanel(
        dateInput("start_date", "Start date:", value="2012-07-01"),
        dateInput("cut_off_point", "Cut off point:", value="2014-07-01"),
        dateInput("finish_date", "Finish date:", value="2014-08-05")
    ),
    mainPanel(
        h1('New QCC information'),
        p("Start of dataset:"),
        verbatimTextOutput("start_date_df"),
        p("Cutting point"),
        verbatimTextOutput("cut_date_df"),
        p("End of dataset"),
        verbatimTextOutput("end_date_df"),
        plotOutput('newQcc')
    )    
))