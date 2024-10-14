//XYChart heartRateChart;


//float maxHeartRate;
//FloatList timeX;
//FloatList heartRateY;

//void graphSetup(){
//    heartRateChart = new XYChart(this);
//    timeX = new FloatList();
//    heartRateY = new FloatList();
    
//    heartRateChart.setMinY(40);
//    maxHeartRate = 220 - userAge;
//    heartRateChart.setMaxY(maxHeartRate); // max heartrate based on user age
//    //float yAxisEnd = map(maxHeartRate, 0, maxHeartRate, paneHeight - 30, 0);
    
//    heartRateChart.showXAxis(true);
    
//    //stroke(0);  // Set color for the y-axis line
//    //line(middlePaneX + 10, paneHeight - 30, middlePaneX + 10, yAxisEnd);  // Draw y-axis from bottom to top
    
//    heartRateChart.showYAxis(true);
    
//    //heartRateChart.setLineVisible(true);
//    heartRateChart.setLineColour(color(62, 98, 89));
//    heartRateChart.setLineWidth(3);
    
    
    
//}

////void drawHRGraph() {
////    pushMatrix();
    
////    // update x axis max
////    maxHeartRate = 220 - userAge;
////    heartRateChart.setMaxY(maxHeartRate); // max heartrate based on user age
    
////    // Draw the graph title
////    PFont graphTitleFont = createFont("Tahoma", 14);
////    textFont(graphTitleFont);
////    fill(120);
////    text("Heart Rate", middlePaneX + 270, height * 0.15);
    
////    // Translate to the correct position for the chart
////    translate(middlePaneX + 1, height * 0.3);
    
////    // Draw the Y-axis
////    stroke(0);  // Set stroke color to black
////    strokeWeight(2);
////    line(40, 0, 40, 250);  // Y-axis line (vertical)
    
////    // Draw the X-axis
////    line(40, 250, middlePaneWidth - 20, 250);  // X-axis line (horizontal)
    
////    // Add Y-axis labels (heart rate), starting from 40 instead of 0
////    float minY = 40;  // Start Y-axis at 40
////    float maxY = maxHeartRate;  // Maximum Y-axis value (max heart rate)
////    textAlign(RIGHT, CENTER);
////    for (int i = 0; i <= 5; i++) {
////        float y = map(minY + i * (maxY - minY) / 5, minY, maxY, 250, 0);  // Map Y from 40 to max heart rate
////        text(nf(minY + i * (maxY - minY) / 5, 0, 0), 35, y);  // Label for Y-axis ticks
////        line(37, y, 40, y);  // Small tick mark on Y-axis
////    }
    
////    // Add X-axis labels (time)
////    textAlign(CENTER, TOP);
////    for (int i = 0; i < 1; i++) {
////        float x = map(i * 100 / 5, 0, 100, 40, middlePaneWidth - 20);  // Assuming timeX has a range of 100
////        text(nf(i * 20, 0, 0), x, 260);  // Label for X-axis ticks (time in seconds)
////        line(x, 250, x, 253);  // Small tick mark on X-axis
////    }
    
////     // Display the elapsed time
////     elapsedTime = (millis() - startTime) / 1000;
////      textSize(14);
////      fill(0);
////      fill(120);
////      text("Elapsed Time: " + elapsedTime+"sec", 515, 255);

////    // Draw the data points and colored lines
////    for (int i = 1; i < timeX.size(); i++) {
////        float x1 = map(timeX.get(i-1), timeX.get(0), timeX.get(timeX.size()-1), 40, middlePaneWidth - 20);
////        float y1 = map(heartRateY.get(i-1), minY, maxY, 250, 0);  // Map Y-axis values with minY = 40
////        float x2 = map(timeX.get(i), timeX.get(0), timeX.get(timeX.size()-1), 40, middlePaneWidth - 20);
////        float y2 = map(heartRateY.get(i), minY, maxY, 250, 0);  // Map Y-axis values with minY = 40
        
////        // Calculate heart rate percentage
////        float maxHeartRate = 220 - userAge;
////        float heartRatePercent = (heartRateY.get(i) * 100) / maxHeartRate;
        
////        // Set line color based on the heart rate zone
////        if (heartRatePercent < 50) {
////            stroke(169, 169, 169);  // Light (Blue)
////        } else if (heartRatePercent < 60) {
////            stroke(0, 191, 255);  // Fat Burn (Yellow)
////        } else if (heartRatePercent < 70) {
////            stroke(34, 139, 34);  // Moderate (Green)
////        } else if (heartRatePercent < 80) {
////            stroke(255, 140, 0);  // Hard (Orange)
////        } else {
////            stroke(255, 0, 0);  // Peak (Red)
////        }
        
////        strokeWeight(3);
////        line(x1, y1, x2, y2);  // Draw line between points
////    }

////    popMatrix();
////    displayTimeInfo();
////}


//void drawHRGraph(){
//    pushMatrix();
    
//      // update x axis max
//      maxHeartRate = 220 - userAge;
//      heartRateChart.setMaxY(maxHeartRate); // max heartrate based on user age 
    
//      // Define the position and size of the chart to match the middle pane
//      float chartX = width * 0.25 + 25;
//      float chartY = height * 0.1 + 20;
//      float chartWidth = width * 0.5 - 50;
//      float chartHeight = height * 0.2;
    
//      // Draw the chart background
//      //fill(238, 240, 242);
//      //rect(chartX, chartY, chartWidth, chartHeight);
      
//      // Draw axes
//      stroke(33, 40, 48);
//      //line(chartX, chartY + chartHeight - 40, chartX + chartWidth, chartY + chartHeight - 40); // X-axis
//      //line(chartX + 40, chartY, chartX + 40, chartY + chartHeight); // Y-axis
//      line(chartX + 40, chartY + chartHeight - 40, chartX + chartWidth, chartY + chartHeight - 40); // X-axis.
//      line(chartX + 40, chartY, chartX + 40, chartY + chartHeight - 40); // Y-axis.
      
//      // Add Y-axis labels (heart rate), starting from 40 instead of 0
//      float minY = 40;  // Start Y-axis at 40
//      float maxY = maxHeartRate;  // Maximum Y-axis value (max heart rate)
//      textAlign(RIGHT, CENTER);
//      //for (int i = 0; i <= 5; i++) {
//      //    float y = map(minY + i * (maxY - minY) / 5, minY, maxY, 250, 0);  // Map Y from 40 to max heart rate
//      //    text(nf(minY + i * (maxY - minY) / 5, 0, 0), 35, y);  // Label for Y-axis ticks
//      //    line(37, y, 40, y);  // Small tick mark on Y-axis
//      //}
//      for (int i = 0; i <= 5; i++) {
//        float yValue = minY + i * (maxY - minY) / 5;
//        float y = map(yValue, minY, maxY, chartY + chartHeight - 40, chartY);
//        text(nf(yValue, 0, 0), chartX + 35, y);  // Label for Y-axis ticks.
//        line(chartX + 37, y, chartX + 40, y);  // Small tick mark on Y-axis.
//    }
      
      
//      // Add X-axis labels (time)
//      textAlign(CENTER, TOP);
//      for (int i = 0; i <= 5; i++) {
//        float xValue = i * 2;  // Assuming we want to label every 20 seconds.
//        float x = map(xValue, 0, 100, chartX + 40, chartX + chartWidth - 20);
//        text(nf(xValue, 0, 0) + "s", x, chartY + chartHeight - 25);  // Label for X-axis ticks (time in seconds).
//        line(x, chartY + chartHeight - 40, x, chartY + chartHeight - 37);  // Small tick mark on X-axis.
//    }
    
//        // Draw the data points and lines.
//        noFill();
//        strokeWeight(2);
//        for (int i = 1; i < timeX.size(); i++) {
//        float x1 = map(timeX.get(i - 1), timeX.get(0), timeX.get(timeX.size() - 1), chartX + 40, chartX + chartWidth - 20);
//        float y1 = map(heartRateY.get(i - 1), minY, maxY, chartY + chartHeight - 40, chartY);
//        float x2 = map(timeX.get(i), timeX.get(0), timeX.get(timeX.size() - 1), chartX + 40, chartX + chartWidth - 20);
//        float y2 = map(heartRateY.get(i), minY, maxY, chartY + chartHeight - 40, chartY);

//        // Draw the line between points.
//        stroke(34, 139, 34);  // Set to green by default for visibility.
//        line(x1, y1, x2, y2);
//    }
      
//       // Display the elapsed time
//        elapsedTime = (millis() - startTime) / 1000;
//        textSize(14);
//        fill(0);
//        fill(120);
//        text("Elapsed Time: " + elapsedTime + " sec", chartX + chartWidth / 2, chartY + chartHeight + 20);
        
      
      
//      // Draw the data points and colored lines
//    //for (int i = 1; i < timeX.size(); i++) {
//    //    float x1 = map(timeX.get(i-1), timeX.get(0), timeX.get(timeX.size()-1), 40, chartWidth - 20);
//    //    float y1 = map(heartRateY.get(i-1), minY, maxY, 250, 0);  // Map Y-axis values with minY = 40
//    //    float x2 = map(timeX.get(i), timeX.get(0), timeX.get(timeX.size()-1), 40, chartWidth - 20);
//    //    float y2 = map(heartRateY.get(i), minY, maxY, 250, 0);  // Map Y-axis values with minY = 40
        
//    //    // Calculate heart rate percentage
//    //    float maxHeartRate = 220 - userAge;
//    //    float heartRatePercent = (heartRateY.get(i) * 100) / maxHeartRate;
        
//        //// Set line color based on the heart rate zone
//        //if (heartRatePercent < 50) {
//        //    stroke(169, 169, 169);  // Light (Blue)
//        //} else if (heartRatePercent < 60) {
//        //    stroke(0, 191, 255);  // Fat Burn (Yellow)
//        //} else if (heartRatePercent < 70) {
//            //stroke(34, 139, 34);  // Moderate (Green)
//        //} else if (heartRatePercent < 80) {
//        //    stroke(255, 140, 0);  // Hard (Orange)
//        //} else {
//        //    stroke(255, 0, 0);  // Peak (Red)
//        //}
        
//        //strokeWeight(3);
//        //line(x1, y1, x2, y2);  // Draw line between points
    
//    popMatrix();
  
//}




////void drawGraph(){
  
////    pushMatrix();
////      // Draw a title over the top of the chart.
////      PFont graphTitleFont = createFont("Tahoma", 14);
////      textFont(graphTitleFont);
////      fill(120);
////      text("Heart Rate", middlePaneX + 270, height * 0.15);
////      if (heartrate < 80) {
////            // LIGHT (Blue)
////            //heartRateChart.setLineColour(color(0, 191, 255));
////            stroke(0, 191, 255); 
////        } else if (heartrate < 90) {
////            // FAT BURN (Yellow)
////            //heartRateChart.setLineColour(color(255, 223, 0));
////            stroke(255, 223, 0);
////        } else if (heartrate < 100) {
////            // MODERATE (Green)
////            //heartRateChart.setLineColour(color(34, 139, 34));
////            stroke(34, 139, 34); 
////        } 
////        //else if (heartrate < 80) {
////        //    // HARD (Orange)
////        //    stroke(255, 140, 0); 
////        //} 
////        else {
////            // PEAK (Red)
////            stroke(255, 0, 0);
////        }
////    popMatrix();
    
////    pushMatrix();
////      PFont chartFont = createFont("Tahoma", 14);
////      textFont(chartFont);
////      fill(128, 128, 128);
////    popMatrix();
    
////    pushMatrix();
////    translate(middlePaneX + 10, height * 0.1);
////      heartRateChart.draw(0, 200, middlePaneWidth - 20, 250);
////      stroke(200);
////      strokeWeight(1);
      
////      //line(18, 102-78, middlePaneWidth - 15, 102-78);
////      //line(18, 102+78, middlePaneWidth - 15, 102+78);
////      //line(18, 102+ 2 *78, middlePaneWidth - 15, 102+ 2 *78);
////      //line(18, 102, middlePaneWidth - 15, 102);
////    popMatrix();
    
    
      
////}

////float totalTime = 0;
////float lightTime = 0;    // Time in Light (Blue) zone
////float fatBurnTime = 0;  // Time in Fat Burn (Yellow) zone
////float moderateTime = 0; // Time in Moderate (Green) zone
////float hardTime = 0;     // Time in Hard (Orange) zone
////float peakTime = 0;  

////// Function to display the total time and time in each cardio zone
////void displayTimeInfo() {
////  // Define emojis for each zone
////    String veryLightEmoji = "🌫";  // Very Light (Grey)
////    String lightEmoji = "💧";        // Light (Blue)
////    String moderateEmoji = "🏃‍";   // Moderate (Green)
////    String hardEmoji = "🔥";         // Hard (Orange)
////    String peakEmoji = "⚡";         // Maximum (Red)

////    // Format time as minutes and seconds
////    String totalTimeStr = "Total Time Active: " + nf(totalTime / 60, 1, 0) + " min";
////    String lightTimeStr = veryLightEmoji + " Very Light Zone (Grey): " + nf(lightTime / 60, 1, 0) + " min";
////    String fatBurnTimeStr = lightEmoji + " Light Zone (Blue): " + nf(fatBurnTime / 60, 1, 0) + " min";
////    String moderateTimeStr = moderateEmoji + " Moderate Zone (Green): " + nf(moderateTime / 60, 1, 0) + " min";
////    String hardTimeStr = hardEmoji + " Hard Zone (Orange): " + nf(hardTime / 60, 1, 0) + " min";
////    String peakTimeStr = peakEmoji + " Maximum Zone (Red): " + nf(peakTime / 60, 1, 0) + " min";
    
////    // Draw the time information on the screen
////    pushMatrix();
////    textFont(createFont("Tahoma", 16));
////    fill(0); // Black text
////     // RIGHT PANE DATA
////    textAlign(LEFT, TOP);
////    text("Exercise zone:", rightPaneX+5, paneHeight  * 0.15);
////    fill(169, 169, 169);
////    text(lightTimeStr, rightPaneX +5, paneHeight * 0.20);
////    fill(0, 191, 255);  // Light (Blue)
////    text(fatBurnTimeStr, rightPaneX+5, paneHeight  * 0.25);
////    fill(34, 139, 34);  // Moderate (Green)
////    text(moderateTimeStr, rightPaneX+5, paneHeight  * 0.30);
////    fill(255, 165, 0);  // Hard (Orange)
////    text(hardTimeStr, rightPaneX+5, paneHeight  * 0.35);
////    fill(255, 0, 0);  // Maximum (Red)
////    text(peakTimeStr, rightPaneX+5, paneHeight* 0.40);
    
////    popMatrix();
    
////}


//void graphSerialEvent(float heartrate, float timePassed) {
//    // Append the new data points
//    heartRateY.append(heartrate);
//    timeX.append(timePassed);
    
//    // Ensure the graph only displays the most recent 100 data points
//    //if (timeX.size() > 100 && heartRateY.size() > 100) {
//    //    timeX.remove(0);
//    //    heartRateY.remove(0);
//    //}
    
//    // Calculate the percentage of the max heart rate
//    float maxHeartRate = 220 - userAge;
//    float heartRatePercent = (heartrate * 100) / maxHeartRate;
//    println("heartRatePercent: "+heartRatePercent);
    
    
    
    
//    //// Calculate the time spent in the current zone (assuming timePassed is in seconds)
//    //float deltaTime = (timeX.size() > 1) ? timeX.get(timeX.size() - 1) - timeX.get(timeX.size() - 2) : 0;
//    //totalTime += deltaTime;
    
//    //// Update time spent in each cardio zone
//    //if (heartRatePercent < 50) {
//    //    lightTime += deltaTime;
//    //} else if (heartRatePercent < 60) {
//    //    fatBurnTime += deltaTime;
//    //} else if (heartRatePercent < 70) {
//    //    moderateTime += deltaTime;
//    //} else if (heartRatePercent < 80) {
//    //    hardTime += deltaTime;
//    //} else {
//    //    peakTime += deltaTime;
//    //}
    
//    // Update the chart with new data
//    heartRateChart.setData(timeX.array(), heartRateY.array());
//}
