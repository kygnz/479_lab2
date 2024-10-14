/******************************************************************************
Heart_Rate_Display.ino
Demo Program for AD8232 Heart Rate sensor.
Casey Kuhns @ SparkFun Electronics
6/27/2014
https://github.com/sparkfun/AD8232_Heart_Rate_Monitor

The AD8232 Heart Rate sensor is a low cost EKG/ECG sensor.  This example shows
how to create an ECG with real time display.  The display is using Processing.
This sketch is based heavily on the Graphing Tutorial provided in the Arduino
IDE. http://www.arduino.cc/en/Tutorial/Graph

Resources:
This program requires a Processing sketch to view the data in real time.

Development environment specifics:
	IDE: Arduino 1.0.5
	Hardware Platform: Arduino Pro 3.3V/8MHz
	AD8232 Heart Monitor Version: 1.0

This code is beerware. If you see me (or any other SparkFun employee) at the
local pub, and you've found our code helpful, please buy us a round!

Distributed as-is; no warranty is given.
******************************************************************************/
int ecgValue = 0;
int fsrValue = 0;

const unsigned long duration = 5000; // 5-second window for better accuracy
unsigned long startTime;


unsigned long lastPeakTime = 0;
int peakCount = 0;
int previousValue = 0;
bool inPeak = false;

// Smoothing parameters
const int SMOOTHING_WINDOW = 10;
int values[SMOOTHING_WINDOW] = {0};
int smoothingIndex = 0;
int totalValue = 0;
int smoothedValue = 0;

void setup() {
      startTime = millis();

  // initialize the serial communication:
  Serial.begin(115200);
  pinMode(10, INPUT); // Setup for leads off detection LO +
  pinMode(11, INPUT); // Setup for leads off detection LO -

}

void loop() {
    unsigned long currentTime = millis();

  if((digitalRead(10) == 1)||(digitalRead(11) == 1)){
    Serial.println('!');
  }
  else{
      ecgValue = analogRead(A0);
      fsrValue = analogRead(A1);
      if(ecgValue != 0){
              unsigned long currentTime = millis();

        if((millis() - startTime < duration)){
                                                unsigned long currentTime = millis();

                //  Serial.println((millis() - startTime < duration));

      // Smoothing: Implementing a simple moving average filter
      totalValue = totalValue - values[smoothingIndex]; 
      values[smoothingIndex] = ecgValue; 
      totalValue = totalValue + values[smoothingIndex];
      smoothingIndex = (smoothingIndex + 1) % SMOOTHING_WINDOW;
      smoothedValue = totalValue / SMOOTHING_WINDOW;

      // Peak detection with smoothed values
      if (!inPeak && smoothedValue > previousValue && smoothedValue > 512) {
        if (currentTime - lastPeakTime > 500) { // 500ms refractory period
          peakCount++;
          lastPeakTime = currentTime;
          inPeak = true;
        }
      } else if (smoothedValue < previousValue) {
        inPeak = false;
      }

      previousValue = smoothedValue; // Update previous smoothed value

        }
        else{
                                    //  Serial.println((millis() - startTime < duration));

          startTime=millis();
            // startTime = millis();

                          //  Serial.println((millis() - startTime < duration));
                             float bpm = (float)peakCount * (60.0 / (duration / 1000.0));
                             Serial.print("BPM: ");
                               Serial.println(bpm);
                                 peakCount = 0;
  lastPeakTime = 0;



        }

          Serial.print("ECG: ");
          Serial.println(ecgValue);
          Serial.print("FSR: ");
          Serial.println(fsrValue);

              // Serial.println(analogRead(A1));// the flex sensors

      }
      
  }
  //Wait for a bit to keep serial data from saturating
  delay(3);
}