XYChart heartRateChart;

float maxHeartRate;
FloatList ecgtimex;
FloatList heartRateY;


void graphSetup(){
  
    heartRateChart = new XYChart(this);
    ecgtimex = new FloatList();
    heartRateY = new FloatList();
    
    heartRateChart.setMinY(40);
    maxHeartRate = 220 - userAge;
    heartRateChart.setMaxY(maxHeartRate); // max heartrate based on user age

    heartRateChart.showXAxis(true);
    heartRateChart.showYAxis(true);
    
    //heartRateChart.setLineVisible(true);
    heartRateChart.setLineColour(color(62, 98, 89));
    heartRateChart.setLineWidth(2);

}

// Function to display the total time and time in each cardio zone
void displayTimeInfo() {
  // Define emojis for each zone
    String veryLightEmoji = "🌫";  // Very Light (Grey)
    String lightEmoji = "💧";        // Light (Blue)
    String moderateEmoji = "🏃‍";   // Moderate (Green)
    String hardEmoji = "🔥";         // Hard (Orange)
    String peakEmoji = "⚡";         // Maximum (Red)

    // Format time as minutes and seconds
    String totalTimeStr = "Total Time Active";
    String lightTimeStr = veryLightEmoji + " Very Light Zone (Grey)" ;
    String fatBurnTimeStr = lightEmoji + " Light Zone (Blue)";
    String moderateTimeStr = moderateEmoji + " Moderate Zone (Green)" ;
    String hardTimeStr = hardEmoji + " Hard Zone (Orange)" ;
    String peakTimeStr = peakEmoji + " Maximum Zone (Red)";
    
    // Draw the time information on the screen
    pushMatrix();
    textFont(createFont("Tahoma", 16));
    fill(0); // Black text
     // RIGHT PANE DATA
    textAlign(LEFT, TOP);
     textSize(20);
    text("Exercise zone:", rightPaneX+5, paneHeight  * 0.15);
    
    fill(169, 169, 169);
    textSize(16);
    text(lightTimeStr, rightPaneX +5, paneHeight * 0.20);
    fill(0, 191, 255);  // Light (Blue)
    text(fatBurnTimeStr, rightPaneX+5, paneHeight  * 0.25);
    fill(34, 139, 34);  // Moderate (Green)
    text(moderateTimeStr, rightPaneX+5, paneHeight  * 0.30);
    fill(255, 165, 0);  // Hard (Orange)
    text(hardTimeStr, rightPaneX+5, paneHeight  * 0.35);
    fill(255, 0, 0);  // Maximum (Red)
    text(peakTimeStr, rightPaneX+5, paneHeight* 0.40);
    
    popMatrix();
    
}

void drawHRGraph(){
    pushMatrix();
    
      // update x axis max
      maxHeartRate = 220 - userAge;
      heartRateChart.setMaxY(maxHeartRate); // max heartrate based on user age 
    
      // Define the position and size of the chart to match the middle pane
      float chartX = width * 0.25 + 25;
      float chartY = height * 0.15 + 20;
      float chartWidth = width * 0.5 - 50;
      float chartHeight = height * 0.2;
    
      // Draw the chart background
      //fill(238, 240, 242);
      //rect(chartX, chartY, chartWidth, chartHeight);
      // Add Title
      textAlign(CENTER, CENTER);
      textSize(15);
      text("Heart Rate Over Time", chartX + chartWidth / 2, chartY - 20);
      
      // Add Y-axis label (Heart Rate)
      textAlign(CENTER, CENTER);
      textSize(12);
      pushMatrix();
      translate(chartX - 55, chartY + chartHeight / 2);
      rotate(-PI / 2);
      text("Heart Rate (bpm)", 0, 0); // Y-axis label
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
      float minY = 40;  // Start Y-axis at 40
      float maxY = maxHeartRate;  // Maximum Y-axis value (max heart rate)
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
        for (int i = 1; i < ecgtimex.size(); i++) {
        float x1 = map(ecgtimex.get(i - 1), ecgtimex.get(0), ecgtimex.get(ecgtimex.size() - 1), chartX + 40, chartX + chartWidth - 20);
        float y1 = map(heartRateY.get(i - 1), minY, maxY, chartY + chartHeight - 40, chartY);
        float x2 = map(ecgtimex.get(i), ecgtimex.get(0), ecgtimex.get(ecgtimex.size() - 1), chartX + 40, chartX + chartWidth - 20);
        float y2 = map(heartRateY.get(i), minY, maxY, chartY + chartHeight - 40, chartY);

        // Draw the line between points.
        stroke(34, 139, 34);  // Set to green by default for visibility.
        line(x1, y1, x2, y2);
    }
      
       // Display the elapsed time
        elapsedTime = (millis() - startTime) / 1000;
        textSize(14);
        fill(0);
        fill(120);
        text("Elapsed Time: " + bpmtimePassed + " sec", chartX + chartWidth / 2+250, chartY + chartHeight-10 );
        
      
      
      // Draw the data points and colored lines
    //for (int i = 1; i < ecgtimex.size(); i++) {
    //    float x1 = map(ecgtimex.get(i-1), ecgtimex.get(0), ecgtimex.get(ecgtimex.size()-1), 40, chartWidth - 20);
    //    float y1 = map(heartRateY.get(i-1), minY, maxY, 250, 0);  // Map Y-axis values with minY = 40
    //    float x2 = map(ecgtimex.get(i), ecgtimex.get(0), ecgtimex.get(ecgtimex.size()-1), 40, chartWidth - 20);
    //    float y2 = map(heartRateY.get(i), minY, maxY, 250, 0);  // Map Y-axis values with minY = 40
        
    //    // Calculate heart rate percentage
    //    float maxHeartRate = 220 - userAge;
    //    float heartRatePercent = (heartRateY.get(i) * 100) / maxHeartRate;
        
        //// Set line color based on the heart rate zone
        //if (heartRatePercent < 50) {
        //    stroke(169, 169, 169);  // Light (Blue)
        //} else if (heartRatePercent < 60) {
        //    stroke(0, 191, 255);  // Fat Burn (Yellow)
        //} else if (heartRatePercent < 70) {
            //stroke(34, 139, 34);  // Moderate (Green)
        //} else if (heartRatePercent < 80) {
        //    stroke(255, 140, 0);  // Hard (Orange)
        //} else {
        //    stroke(255, 0, 0);  // Peak (Red)
        //}
        
        //strokeWeight(3);
        //line(x1, y1, x2, y2);  // Draw line between points
    
    popMatrix();
        displayTimeInfo();
  
}

void graphSerialEvent(float heartrate, float timePassed){
    //println("you reached the graphing part!\n");
     heartRateY.append(heartrate);
     ecgtimex.append(timePassed);
    
    // Ensure the graph only displays the most recent 100 data points
    if (ecgtimex.size() > 100 && heartRateY.size() > 100) {
        ecgtimex.remove(0);
        heartRateY.remove(0);
    }
    
    //// Calculate the percentage of the max heart rate
    //float maxHeartRate = 220 - userAge;
    //float heartRatePercent = (heartrate * 100) / maxHeartRate;
    //println("heartRatePercent: "+heartRatePercent);
    
    //// Calculate the time spent in the current zone (assuming timePassed is in seconds)
    //float deltaTime = (ecgtimex.size() > 1) ? ecgtimex.get(ecgtimex.size() - 1) - ecgtimex.get(ecgtimex.size() - 2) : 0;
    //totalTime += deltaTime;
    
    //// Update time spent in each cardio zone
    //if (heartRatePercent < 50) {
    //    lightTime += deltaTime;
    //} else if (heartRatePercent < 60) {
    //    fatBurnTime += deltaTime;
    //} else if (heartRatePercent < 70) {
    //    moderateTime += deltaTime;
    //} else if (heartRatePercent < 80) {
    //    hardTime += deltaTime;
    //} else {
    //    peakTime += deltaTime;
    //}
    
    // Update the chart with new data
    heartRateChart.setData(ecgtimex.array(), heartRateY.array());
  
  
  
}
