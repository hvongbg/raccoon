shinyServer(
  function(input, output, session){
    library(ggplot2)
    library(gridExtra) 
    

       
    zWerte <- reactive({
      
      distType <- input$Regel
      
      #data
      TestA <- c(-2:2)
      TestB <- c(-2:2)
      date <-as.data.frame(cbind(TestA, TestB))

      
      #Input transformation from C-values to z-values 
      
      testAA <- as.numeric(input$testA) + (as.numeric(input$testA) -1)
      testBB <- as.numeric(input$testB) + (as.numeric(input$testB) -1)
      
      werA <- (as.numeric(input$WertA)-5)/2
      werB <- (as.numeric(input$WertB)-5)/2
      
      
      teA <- (testAA-5)/2
      teB <- (testAA-5)/2
      
      teAo <- (as.numeric(input$testAo)-5)/2
      teBo <- (as.numeric(input$testBo)-5)/2
      
      teAk <- (as.numeric(input$testAk)-5)/2
      teBk <- (as.numeric(input$testBk)-5)/2
      
      #base plot      
      p <- ggplot(date, aes(x = TestA, y = TestB)) +
        scale_y_continuous(breaks=c(-2,-1.5,-1,-0.5,0, 0.5,1,1.5,2)) +
        scale_x_continuous(breaks=c(-2,-1.5,-1,-0.5,0, 0.5,1,1.5,2)) +
        annotate("rect", xmin=c(-2), xmax=c(2),
                 ymin=c(-2) , ymax=c(2), alpha=0.0, fill="blue") +         
      annotate("pointrange", x = as.numeric(werA), y = as.numeric(werB), 
               ymin = 0, ymax = 0,colour = "springgreen4", size = 0.6)

      
      if(distType == "Kompensatorisch"){
        
      
        
        p <- p +
          annotate("segment", x = -2, xend = teA, y = teB, yend = -2, 
                   colour = "coral1", size=2, alpha=0.5) 
        
        
      }
      
      else if(distType == "Oder" ){
        p<- p +
          annotate("rect", xmin=c(-2), xmax= as.numeric(teAo),
                   ymin=c(-2) , ymax=as.numeric(teBo), alpha=0.2, color="cadetblue3", fill="cadetblue3") 
        
        
        
      }
      
      else{
        p<- p +
          annotate("rect", xmin=c(-2), xmax= as.numeric(teAk),
                   ymin=c(-2) , ymax=c(2), alpha=0.2, color="lightsalmon3", fill="lightsalmon3") +
          annotate("rect", xmin=c(-2), xmax= c(2),
                   ymin=c(-2) , ymax= as.numeric(teBk), alpha=0.2, color="lightsalmon3", fill="lightsalmon3")
      }
      
      p  +
        annotate(geom="text", x= 0, y=2, label="Darstellung der z-Werte",
                 color="black", size = 9) 
      
    })
    
    
    #plot C- Werte
    
    cWerte <- reactive({
      
      distType <- input$Regel
    
      
      #data
      Test_A <- c(1:9)
      Test_B <- c(1:9)
      dat <-as.data.frame(cbind(Test_A, Test_B))
      
      
      
      #base plot
      p <- ggplot(dat, aes(x = Test_A, y = Test_B)) +
        scale_y_continuous(breaks=c(1,2,3,4,5,6,7,8,9)) +
        scale_x_continuous(breaks=c(1,2,3,4,5,6,7,8,9)) +
        annotate("rect", xmin=c(1), xmax=c(9),
                 ymin=c(1) , ymax=c(9), alpha=0.0, fill="blue") +
        annotate("pointrange", x = as.numeric(input$WertA), y = as.numeric(input$WertB), ymin = 1, ymax = 1,
                 colour = "springgreen4", size = 0.6)
      
      p<- p +
        annotate("rect", xmin=c(1), xmax= as.numeric(input$testAk),
                 ymin=c(1) , ymax=c(9), alpha=0.2, color="lightsalmon3", fill="lightsalmon3") +
        annotate("rect", xmin=c(1), xmax= c(9),
                 ymin=c(1) , ymax= as.numeric(input$testBk), alpha=0.2, color="lightsalmon3", fill="lightsalmon3")     
      
      
      
      if(distType == "1-seitig"){

        p <- p +
          annotate("pointrange", x = as.numeric(input$WertA), y = as.numeric(input$WertB), 
                   ymin = as.numeric(input$WertB), ymax = as.numeric(input$test1b),
                   colour = "springgreen4", size = 0.8) + 
        annotate("segment", x = as.numeric(input$test1a), xend = as.numeric(input$WertA), 
                 y = as.numeric(input$WertB), yend = as.numeric(input$WertB),
                   colour = "springgreen4", size = 0.8)
      }

      
      else{
        
        p <- p +
          annotate("pointrange", x = as.numeric(input$WertA), y = as.numeric(input$WertB), 
                   ymin = as.numeric(input$test2bmi), ymax = as.numeric(input$test2bma),
                   colour = "springgreen4", size = 0.7) + 
          annotate("segment", x = as.numeric(input$test2ami), xend = as.numeric(input$test2ama), 
                   y = as.numeric(input$WertB), yend = as.numeric(input$WertB),
                   colour = "springgreen4", size = 0.7)
      }
      
      p  +
        annotate(geom="text", x= 5, y=9, label="Darstellung der C-Werte",
                 color="black", size = 9)
    })
   
   output$Visualisierungbb <- renderPlot(
     cWerte(), width = 666, height = 666
  ) 
    
    
     
  }
)