library(shiny)
library(shinythemes)
library(dplyr)
library(readr)

# Load data
library(readr)
MLBTeamVal6to18 <- read_csv("C:/Users/student/Desktop/SYS2202/MLBTeamVal6to18.csv")
View(MLBTeamVal6to18)

# Define UI
ui <- fluidPage(theme = shinytheme("lumen"),
                titlePanel("MLB Values By Team"),
                sidebarLayout(
                    sidebarPanel(
                        
                        # Select type of trend to plot
                        selectInput(inputId = "type", label = strong("Team"),
                                    choices = unique(MLBTeamVal6to18$teamID),
                                    selected = "NYA"),
                        
                   
                        
                       #
                    ),
                    # Output: Description, lineplot, and reference
                    mainPanel(
                        plotOutput(outputId = "lineplot", height = "300px")
                      
                    )
                
                )
)


# Define server function
server <- function(input, output) {
    
    # Subset data
    selected_team <- reactive({
        a<-subset(MLBTeamVal6to18,teamID==input$type) 
        return(a)
    })
    
    
    # Create scatterplot object the plotOutput function is expecting
    output$lineplot <- renderPlot({
        color = "#434343"
        par(mar = c(4, 4, 1, 1))
        plot(x = selected_team()$yearID, y = selected_team()$Value, type = "l",
             xlab = "Date", ylab = "Value", col = color, fg = color, col.lab = color, col.axis = color)
        # Display only if smoother is checked
        
    })
    

}

# Create Shiny object
shinyApp(ui = ui, server = server)
