//TODO: 
//- finish meditation mode
//- accurate HR values
//- change line colors on HR graph
//- stress detection
//- add labels to graphs
//- display:
//    - resting HR
//    - current heart rate
//    - graph color guide
// innovative application for device
    

class Button {
  
    float x, y;
    int buttonWidth, buttonHeight;
    String buttonText;
    
    
    //this.background(color(237, 234, 208)); 
    //color textColor = ;
    int cornerRadius;
    boolean isPressed = false;
    color buttonColor;
    
    // Class constructor
    Button(String buttonText, float x, float y, int buttonWidth, int buttonHeight, color buttonColor){
      
        this.buttonText = buttonText;
        this.x = x;
        this.y = y;
        this.buttonWidth = buttonWidth;
        this.buttonHeight = buttonHeight;
        this.buttonColor = buttonColor;
      
    }
    
    // 81, 111, 163
    void display(){
        fill(buttonColor); 
        noStroke();
        rect(x, y, buttonWidth, buttonHeight, 15);
         
        fill(255);
        textAlign(CENTER, CENTER);
        textSize(20);
        text(buttonText, x + buttonWidth / 2, y + buttonHeight / 2);
 
    }
    
    
    boolean isMouseOver() {
        return mouseX > x && mouseX < x + buttonWidth && mouseY > y && mouseY < y + buttonHeight;
    }
    
    void setColor(color buttonColor){
      this.buttonColor = buttonColor;
    }

    //void isMousePressed() {
    //    if (isMouseOver()) {
    //        isPressed = true;
    //    }
    //    else {
    //      isPressed = false;
    //    }
    //}

    //void buttonPressAction() {
    //    if (isPressed && isMouseOver()) {
    //        // pressed action:
    //        // check for user age
    //        // use that as x axis for the graph
    //        println("User submitted: " + inputText);
    //    }
    //    isPressed = false;  // Reset the press state
    //}
    
    

}
