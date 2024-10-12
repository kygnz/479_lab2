void displayFitnessMode(){
    fill(238, 240, 242);
    //stroke(216, 216, 216);
    noStroke(); // No outline
    rect(width * 0.25, height * 0.1, width * 0.5, height * 0.8);
    
    fill(33, 40, 48);
    textSize(15);
    text("Fitness Mode Graphs", width * .5, height * 0.15);
    
    if (!baselineCollected) {
      fill(100);
      text("Collecting baseline... ", width / 2 - 50, height / 2);
      text((15 - (millis() - baselineStartTime) / 1000) + " seconds left", width / 2 + 100, height / 2);
    } else {
        drawHRGraph();
        drawRespGraph();
        drawInhalationGraph();
    }
    
    
}

void displayStressDetection(){
    fill(238, 240, 242);
    rect(width * 0.25, height * 0.1, width * 0.5, height * 0.8);
    
    fill(33, 40, 48);
    textSize(15);
    text("Stress detection display", width * .5, height * 0.15);
}

void displayMeditationMode(){
    fill(238, 240, 242);
    
    image(meditatebg, width * 0.25, height * 0.1, width * 0.5, height * 0.8);
    noFill();
    stroke(0);
    rect(width * 0.25, height * 0.1, width * 0.5, height * 0.8);
    
    fill(240);
    textSize(35);
    text("Let's Meditate!", width * .5, height * 0.35);
}

void displayHRGraph(){
    //fill(0);
    //text("Heart Rate", 10, 60);
    //stroke(255, 0, 0);
    //noFill();
    //beginShape();
    //for (int i = 0; i < 220; i++) {
    //  float y = map(heartBuffer.get(i), 0, 1023, height, 100);
    //  vertex(i, y);
    //}
    //endShape();
}
