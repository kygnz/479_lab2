void displayFitnessMode(){
  background(238, 240, 242); // Clear the previous elements
    drawMainScreen(); // Common elements in all modes
    fill(238, 240, 242);
    //stroke(216, 216, 216);
    noStroke(); // No outline
    rect(width * 0.25, height * 0.1, width * 0.5, height * 0.8);
    
    fill(33, 40, 48);
    textSize(20);
    text("Fitness Mode Graphs", width * .5, height * 0.10);
    
    if (!baselineCollected) {
      fill(100);
      text("Collecting baseline... ", width / 2 - 50, height / 2);
      text(int(30 - (millis() - baselineStartTime) / 1000) + " seconds left", width / 2 + 100, height / 2);
    } else {
        drawHRGraph();
        //drawRespGraph();
        drawecgGraph();
        drawInhalationGraph();
    }
    
    
}

void displayStressDetection(){
    background(238, 240, 242); // Clear the previous elements
    drawMainScreen(); // Common elements in all modes
    fill(238, 240, 242);
    rect(width * 0.25, height * 0.1, width * 0.5, height * 0.8);
    
    fill(33, 40, 48);
    textSize(15);
    text("Stress Detection Mode", width * .5, height * 0.15);
    
    if (!baselineCollected) {
      fill(100);
      text("Collecting baseline... ", width / 2 - 50, height / 2);
      text((30 - (millis() - baselineStartTime) / 1000) + " seconds left", width / 2 + 100, height / 2);
    } else {
      drawHRGraph();
    }
}

void displayMeditationMode(){
    background(238, 240, 242); // Clear the previous elements
    drawMainScreen(); // Common elements in all modes
    inMeditationMode  = true;
    fill(238, 240, 242);
    
    image(meditatebg, width * 0.25, height * 0.1, width * 0.5, height * 0.8);
    //noFill();
    //noStroke(); // No outline
    //rect(width * 0.25, height * 0.1, width * 0.5, height * 0.8);
    
    fill(240);
    textSize(35);
    text("Meditation", width * .5, height * 0.15);
    if (!baselineCollected) {
      textSize(15);
      text("Loading... ", width / 2 - 60, height / 2);
      text((30 - (millis() - baselineStartTime) / 1000) + " seconds left", width / 2 + 50, height / 2);
    } else {
        text("Now, Breathe", width * .5, height * 0.3);
        fill(255, 150); 
        noStroke();
        rect(width * 0.25 + 25, height * 0.65 + 25, width * 0.5 - 50, height * 0.3);
        drawInhalationGraph();
        
        
        
    }
}

//void drawBreathingGuide() {
//    pushMatrix();
//    translate(width / 2, height / 2);

//    // Change the circle size based on inhalation/exhalation duration
//    if (isInhale) {
//        // Inhale: Grow the circle
//        circleSize = map(millis() - inhaleStartTime, 0, inhalePeriod * 1000, 50, 200);
//    } else {
//        // Exhale: Shrink the circle
//        circleSize = map(millis() - exhaleStartTime, 0, exhalePeriod * 1000, 200, 50);
//    }

//    // Draw the breathing circle
//    fill(100, 200, 255, 150); // Light blue
//    ellipse(0, 0, circleSize, circleSize); // Centered circle that grows/shrinks

//    popMatrix();
//}

// Check if the breathing pattern matches the 1:3 ratio of inhale to exhale
void checkBreathingPattern() {
    if (exhalePeriod > 0) {
        // Check if inhalePeriod is approximately one-third of exhalePeriod
        if (inhalePeriod > (exhalePeriod / 3.0) * 1.2 || inhalePeriod < (exhalePeriod / 3.0) * 0.8) {
            incorrectBreaths++; // Increment if the pattern doesn't match
        } else {
            incorrectBreaths = 0; // Reset if the pattern is correct
        }

        // If 3 consecutive incorrect breaths are detected, activate the alert
        if (incorrectBreaths >= 3) {
            showAlert = true;
        } else {
            showAlert = false;
        }
    }
}
