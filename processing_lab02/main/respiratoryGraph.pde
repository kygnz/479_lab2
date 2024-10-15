//XYChart respRateChart;

////float maxRespRate;
//FloatList respTimeX;
//FloatList respRateY;


//void respiratoryGraphSetup(){
  
//    respRateChart = new XYChart(this);
//    respTimeX = new FloatList();
//    respRateY = new FloatList();
    
//    heartRateChart.setMinY(10);
//    respRateChart.setMaxY(28); 

//    respRateChart.showXAxis(true);
//    respRateChart.showYAxis(true);
    
//    //heartRateChart.setLineVisible(true);
//    respRateChart.setLineColour(color(62, 98, 89));
//    respRateChart.setLineWidth(2);

//}


//void drawRespGraph(){
//    pushMatrix();
    
//      // update x axis max
//      //respRateChart.setMaxY(maxRespRate); // max heartrate based on user age 
    
//      // Define the position and size of the chart to match the middle pane
//      float chartX = width * 0.25 + 25;
//      float chartY = height * 0.4 + 20;
//      float chartWidth = width * 0.5 - 50;
//      float chartHeight = height * 0.2;
      
//      // Add Title
//      textAlign(CENTER, CENTER);
//      textSize(15);
//      text("Respiration Rate Over Time", chartX + chartWidth / 2, chartY - 20);
      
//      // Add Y-axis label (Respiration Rate)
//      textSize(12);
//      textAlign(CENTER, CENTER);
//      pushMatrix();
//      translate(chartX - 55, chartY + chartHeight / 2);
//      rotate(-PI / 2);
//      text("Respiration Rate (breaths/min)", 0, 0); // Y-axis label
//      popMatrix();
      
//      // Add X-axis label (Time)
//      text("Time (seconds)", chartX + chartWidth / 2, chartY + chartHeight );
    
    
    
    
//          // Draw axes
//          stroke(33, 40, 48);
//          //line(chartX, chartY + chartHeight - 40, chartX + chartWidth, chartY + chartHeight - 40); // X-axis
//          //line(chartX + 40, chartY, chartX + 40, chartY + chartHeight); // Y-axis
//          line(chartX + 40, chartY + chartHeight - 40, chartX + chartWidth, chartY + chartHeight - 40); // X-axis.
//          line(chartX + 40, chartY, chartX + 40, chartY + chartHeight - 40); // Y-axis.
    
    
//      // Draw the chart background
//      // Temporary fill to visualize the chart area
//      //fill(172, 210, 237, 150); // Light blue color with some transparency
//      //noStroke(); // Optional border stroke
//      //rect(chartX, chartY, chartWidth, chartHeight); // Draw the rectangle to cover the chart area
//      //fill(238, 240, 242);
//      //stroke(33, 40, 48);
//      //rect(chartX, chartY, chartWidth, chartHeight);
//      // Add Y-axis labels (heart rate), starting from 40 instead of 0
      
//      float minY = 10;  // Start Y-axis at 40
//      float maxY = 28;  // Maximum Y-axis value (max heart rate)
      
      
//      if (respTimeX.size() > 1 && respRateY.size() > 1) {
//          float minTime = respTimeX.get(0);  // Starting time (first data point)
//          float maxTime = respTimeX.get(respTimeX.size() - 1);
      
//          // Draw axes
//          stroke(33, 40, 48);
//          //line(chartX, chartY + chartHeight - 40, chartX + chartWidth, chartY + chartHeight - 40); // X-axis
//          //line(chartX + 40, chartY, chartX + 40, chartY + chartHeight); // Y-axis
//          line(chartX + 40, chartY + chartHeight - 20, chartX + chartWidth, chartY + chartHeight - 20); // X-axis.
//          line(chartX + 40, chartY, chartX + 40, chartY + chartHeight - 20); // Y-axis.
     
//          textAlign(RIGHT, CENTER);
//          for (int i = 0; i <= 5; i++) {
//              float yValue = minY + i * (maxY - minY) / 5;
//              float y = map(yValue, minY, maxY, chartY + chartHeight - 40, chartY);
//              text(nf(yValue, 0, 0), chartX + 35, y);  // Label for Y-axis ticks.
//              line(chartX + 37, y, chartX + 40, y);  // Small tick mark on Y-axis.
//          }
      
      
//          //// Add X-axis labels (time)
//          //textAlign(CENTER, TOP);
//          //for (int i = 0; i <= 5; i++) {
//          //    float xValue = map(i, 0, 5, minTime, maxTime);  // Assuming we want to label every 20 seconds.
//          //    float x = map(xValue, 0, 100, chartX + 40, chartX + chartWidth - 20);
//          //    text(nf(xValue, 0, 0) + "s", x, chartY + chartHeight - 25);  // Label for X-axis ticks (time in seconds).
//          //    line(x, chartY + chartHeight - 40, x, chartY + chartHeight - 37);  // Small tick mark on X-axis.
//          //}
    
//          // Draw the data points and lines.
//          noFill();
//          strokeWeight(2);
//          for (int i = 1; i < respTimeX.size(); i++) {
//              float x1 = map(respTimeX.get(i - 1), respTimeX.get(0), respTimeX.get(respTimeX.size() - 1), chartX + 40, chartX + chartWidth - 20);
//              float y1 = map(respRateY.get(i - 1), minY, maxY, chartY + chartHeight - 80, chartY);
//              float x2 = map(respTimeX.get(i), respTimeX.get(0), respTimeX.get(respTimeX.size() - 1), chartX + 40, chartX + chartWidth - 20);
//              float y2 = map(respRateY.get(i), minY, maxY, chartY + chartHeight - 80, chartY);
      
//              // Draw the line between points.
//              stroke(34, 139, 34);  // Set to green by default for visibility.
//              line(x1, y1, x2, y2);
//          }
          
//      } else {
//        // Display a message indicating that data is not yet available
//        textAlign(CENTER, CENTER);
//        fill(120);
//        text("Waiting for data...", width / 2, height / 2);
//      }
      
//      // Display the elapsed time
//      textSize(14);
//      fill(0);
//      fill(120);
//      text("Elapsed Time: " + bpmtimePassed + " sec", chartX + chartWidth / 2+280, chartY + chartHeight);

    
//    popMatrix();
  
//}

//void respiratorySerialEvent(float respiratoryRate, float timePassed){
//    //println("you reached the graph!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
//    println("Time: " + timePassed + ", Respiratory Rate: " + respiratoryRate);
//    respRateY.append(respiratoryRate);
//    respTimeX.append(timePassed);
    
//    // scrolling window
//    if (respTimeX.size() > 100 && respRateY.size() > 100) {
//          respTimeX.remove(0);
//          respRateY.remove(0);
//     }
      
      
//     respRateChart.setData(respTimeX.array(), respRateY.array());
    
    
//}
