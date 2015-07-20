/*#include "rest_client.h"*/
#include "application.h"
#include "httparticle.h"
#include <string.h>
#include <time.h>
#include <math.h>

#define IN_PIN   D3 // button
#define OUT_PIN  D7 // led

int state = 0; // state of output pin
int reading; // input from inPin
int previous_reading = 1;

// debouncing
long toggled_time = 0;
long debounce = 500;

// Core id
String id = Spark.deviceID();
String str = "{\"core_id\":\"" + id + "\"}";

// Spark Function: LED status indicator
int cartResponse(String status) {
  if (status == "success") {
    digitalWrite(OUT_PIN, 1);
    delay(500);
    digitalWrite(OUT_PIN, 0);
    return 1;
  } else if (status == "error") {
    for (int i = 0; i < 5; i++) {
      digitalWrite(OUT_PIN, 1);
      delay(100);
      digitalWrite(OUT_PIN, 0);
      delay(100);
    }
    return 0;
  }
}

HttParticle client = HttParticle("54.225.135.93", "rainforest-bitmaker.herokuapp.com");

void setup() {
  Serial.begin(9600);
  delay(500);

  pinMode(IN_PIN, INPUT);
  pinMode(OUT_PIN, OUTPUT);

  Spark.function("cartResponse", cartResponse);
  Serial.println("Starting connection...");
}

void loop() {
  reading = digitalRead(IN_PIN);

  // needs to compare current reading and previous reading
  // to check if state changed (button was pressed)
  if (reading == 1 && previous_reading == 0 && millis() - toggled_time > debounce) {

    client.post("/products/button_order", str, "json");
    
    toggled_time = millis();
  }

  digitalWrite(OUT_PIN, state);
  previous_reading = reading;
}
