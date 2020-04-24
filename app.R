#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shiny)
library(shinythemes)
library(dplyr)
library(readr)

# Load data
library(readr)
MLBTeamVal6to18 <- read_csv("C:/Users/student/Desktop/SYS2202/MLBValues/MLBTeamVal6to18.csv")
View(MLBTeamVal6to18)

# Define UI
ui <- fluidPage(theme = shinytheme("united"),
                titlePanel("MLB Values By Team"),
                sidebarLayout(
                    sidebarPanel(
                        
                        # Select type of trend to plot
                        selectInput(inputId = "type", label = strong("Team"),
                                    choices = unique(MLBTeamVal6to18$name),
                                    selected = "NYA"),
                        
                        
                        #NOT SELECTING MULTIPLE:
                      #  selectInput(inputId = "type", label = strong("Team"),
                                   #choices = unique(MLBTeamVal6to18$teamID),
                                   # selected = "NYA"),
                        
                        
                        
                        
                        
                        #
                    ),
                    # Output: Description, lineplot, and reference
                    mainPanel(
                        plotOutput(outputId = "lineplot", height = "300px"),
                        plotOutput(outputId="winsplot" ,height ='300px'),
                        plotOutput(outputId="attendanceplot" ,height ='300px'),
                        textOutput(outputId="WSVictory1"),
                        
                        textOutput(outputId="WSVictory2")
                        
                    )
                    
                )
)


# Define server function
server <- function(input, output) {
    
    # Subset data
    selected_team <- reactive({
        a<-subset(MLBTeamVal6to18,name==input$type) 
        return(a)
    })

    
    # Create scatterplot object the plotOutput function is expecting
    output$lineplot <- renderPlot({
        color = "#434343"
        par(mar = c(4, 4, 1, 1))
        plot(x = selected_team()$yearID, y = selected_team()$Value, type = "l",
             xlab = "Year", ylab = "Value") #)
        # Display only if smoother is checked
        
    })
    output$winsplot <- renderPlot({
      color ="#434343"
      par(mar =c(4,4,1,1))
      plot(x = selected_team()$yearID, y = selected_team()$W, type = "l",
           xlab = "Year", ylab = "Wins") #)
    }
    )
    output$attendanceplot <- renderPlot({
      color ="#434343"
      par(mar =c(4,4,1,1))
      plot(x = selected_team()$yearID, y = selected_team()$attendance, type = "l",
           xlab = "Year", ylab = "Attendance") #)
    }
    )
    output$WSVictory1<-renderPrint({return("World Series wins since 2006:")})
    output$WSVictory2<- renderPrint({
      counter<-0
      for(i in selected_team()$WSWin){
        if("Y" %in% selected_team()$WSWin){
          return(counter+1)}
        else{
          return (counter)
        }
      }
      
      
    })
    
}

# Create Shiny object
shinyApp(ui = ui, server = server)
