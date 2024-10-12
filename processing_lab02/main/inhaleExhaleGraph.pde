XYChart inexChart;

//float maxRespRate;
//FloatList inexTimeX;
//FloatList respRateY;


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
    
      // update x axis max
      
      inexChart.setMaxY(200); // max heartrate based on user age 
    
      // Define the position and size of the chart to match the middle pane
      float chartX = width * 0.25 + 25;
      float chartY = height * 0.6;
      float chartWidth = width * 0.5 - 50;
      float chartHeight = height * 0.2;
    
      // Draw the chart background
      //fill(238, 240, 242);
      //rect(chartX, chartY, chartWidth, chartHeight);
      
      // Draw axes
      stroke(33, 40, 48);
      //line(chartX, chartY + chartHeight - 40, chartX + chartWidth, chartY + chartHeight - 40); // X-axis
      //line(chartX + 40, chartY, chartX + 40, chartY + chartHeight); // Y-axis
      line(chartX + 40, chartY + chartHeight - 40, chartX + chartWidth, chartY + chartHeight - 40); // X-axis.
      line(chartX + 40, chartY, chartX + 40, chartY + chartHeight - 40); // Y-axis.
      
      // Add Y-axis labels (heart rate), starting from 40 instead of 0
      float minY = 40;  // Start Y-axis at 40
      float maxY = 200;  // Maximum Y-axis value (max heart rate)
      textAlign(RIGHT, CENTER);
      
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
    
    
      
       // Display the elapsed time
        textSize(14);
        fill(0);
        fill(120);
        text("Elapsed Time: " + elapsedTime + " sec", chartX + chartWidth / 2, chartY + chartHeight + 20);

    
    popMatrix();
  
}

void inhalationSerialEvent(float respiratoryRate, float timePassed){
    
  
  
  
}
