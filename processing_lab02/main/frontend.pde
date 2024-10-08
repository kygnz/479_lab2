Button submitAge,
      fitnessMode,
      stressDetection,
      meditationMode;
String input = "";
int userAge;



void drawInputBox(){
    fill(255);  // White background
    noStroke(); // No outline
    rect(width/3, height/2 - 25, 250, 50, 15);  // Rounded corners (15)
    
    // Display the user input inside the field
    fill(112, 151, 117);
    textSize(20);
    textAlign(LEFT, CENTER);
    
    text(input, width/2 - 140, height/2);
}



void drawOpeningScreen(){ 
    fill(255);
    background(bg);
    
    // title
    textAlign(CENTER, CENTER);
    textSize(55);
    text("Heart Rate and Respiratory Monitor", width / 2, height / 3);
    
    // description
    textSize(25);
    text("Enter your age to begin", width / 2, height * 0.41);   
}



void drawMainScreen(){ 
    background(color(238, 240, 242));
    textAlign(CENTER, CENTER);
    textSize(35);
    text("Fitness Monitor", width / 2, height * 0.05);
    drawLeftPane();
    drawMiddlePane();
    drawRightPane();  
    drawButtonArea();
}



void drawLeftPane(){
    fill(216, 216, 216);
    rect(0, height * 0.1, width * 0.25, height * 0.9);
    fill(33, 40, 48);
    textSize(15);
    text("Statistics go here", width * .10, height * 0.15);
    
}


void drawMiddlePane(){
  fill(238, 240, 242);
  rect(width * 0.25, height * 0.1, width * 0.5, height * 0.8);
  
  fill(33, 40, 48);
  textSize(15);
  text("Select a mode to get started", width * .5, height * 0.15);
}



void drawRightPane(){
    fill(216, 216, 216);
    rect(width * 0.75, height * 0.1, width * 0.25, height * 0.9);
    
    fill(33, 40, 48);
    textSize(15);
    text("Explanation of graph\n goes here\nFor example, the key", width * .9, height * 0.15);
}



void drawButtonArea(){
    fill(225, 225, 225);
    rect(width * 0.25, height * 0.9, width * 0.5, height * 0.1);
    fill(33, 40, 48);
    //textSize(15);
    //text("Buttons to change the mode go here", width * .5, height * 0.95);
    
    fitnessMode = new Button("Fitness\nMode", width * 0.25 + 25, height * 0.92, 150, 50, color(81, 111, 163));
    stressDetection = new Button("Stress\nDetection", width * 0.44, height * 0.92, 150, 50, color(81, 111, 163));
    meditationMode = new Button("Meditation\nMode", width * 0.6 + 25, height * 0.92, 150, 50, color(81, 111, 163));
    
    fitnessMode.display();
    stressDetection.display();
    meditationMode.display();
}




void mousePressed() {
    // Check if the submit button is pressed
    if (submitAge != null && submitAge.isMouseOver()) {
        handleInput();  // Submit data when button is clicked
    }
    
    // Check if the fitness mode button is pressed
    if (fitnessMode != null && fitnessMode.isMouseOver()) {
        println("Fitness mode selected");
        appState = 2;
        fitnessMode.setColor(color(133, 154, 191));
        stressDetection.setColor(color(81, 111, 163));
        meditationMode.setColor(color(81, 111, 163));
        fitnessMode.display();
        stressDetection.display();
        meditationMode.display();
    }
    
    // Check if stress detection mode button is pressed
    if (stressDetection != null && stressDetection.isMouseOver()) {
        println("Stress detection mode selected");
        appState = 3;
        fitnessMode.setColor(color(81, 111, 163));
        stressDetection.setColor(color(133, 154, 191));
        meditationMode.setColor(color(81, 111, 163));
        fitnessMode.display();
        stressDetection.display();
        meditationMode.display();
        
    }
    
    // Check if stress detection mode button is pressed
    if (meditationMode != null && meditationMode.isMouseOver()) {
        println("Stress detection mode selected");
        appState = 4;
        fitnessMode.setColor(color(81, 111, 163));
        stressDetection.setColor(color(81, 111, 163));
        meditationMode.setColor(color(133, 154, 191));
        fitnessMode.display();
        stressDetection.display();
        meditationMode.display();
    }
    
    // Check if the user clicked inside the input box to activate it
    if (mouseX > width / 3 && mouseX < width / 3 + 250 && mouseY > height / 2 - 25 && mouseY < height / 2 + 25) {
        isInputActive = true;
    } else {
        isInputActive = false;  // Deactivate if user clicked outside input box
    }
}



// Process the input after user enters age
void handleInput() {
    try {
        userAge = Integer.parseInt(input);  // Convert input to integer
        println("User age: " + userAge);  // Output the entered age
        input = "";  // Clear the input field
        //isInputActive = false;
        appState = 1;  // Switch to the main screen after submission
    } catch (NumberFormatException e) {
        println("Invalid number input");
    }
}

void handleFitnessMode(){
  
    println("Fitness mode selected");
    appState = 2;
}



void keyPressed() {
    if (isInputActive) {
        if (keyCode == BACKSPACE) {
            if (input.length() > 0) {
                input = input.substring(0, input.length() - 1);
            }
        } 
        else {
            if (key != ENTER) {
            
                input += key;
            }
        }
    }
}
