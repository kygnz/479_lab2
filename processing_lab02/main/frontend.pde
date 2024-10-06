Button submitAge;
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
    
    //if (input.equals("") && !isInputActive){
    //    text(inputText, width/2 - 140, height/2);
    //} else{
        text(input, width/2 - 140, height/2);
    //}
  
  
}

void drawOpeningScreen(){
  
    fill(255);
    background(bg);
    //stroke(226, 204, 0);
    //line(0, y, width, y);
  
    //y++;
    //  if (y > height) {
    //    y = 0;
    //  }
    //}
    //background(color(152, 201, 163));
    
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
    textSize(55);
    text("Main stuff will go here", width / 2, height / 3);
 
        
}


void mousePressed() {
    // Check if the submit button is pressed
    if (submitAge != null && submitAge.isMouseOver()) {
        handleInput();  // Submit data when button is clicked
    }
    
    // Check if the user clicked inside the input box to activate it
    if (mouseX > width / 3 && mouseX < width / 3 + 250 && mouseY > height / 2 - 25 && mouseY < height / 2 + 25) {
        isInputActive = true;  // Activate the input field
    } else {
        isInputActive = false;  // Deactivate if clicked outside
    }
}

void handleInput() {
    // Process the input when the submit button is clicked
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
