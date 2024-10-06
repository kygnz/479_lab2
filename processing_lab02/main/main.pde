import processing.serial.*;
import org.gicentre.utils.spatial.*;
import org.gicentre.utils.network.*;
import org.gicentre.utils.network.traer.physics.*;
import org.gicentre.utils.geom.*;
import org.gicentre.utils.move.*;
import org.gicentre.utils.stat.*;
import org.gicentre.utils.gui.*;
import org.gicentre.utils.colour.*;
import org.gicentre.utils.text.*;
import org.gicentre.utils.*;
import org.gicentre.utils.stat.*;
import org.gicentre.utils.network.traer.animation.*;
import org.gicentre.utils.io.*;

PImage bg;
int y;
int appState = 0;
boolean isInputActive = false;

Serial myPort;

void setup() {

    //String portName = Serial.list()[0]; // chnage to [0]
    //println(Serial.list());
    //myPort = new Serial(this, portName, 115200);
    //myPort.bufferUntil('\n');
    size(1200, 720);
    bg = loadImage("blue2.jpg");
    
    
    
}


void draw() {
  
  /*
  
  APP LOGIC STARTS HERE
  
  appState controls which "screen" will be displayed:
  appState = 0 will display the welcome screen, with the title and user input
  
  appState = 1 will display the default fitness mode
  appState = 2 will display stress detection
  appState = 3 will display meditation
  
  after user input is taken, the app will open automatically with fitness mode as default. 
  there will be three buttons on the left pane for the three different modes (fitness will 
   already be pressed since it is open)
   
   the middle pane will display the different graphs/functionality related to that particular mode
   
   the right pane will display statistics/key for the graphs, etc.
   
   this is just a plan i made up that i think will work easier than our last setup, 
   but lmk if you guys have other ideas :)
   
   - Kyla
  
  
  */
  
    if (appState == 0){
        drawOpeningScreen();
        // input box
        drawInputBox();
        isInputActive = true;
        submitAge = new Button("submit", width / 2 + 60, height / 2 - 25, 100, 50);
        submitAge.display();
        
    }
    else if (appState == 1){
        drawMainScreen();
    }
    
}


void serialEvent(Serial myPort) {

}
