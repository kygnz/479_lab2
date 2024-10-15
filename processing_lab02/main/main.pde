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
PImage meditatebg;
int y;
int appState = 0;
boolean isInputActive = false;


FloatList ecgReadings = new FloatList(); // Store ECG values for smoothing
int numReadings = 10; // Number of readings to average for smoothing

// FSR variables:
FloatList fsrBuffer = new FloatList();
int bufferSize = 50;

// For breath detection
float previousValue = 0;
boolean isInhale = false;
boolean potentialPeak = false;
boolean potentialValley = false;
int breathCount = 0;
int minBreathInterval = 2000; // Minimum interval between breaths in milliseconds
float previousFSRValue = 0;
int lastBreathTime = 0;
float minPeakAmplitude = 20; // Minimum change to consider a peak (adjust as needed)
FloatList fsrReadings = new FloatList();
float restingRespRate = 0;
int windowSize = 60000;
FloatList breathTimes = new FloatList();

int inhaleStartTime = 0;
int exhaleStartTime = 0;
float inhalePeriod = 0;
float exhalePeriod = 0;
FloatList inhalePeriods = new FloatList();  // List to store inhalation times
FloatList exhalePeriods = new FloatList();  // List to store exhalation times
int maxBreathsStored = 10;

// MEDITATION VARIABLES
boolean inMeditationMode = false;
float circleSize = 50;
int incorrectBreaths = 0;
boolean breathingPatternCorrect = true;
boolean showAlert = false;

// HR VARIABLES
FloatList baselineData = new FloatList();
boolean baselineCollected = false;
int baselineDuration = 5000; // 30 seconds in milliseconds
float baselineAverage = 0;
float threshold = 0;
float fsrThreshold = 0;
boolean belowThreshold = true;
float baselineStartTime;
float startTime;
int beat_old = 0;
float currentHeartRate = 0;

int bpmstartTime,bpmtimePassed=0;



Serial myPort;
float a0;

void setup() {

    String portName = Serial.list()[4]; // chnage to [0]
    println(Serial.list());
    myPort = new Serial(this, portName, 115200);
    myPort.bufferUntil('\n');
    size(1350, 1000);
    bg = loadImage("blue.jpg");
    meditatebg = loadImage("meditate.jpg");
    
    // Start collecting the baseline
    baselineStartTime = millis();
    respiratoryGraphSetup();
    graphSetup();
    //ecggraphSetup();
    inhalationGraphSetup();  
    
}


void draw() {
  
    // COLLECTING 30 SECOND BASELINE DATA
    if (!baselineCollected) {
        float timeLeft = 30 - (millis() - baselineStartTime) / 1000.0;
        text("Collecting baseline... " + nf(timeLeft, 0, 2) + " seconds left", width / 2, height / 2);

        // If 30 seconds have passed, calculate the threshold
        if (millis() - baselineStartTime >= 30000) {
            calculateThreshold();
            baselineCollected = true;
            restingRespRate = calculateRestingRespRate();
            breathCount = 0; // reset breath count
            //restingRespRate = getRestingRespRate();
            println("Baseline collected. Resting Respiratory Rate: " + restingRespRate + " breaths/min");
            println("Baseline collected. HR Threshold set to: " + threshold);
        }
    } else {
        startTime = millis();
        //fill(0);
        text("Resting respiratory rate: " + nf(restingRespRate, 0, 2) +  " bpm", width * .15, height * 0.29);
        //text("Resting Respiratory Rate: " + nf(restingRespRate, 0, 2) + " breaths/min", width / 2, height / 2 + 50);
        //text("Current Heart Rate: " + nf(currentHeartRate, 0, 2) + " BPM", width / 2, height / 2);
        //drawLeftPane();
        
        if (inMeditationMode) {
          println("----------------------------------");
          
        //drawBreathingGuide();  // Display the growing and shrinking circle
        checkBreathingPattern();  // Continuously check the breathing pattern
        
        // Show an alert if the breathing pattern is incorrect for 3 consecutive breaths
        if (showAlert) {
            fill(255, 0, 0); // Red indicator
            textSize(32);
            text("Adjust Your Breathing!", width / 2, height / 2);
        }
    }
        
   }
    
    
    // SCREEN DISPLAY LOGIC
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
    
}




void serialEvent(Serial myPort) {
    while (myPort.available() > 0) {
        String inputString = myPort.readStringUntil('\n');
        if (inputString != null) {
            inputString = trim(inputString);
            
            if (inputString.equals("!")) {
                println("!\n");
            } 
            // ECG DATA PROCESSING
            else if (inputString.startsWith("ECG: ")){
                float ecgValue = float(trim(inputString.substring(5)));
              
                float smoothedValue = smoothECG(ecgValue);
                if (!baselineCollected) {
                    baselineData.append(smoothedValue); // Collect baseline data
                } else {
                    if(ecgValue>=200 && ecgValue<=800){
                 print("ECG: ");
                println(ecgValue);
             //ecggraphSerialEvent( ecgValue);
                }
                    processECG(smoothedValue); // Process smoothed ECG values for peak detection
                }
            }
            // FSR DATA PROCESSING
            else if (inputString.startsWith("FSR: ")){
                float fsrValue = float(trim(inputString.substring(5)));
                fsrBuffer.append(fsrValue);
                // Keep the buffer size manageable
                if (fsrBuffer.size() > bufferSize) {
                    fsrBuffer.remove(0);
                }
                float smoothedValue = noiseReduceFSR();
                
                if (!baselineCollected) {
                    fsrReadings.append(smoothedValue);
                    detectBreath(smoothedValue);
                } else {
                    // After baseline collection, continue processing
                    processFSR(smoothedValue);
                    //print("FSR: ");
                    //println(fsrValue);
                } 
            }  // for bpm
             else if (inputString.startsWith("BPM: ")){
                bpmtimePassed = int(((millis() - bpmstartTime) / 1000.0)); 
                float bpmValue = float(trim(inputString.substring(5)));
                  print("BPM: ");
                    println(bpmValue);
                    if(bpmValue<180 && bpmValue>65 ){
                        print("BPM: ");
                    println(bpmValue);
                    println(bpmValue-30);
                    currentHeartRate=bpmValue;
                graphSerialEvent((bpmValue-30), bpmtimePassed);
                    }

             
                
                
            }
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
            //graphSerialEvent(currentHeartRate, beat_new);
            println("Heart rate: " + currentHeartRate + " BPM");
        }

        belowThreshold = false; // Prevent multiple detections of the same peak
    }

    // Reset belowThreshold when the value drops below the threshold again
    if (smoothedValue < threshold) {
        belowThreshold = true;
    }
}

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




float noiseReduceFSR(){
    int numSamples = min(fsrBuffer.size(), 10); // Use the last 10 samples
    float sum = 0;
    for (int i = fsrBuffer.size() - numSamples; i < fsrBuffer.size(); i++) {
        sum += fsrBuffer.get(i);
    }
    return sum / numSamples;
}




void detectBreath(float currentValue) {
    int currentTime = millis();
    float delta = currentValue - previousValue;
    
    if (delta > minPeakAmplitude && !potentialPeak) {
        // Potential inhale (peak)
        potentialPeak = true;
        potentialValley = false;
    } else if (delta < -minPeakAmplitude && potentialPeak) {
        // Potential exhale (valley)
        potentialValley = true;
        potentialPeak = false;
    }
    
    // Check if a full breath cycle has occurred
    if (potentialValley && (currentTime - lastBreathTime) > minBreathInterval) {
        breathCount++;
        lastBreathTime = currentTime;
        potentialValley = false; // Reset for the next cycle
    }
    
    previousValue = currentValue;
}



float calculateRestingRespRate() {
    float durationInMinutes = baselineDuration / 60000.0; // Convert milliseconds to minutes
    return breathCount / durationInMinutes; // Breaths per minute
}



void processFSR(float fsrValue) {
    int currentTime = millis();

    // Apply the same breath detection logic used during baseline
    float delta = fsrValue - previousFSRValue;
    
    if (delta > minPeakAmplitude && !isInhale) {
        // Detect inhale (peak)
        inhaleStartTime = currentTime;
        isInhale = true;
        // If exhalation just finished, calculate the exhalation period
        if (exhaleStartTime > 0) {
            exhalePeriod = (inhaleStartTime - exhaleStartTime) / 1000.0;  // Exhalation period in seconds
            exSerialEvent(exhalePeriod, currentTime / 1000.0);

            // Limit the number of stored exhalation periods
            if (exhalePeriods.size() > maxBreathsStored) {
                exhalePeriods.remove(0);
            }
        }
    } else if (delta < -minPeakAmplitude && isInhale) {
        // Detect exhale (valley) and check if enough time has passed since last breath
        if (currentTime - lastBreathTime > minBreathInterval) {
            // Valid breath detected, store the time of the breath
            //breathTimes.append(currentTime);
            int inhaleEndTime = currentTime;
            //lastBreathTime = currentTime;
            // Calculate the inhalation period
            inhalePeriod = (inhaleEndTime - inhaleStartTime) / 1000.0;  // Inhalation period in seconds
            inSerialEvent(inhalePeriod, currentTime / 1000.0);

            // Mark the start of exhalation
            exhaleStartTime = inhaleEndTime;
            isInhale = false;  // Exhalation in progress

            // Store the breath time
            breathTimes.append(currentTime);
            lastBreathTime = currentTime;
            //isInhale = false; // Reset for the next cycle
            
            // Remove old breath times that are outside of the window size (1 minute)
            while (breathTimes.size() > 0 && breathTimes.get(0) < currentTime - windowSize) {
                breathTimes.remove(0);
            }
            
            // Calculate respiratory rate based on breaths in the last minute
            float respiratoryRate = breathTimes.size() * (60000.0 / windowSize); // Breaths per minute

            // Send the respiratory rate and time to the graph function
            //println("Time: " + currentTime + ", Respiratory Rate: " + respiratoryRate);
            respiratorySerialEvent(respiratoryRate, currentTime / 1000.0); // time in seconds
        }
    }
    
    previousFSRValue = fsrValue; // Store the current FSR value for the next cycle
}
