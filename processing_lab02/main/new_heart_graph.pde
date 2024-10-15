XYChart ecgRateChart;

//float maxHeartRate;
FloatList ecgTime_X;
FloatList ecgarray;


void ecggraphSetup(){
  
    ecgRateChart = new XYChart(this);
    ecgTime_X = new FloatList();
    ecgarray = new FloatList();
    
    ecgRateChart.setMinY(300);
    //maxHeartRate = 220 - userAge;
    ecgRateChart.setMaxY(800); // max heartrate based on user age

    ecgRateChart.showXAxis(true);
    ecgRateChart.showYAxis(true);
    
    //ecgRateChart.setLineVisible(true);
    ecgRateChart.setLineColour(color(62, 98, 89));
    ecgRateChart.setLineWidth(2);

}

void drawecgGraph(){
    pushMatrix();
    
      // update x axis max
    
      // Define the position and size of the chart to match the middle pane
      float chartX = width * 0.25 + 25;
      float chartY = height * 0.4 + 20;
      float chartWidth = width * 0.5 - 50;
      float chartHeight = height * 0.2;
    
      // Draw the chart background
      //fill(238, 240, 242);
      //rect(chartX, chartY, chartWidth, chartHeight);
      // Add Title
      textAlign(CENTER, CENTER);
      textSize(15);
      text("ECG Over Time", chartX + chartWidth / 2, chartY - 20);
      
      // Add Y-axis label (Heart Rate)
      textAlign(CENTER, CENTER);
      textSize(12);
      pushMatrix();
      translate(chartX - 55, chartY + chartHeight / 2);
      rotate(-PI / 2);
      text("ECG", 0, 0); // Y-axis label
      popMatrix();
      
      textSize(12);
      text("Time (seconds)", chartX + chartWidth / 2, chartY + chartHeight - 30); // X-axis label
      
      // Draw axes
      stroke(33, 40, 48);
      //line(chartX, chartY + chartHeight - 40, chartX + chartWidth, chartY + chartHeight - 40); // X-axis
      //line(chartX + 40, chartY, chartX + 40, chartY + chartHeight); // Y-axis
      line(chartX + 40, chartY + chartHeight - 40, chartX + chartWidth, chartY + chartHeight - 40); // X-axis.
      line(chartX + 40, chartY, chartX + 40, chartY + chartHeight - 40); // Y-axis.
      
      // Add Y-axis labels (heart rate), starting from 40 instead of 0
      float minY = 300;  // Start Y-axis at 40
      float maxY = 800;  // Maximum Y-axis value (max heart rate)
      textAlign(RIGHT, CENTER);
      //for (int i = 0; i <= 5; i++) {
      //    float y = map(minY + i * (maxY - minY) / 5, minY, maxY, 250, 0);  // Map Y from 40 to max heart rate
      //    text(nf(minY + i * (maxY - minY) / 5, 0, 0), 35, y);  // Label for Y-axis ticks
      //    line(37, y, 40, y);  // Small tick mark on Y-axis
      //}
      for (int i = 0; i <= 5; i++) {
        float yValue = minY + i * (maxY - minY) / 5;
        float y = map(yValue, minY, maxY, chartY + chartHeight - 40, chartY);
        text(nf(yValue, 0, 0), chartX + 35, y);  // Label for Y-axis ticks.
        line(chartX + 37, y, chartX + 40, y);  // Small tick mark on Y-axis.
    }
      
      
      // Add X-axis labels (time)
      textAlign(CENTER, TOP);
      for (int i = 0; i <= 5; i++) {
        float xValue = i * 2;  // Assuming we want to label every 20 seconds.
        float x = map(xValue, 0, 100, chartX + 40, chartX + chartWidth - 20);
        text(nf(xValue, 0, 0) + "s", x, chartY + chartHeight - 25);  // Label for X-axis ticks (time in seconds).
        line(x, chartY + chartHeight - 40, x, chartY + chartHeight - 37);  // Small tick mark on X-axis.
    }
    
        // Draw the data points and lines.
        noFill();
        strokeWeight(2);
        for (int i = 1; i < ecgTime_X.size(); i++) {
        float x1 = map(ecgTime_X.get(i - 1), ecgTime_X.get(0), ecgTime_X.get(ecgTime_X.size() - 1), chartX + 40, chartX + chartWidth - 20);
        float y1 = map(ecgarray.get(i - 1), minY, maxY, chartY + chartHeight - 40, chartY);
        //float x2 = map(ecgTime_X.get(i), ecgTime_X.get(0), ecgTime_X.get(ecgTime_X.size() - 1), chartX + 40, chartX + chartWidth - 20);
        //float y2 = map(ecgarray.get(i), minY, maxY, chartY + chartHeight - 40, chartY);

        // Draw the line between points.
        stroke(34, 139, 34);  // Set to green by default for visibility.
        //line(x1, y1);
    }
      
       // Display the elapsed time
        elapsedTime = (millis() - startTime) / 1000;
        textSize(14);
        fill(0);
        fill(120);
        text("Elapsed Time: " + bpmtimePassed + " sec", chartX + chartWidth / 2+250, chartY + chartHeight-10 );
        
      
  
    
    popMatrix();
        //displayTimeInfo();
  
}

void ecggraphSerialEvent(float ecg, float timePassed){
    //println("you reached the graphing part!\n");
     ecgarray.append(ecg);
     ecgTime_X.append(timePassed);
 
    // Update the chart with new data
    //ecgRateChart.setData(ecgTime_X.array(), ecgarray.array());
  
  
  
}
