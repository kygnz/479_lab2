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


//Serial myPort;
PImage bg;
int y;
int appState = 0;
boolean isInputActive = false;


FloatList ecgReadings = new FloatList(); // Store ECG values for smoothing
int numReadings = 10; // Number of readings to average for smoothing

FloatList baselineData = new FloatList();
boolean baselineCollected = false;
int baselineDuration = 15000; // 15 seconds in milliseconds
float baselineAverage = 0;
float threshold = 0;
boolean belowThreshold = true;
float baselineStartTime;
float startTime;
int beat_old = 0;
float currentHeartRate = 0;


Serial myPort;
float a0;

void setup() {

    String portName = Serial.list()[0]; // chnage to [0]
    println(Serial.list());
    myPort = new Serial(this, portName, 115200);
    myPort.bufferUntil('\n');
    size(1350, 900);
    bg = loadImage("blue3.jpg");
    
    // Start collecting the baseline
    baselineStartTime = millis();
    
    graphSetup();
    
    
    
}


void draw() {
  
  /*
  
  -------- MAIN APP LOGIC STARTS HERE ----------------------------------
  
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
   
  */
  
  
  
    if (!baselineCollected) {
        float timeLeft = 15 - (millis() - baselineStartTime) / 1000;
        text("Collecting baseline... " + nf(timeLeft, 0, 2) + " seconds left", width / 2, height / 2);

        // If 15 seconds have passed, calculate the threshold
        if (millis() - baselineStartTime >= 15000) {
            calculateThreshold();
            baselineCollected = true;
            println("Baseline collected. Threshold set to: " + threshold);
        }
    } else {
        startTime = millis();
        text("Current Heart Rate: " + nf(currentHeartRate, 0, 2) + " BPM", width / 2, height / 2);
    }
    
    
    
    
    if (appState == 0){
        drawOpeningScreen();
        // input box
        drawInputBox();
        isInputActive = true;
        submitAge = new Button("submit", width / 2 + 60, height / 2 - 25, 100, 50, color(210, 198, 198));
        submitAge.display();
        
    }
    else if (appState == 1){
        drawMainScreen();
    }
    else if (appState == 2){
        displayFitnessMode();
    }
    else if(appState == 3){
        displayStressDetection();
    }
    else if(appState == 4){
        displayMeditationMode();
    }
    
    //// Display the current heart rate or baseline status
    //fill(0);
    //textSize(25);
    //if (!baselineCollected) {
    //  text("Collecting baseline... " + (15 - (millis() - baselineStartTime) / 1000) + " seconds left", width / 2, height / 2);
    //} else {
    //  text("Current Heart Rate: " + nf(currentHeartRate, 0, 2) + " BPM", width / 2, height / 2);
    //}
    
}


void serialEvent(Serial myPort) {
    while (myPort.available() > 0) {
        String inputString = myPort.readStringUntil('\n');
        if (inputString != null) {
            inputString = trim(inputString);
            
            if (inputString.equals("!")) {
                println("!\n");
            } 
            else {
              
                try {
                      Float ecgValue = Float.parseFloat(inputString);
                      float smoothedValue = smoothECG(ecgValue);
                      if (!baselineCollected) {
                          baselineData.append(smoothedValue); // Collect baseline data
                      } else {
                          processECG(smoothedValue); // Process smoothed ECG values for peak detection
                      }
                      //if(baselineCollected){
                          //println(inputString + "\n");
                      //}
                } catch (NumberFormatException e) {
                    println("Error parsing value: " + inputString);
                }
            }
            
            // Display the current heart rate
            //fill(255);
            //textSize(15);
            //text("Current Heart Rate: " + nf(currentHeartRate, 0, 2) + " BPM", 150, height / 2);
            
        }
    }
}



void processECG(float smoothedValue) {
    // Detect R-peaks using the smoothed ECG values
    if (smoothedValue > threshold && belowThreshold) {
        int beat_new = millis();
        int diff = beat_new - beat_old; // Time difference between this beat and the last beat

        if (diff > 300) { // Ensure that time between peaks is reasonable
            float bpm = 60000.0 / diff; // Calculate BPM
            currentHeartRate = bpm; // Update current heart rate
            beat_old = beat_new; // Update the last beat time

            // Call graphSerialEvent with heart rate and time for graphing
            graphSerialEvent(currentHeartRate, beat_new);
            println("Heart rate: " + currentHeartRate + " BPM");
        }

        belowThreshold = false; // Prevent multiple detections of the same peak
    }

    // Reset belowThreshold when the value drops below the threshold again
    if (smoothedValue < threshold) {
        belowThreshold = true;
    }
}


//boolean isPeak(float ecgValue) {
//  // Simple peak detection algorithm:
//  // Consider a peak if the current value is greater than a threshold and its neighbors
//  if (ecgData.size() < 5) return false; // Ensure enough data for peak detection

//  int lastIndex = ecgData.size() - 1;
//  //float prevValue = ecgData.get(lastIndex - 1);
//  //float nextValue = ecgValue; // The current value is considered the next value in this context
//  float currentValue = ecgData.get(lastIndex);

//  // Compare the current value against its neighbors to determine if it's a peak
//  float maxNeighbor = max(ecgData.get(lastIndex - 2), ecgData.get(lastIndex - 1), ecgValue);
//  float minNeighbor = min(ecgData.get(lastIndex - 2), ecgData.get(lastIndex - 1), ecgValue);

//  return currentValue > threshold && currentValue > maxNeighbor && minNeighbor < threshold;
//  //return currentValue > threshold && prevValue < currentValue && nextValue < currentValue;
//}



void calculateThreshold() {
    // Calculate the mean of the collected baseline data
    float sum = 0;
    for (int i = 0; i < baselineData.size(); i++) {
        sum += baselineData.get(i);
    }
    float baselineAverage = sum / baselineData.size();

    // Set the threshold to a percentage above the baseline average (e.g., 1.1 times the average)
    threshold = baselineAverage * 1.1; // Adjust this multiplier as needed
}



//void calculateBPM() {
//    int beat_new = millis();  // Record the current time
//    int diff = beat_new - beat_old;  // Calculate the time difference between beats

//    if (diff > 300) {
//        float currentBPM = 60000.0 / diff;  // Calculate BPM
//        beats[beatIndex] = currentBPM;  // Store the BPM value in the array
//        //float total = 0.0;
//        //for (int i = 0; i < 500; i++) {
//        //    total += beats[i];
//        //}
//        //currentHeartRate = total / 500.0;  // Calculate the average BPM
//        //beat_old = beat_new;  // Update the time of the last detected beat
//        //beatIndex = (beatIndex + 1) % 500;  // Cycle through the array

//        //// Call graphSerialEvent with the heart rate and time
//        //println("Graphing...\n");
//        //graphSerialEvent(currentHeartRate, beat_new);
//        //println("Heart rate: " + currentHeartRate + " BPM");
//        beatIndex = (beatIndex + 1) % 500;

//        // Update the valid beat count if not yet at the maximum
//        if (validBeatsCount < 500) {
//            validBeatsCount++;
//        }

// println("Graphing...\n");
//        // Calculate the current heart rate as the average of recent values
//        float total = 0.0;
//        for (int i = 0; i < validBeatsCount; i++) {
//            total += beats[i];
//        }
//        currentHeartRate = total / validBeatsCount;

//        beat_old = beat_new;

//        // Call graphSerialEvent with the heart rate and time
       
//        graphSerialEvent(currentHeartRate, beat_new);
//        println("Heart rate: " + currentHeartRate + " BPM");
//    }
//}



//void calculateBaselineAverage() {
//    if (baselineBPMs.size() > 0) {
//        float total = 0.0;
//        for (int i = 0; i < baselineBPMs.size(); i++) {
//            total += baselineBPMs.get(i);
//        }
//        currentHeartRate = total / baselineBPMs.size();  // Calculate the average BPM
//    } else {
//        currentHeartRate = 0;  // Default to 0 if no valid BPMs were collected
//    }
//}


// averages the last few readings to reduce noise
float smoothECG(float ecgValue) {
    // Add the new value to the list:
    ecgReadings.append(ecgValue);
    // Keep only the last 'numReadings' values:
    if (ecgReadings.size() > numReadings) {
        ecgReadings.remove(0);
    }

    // Calculate the average of the last 'numReadings' values:
    float total = 0;
    for (float value : ecgReadings) {
        total += value;
    }
    return total / ecgReadings.size();
}
