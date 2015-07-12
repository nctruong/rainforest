#include "application.h"
#include "HttpClient.h"
#include <string.h>
#include <time.h>
#include <math.h>

#define IN_PIN   D3 // button
#define OUT_PIN  D7 // led
HttpClient http;
http_header_t headers[] = {
  { "Accept" , "*/*"},
  { NULL, NULL }
};

http_request_t request;
http_response_t response;

int state = 0; // state of output pin
int reading; // input from inPin
int previous_reading = 1;

// debouncing
long toggled_time = 0;
long debounce = 500;

// activate a purchase
String buttonStatus = "inactive";

String id = Spark.deviceID();

void setup() {
  Serial.begin(9600);
  delay(500);

  Serial.println("Starting connection...");

  pinMode(IN_PIN, INPUT);
  pinMode(OUT_PIN, OUTPUT);
  Spark.variable("buttonStatus", &buttonStatus, STRING);
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
      buttonStatus = "active";

      request.hostname = "local";
      request.port = 3000;
      request.path = "/cores";
      http.get(request, response, headers);
    } else {
      Serial.println("LED turned OFF");
      state = 0;
      Serial.println("Button reset");
      buttonStatus = "inactive";
    }

    toggled_time = millis();
  }

  digitalWrite(OUT_PIN, state);
  previous_reading = reading;
}
