shinyUI(
  fluidPage(
    titlePanel(h1("Konfidenzinterval mit konjunktiver Entscheidungsregeln")),
    
    sidebarLayout(position = "left",
                  sidebarPanel(
                    
 
      h6("Machen Sie alle Angaben in C-Werten"),

      

      h4("Erzielte Werte von Gertrude"),
      textInput("WertA", "C-Wert von Gertrude in Test A:", 4),
      textInput("WertB", "C-Wert von Gertrude in Test B:", 3),
      
      br(),
     
      h4("Cut-off Werte im konjunktiven Model"),
      textInput("testAk", "Minimaler C-Wert Test A:", 1),
      textInput("testBk", "Minimaler C-Wert Test B:", 1),    
      
      br(),
      
      selectInput("Regel", h3("Hypothese"),
                  choices = c("1-seitig", "2-seitg")),
      
                    conditionalPanel(condition = "input.Regel == '1-seitig'", 
                                     textInput("test1a", "Minimaler C-Wert Test A:", ),
                                     textInput("test1b", "Minimaler C-Wert Test B:", )),
                    
                    conditionalPanel(condition ="input.Regel == '2-seitg'",
                                     textInput("test2ami", "Minimaler C-Wert Test A:", ),
                                     textInput("test2ama", "Maximaler C-Wert Test A:", ),
                                     textInput("test2bmi", "Minimaler C-Wert Test B:", ),
                                     textInput("test2bma", "Maximaler C-Wert Test B:", )),
 
      br(),

                  ),
                  
                  mainPanel("Grafiken",
                            column(6,plotOutput(outputId="Visualisierungbb", width="600px",height="700px"))
     
                  ))
          )
    
)
  







