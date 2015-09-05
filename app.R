library(shiny)

ui <- fluidPage(
  sliderInput(inputId = "num",
              label= "Choose a number",
              value = 25, min = 1,max = 100),
  actionButton(inputId="go",
                label="update"),
            plotOutput("hist"),
            verbatimTextOutput("stats")
  )


server <- function(input, output) {
  data<-eventReactive(input$go,{
    rnorm(input$num)
  })
  output$hist<-renderPlot({
    hist(data())
  })
#   output$stats<-renderPrint({
#     summary(data())
#   })
  
}


shinyApp(ui = ui, server = server)