void displayFitnessMode(){
    fill(238, 240, 242);
    rect(width * 0.25, height * 0.1, width * 0.5, height * 0.8);
    
    fill(33, 40, 48);
    textSize(15);
    text("Fitness Mode Graphs", width * .5, height * 0.15);
    drawHRGraph();
    
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
    rect(width * 0.25, height * 0.1, width * 0.5, height * 0.8);
    
    fill(33, 40, 48);
    textSize(15);
    text("Meditation display", width * .5, height * 0.15);
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
