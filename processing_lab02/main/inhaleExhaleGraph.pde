XYChart inexChart;

FloatList inTimeX = new FloatList();
FloatList inPeriodY= new FloatList();
FloatList exTimeX= new FloatList();
FloatList exPeriodY= new FloatList();


void inhalationGraphSetup(){
  
    inexChart = new XYChart(this);
    
    inexChart.setMinY(40);
    
    inexChart.setMaxY(200); // random value temp

    inexChart.showXAxis(true);
    inexChart.showYAxis(true);
    
    //heartRateChart.setLineVisible(true);
    inexChart.setLineColour(color(62, 98, 89));
    inexChart.setLineWidth(2);

}


void drawInhalationGraph(){
    pushMatrix();
    
      // Define the position and size of the chart to match the middle pane
      float chartX = width * 0.25 + 25;
      float chartY = height * 0.7;
      float chartWidth = width * 0.5 - 50;
      float chartHeight = height * 0.2;
      
      // Add Title
      textAlign(CENTER, CENTER);
      textSize(16);
      text("Inhalation and Exhalation Periods Over Time", chartX + chartWidth / 2, chartY - 20);
    
      // Add Y-axis label (Heart Rate)
      textAlign(CENTER, CENTER);
      textSize(12);
      pushMatrix();
      translate(chartX - 55, chartY + chartHeight / 2);
      rotate(-PI / 2);
      text("Duration", 0, 0); // Y-axis label
      popMatrix();
      
      
      textSize(12);
      text("Time (seconds)", chartX + chartWidth / 2, chartY + chartHeight - 30);
    
      //fill(172, 210, 237, 150); // Light blue color with some transparency
      //noStroke(); // Optional border stroke
      //rect(chartX, chartY, chartWidth, chartHeight + 15);
      
      // Draw axes
          stroke(33, 40, 48);
          //line(chartX, chartY + chartHeight - 40, chartX + chartWidth, chartY + chartHeight - 40); // X-axis
          //line(chartX + 40, chartY, chartX + 40, chartY + chartHeight); // Y-axis
          line(chartX + 40, chartY + chartHeight - 40, chartX + chartWidth, chartY + chartHeight - 40); // X-axis.
          line(chartX + 40, chartY, chartX + 40, chartY + chartHeight - 40); // Y-axis.
      
      if (inTimeX.size() > 1 && inPeriodY.size() > 1 && exTimeX.size() > 1 && exPeriodY.size() > 1){
          
          
          // Determine the time range for mapping
          float minTime = min(min(inTimeX.get(0), exTimeX.get(0)), (millis() - baselineStartTime) / 1000.0);
          float maxTime = max(max(inTimeX.get(inTimeX.size() - 1), exTimeX.get(exTimeX.size() - 1)), (millis() - baselineStartTime) / 1000.0);
  
          // Avoid division by zero
          if (minTime == maxTime) {
              maxTime += 1;
          }
         
        
           // Graph inhalation periods (green)
          stroke(0, 255, 0);
          noFill();
          beginShape();
          for (int i = 0; i < inPeriodY.size(); i++) {
              // Map X: Time mapped to chart width
              float x = map(inTimeX.get(i), inTimeX.get(0), inTimeX.get(inTimeX.size() - 1), chartX + 40, chartX + chartWidth);
              // Map Y: Inhalation period mapped to chart height
              float y = map(inPeriodY.get(i), 0, 5, chartY + chartHeight - 40, chartY);  // Map inhale period between 0 and 5 seconds
              vertex(x, y);
          }
          endShape();
        
          // Graph exhalation periods (blue)
          stroke(0, 0, 255);
          noFill();
          beginShape();
          for (int i = 0; i < exPeriodY.size(); i++) {
              float x = map(exTimeX.get(i), exTimeX.get(0), exTimeX.get(exTimeX.size() - 1), chartX + 40, chartX + chartWidth);
              float y = map(exPeriodY.get(i), 0, 5, chartY + chartHeight - 40, chartY); // Map exhale period between 0 and 5 seconds
              vertex(x, y);
          }
          endShape();
          
      } else{
        
        //// Display a message indicating that data is not yet available
        //textAlign(CENTER, CENTER);
        //fill(120);
        //text("Waiting for data...", chartWidth / 2, chartHeight / 2);
        
      }
      
       // Display the elapsed time
        textSize(14);
        fill(0);
        fill(120);
        text("Elapsed Time: " + bpmtimePassed + " sec", (chartX + chartWidth / 2)+205, chartY + chartHeight-20);

    
    popMatrix();
  
}

void inSerialEvent(float inhalePeriod, float inhaleDuration){
    inPeriodY.append(inhalePeriod);
    inTimeX.append(inhaleDuration);
  
    // Limit the number of points stored to maxDataPoints
    if (inPeriodY.size() > 100) {
        inPeriodY.remove(0);
        inTimeX.remove(0);
    }
  
}

void exSerialEvent(float exhalePeriod, float exhaleDuration){
    exPeriodY.append(exhalePeriod);
    exTimeX.append(exhaleDuration);
  
    // Limit the number of points stored to maxDataPoints
    if (exPeriodY.size() > 100) {
        exPeriodY.remove(0);
        exTimeX.remove(0);
    }
  
}
