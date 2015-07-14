#include "application.h"
#include "rest_client.h"
#include <string.h>
#include <time.h>
#include <math.h>

#define IN_PIN   D3 // button
#define OUT_PIN  D7 // led
#define POST "picture[artist]=Joseph&picture[title]=Joseph's_Button&picture[url]=http://bitmakerlabs.s3.amazonaws.com/photogur/house.jpg"

RestClient client = RestClient("www.timeapi.org");

int state = 0; // state of output pin
int reading; // input from inPin
int previous_reading = 1;

// debouncing
long toggled_time = 0;
long debounce = 500;


// String id = Spark.deviceID();

void setup() {
  Serial.begin(9600);
  delay(500);

  Serial.println("Starting connection...");

  pinMode(IN_PIN, INPUT);
  pinMode(OUT_PIN, OUTPUT);
  // Spark.variable("buttonStatus", &buttonStatus, STRING);
}

void loop() {
  reading = digitalRead(IN_PIN);

  // needs to compare current reading and previous reading
  // to check if state changed (button was pressed)
  if (reading == 1 && previous_reading == 0 && millis() - toggled_time > debounce) {
    if (state == LOW) {
      Serial.println("LED turned ON");
      state = 1;
      Serial.println("Added to cart");
      int statusCode = client.get("/utc/now");
      Serial.println(statusCode);

    } else {
      Serial.println("LED turned OFF");
      state = 0;
      Serial.println("Button reset");
    }

    toggled_time = millis();
  }

  digitalWrite(OUT_PIN, state);
  previous_reading = reading;
}
