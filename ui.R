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
        p('Quality Control and quality assurance are important functions in most businesses from manufacturing to software development. For most, this means that one or more people are meticulously inspecting what\'s coming out of the factory, looking for imperfections and validating that requirements for products and services produced are satisfied. Often times QC and QA are performed manually by a select few specialists, and determining suitable quality can be extremely complex and error-prone. This is a post about quality assurance automation using statistics and R. What is statistical quality control? Statistical quality control is a quantitative approach to monitoring and controling a process. The best way to explain it is though an example. Say you\'re the manager at a factory that manufactures lug nuts. And let\'s suppose your 10 mm long lug nuts continue to function within a 10 percent margin of error (i.e. customers have a tolerance for error of roughly +/- 1 mm in length). As long as your producing lug nuts measuring between 9 and 11 mm in length, you\'d consider your machine to be functioning as designed.'),
        p('How would you know if your machine has suffered a malfunction? A 9.7mm lug nut could be the sign that your machine is producing lug nuts that are too small, or it could just be natural error that occurs for a machine that\'s supposed to make 10mm lug nuts.'),
        plotOutput('newQcc'),
        h4("Input data review:")
        p('Start of dataset:'),
        verbatimTextOutput("start_date_df"),
        p("Cutting point"),
        verbatimTextOutput("cut_date_df"),
        p("End of dataset"),
        verbatimTextOutput("end_date_df")
    )    
))