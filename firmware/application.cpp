/*#include "rest_client.h"*/
#include "application.h"
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
String str = "core_id=" + id;
char * post = new char[str.length() + 1];

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

void setup() {
  Serial.begin(9600);
  delay(500);

  pinMode(IN_PIN, INPUT);
  pinMode(OUT_PIN, OUTPUT);
  strcpy(post, str.c_str());

  Spark.function("cartResponse", cartResponse);
  Serial.println("Starting connection...");
}

void loop() {
  reading = digitalRead(IN_PIN);

  // needs to compare current reading and previous reading
  // to check if state changed (button was pressed)
  if (reading == 1 && previous_reading == 0 && millis() - toggled_time > debounce) {
    Serial.println("Added to cart");
    Serial.println(post);

    // int num_headers = 0;
    // const char* headers[10];
    boolean contentTypeSet;

    TCPClient client;
    byte ip[] = {54,225,135,93};
    String response = "";

    if(client.connect(ip, 80)){
      /*HTTP_DEBUG_PRINT("HTTP: connected\n");*/
      /*HTTP_DEBUG_PRINT("REQUEST: \n");*/
      // Make a HTTP request line:
      client.print("POST");
      client.print(" ");
      client.print("/products/button_order");
      client.print(" HTTP/1.1\r\n");
      // for(int i=0; i<num_headers; i++){
      //   client.print(headers[i]);
      //   client.print("\r\n");
      // }
      client.print("Host: ");
      client.print("rainforest-bitmaker.herokuapp.com");
      client.print("\r\n");
      client.print("Connection: close\r\n");

      if(post != NULL){
        char contentLength[30];
        sprintf(contentLength, "Content-Length: %d\r\n", strlen(post));
        client.print(contentLength);

        if(!contentTypeSet){
          client.print("Content-Type: application/x-www-form-urlencoded\r\n");
        }
      }

      client.print("\r\n");

      if(post != NULL){
        client.print(post);
        client.print("\r\n");
        client.print("\r\n");
      }

      //make sure you write all those bytes.
      delay(100);

      /*HTTP_DEBUG_PRINT("HTTP: call readResponse\n");*/
      /*int statusCode = readResponse(&response);*/
      /*HTTP_DEBUG_PRINT("HTTP: return readResponse\n");*/

      //cleanup
      /*HTTP_DEBUG_PRINT("HTTP: stop client\n");*/
      num_headers = 0;
      client.stop();
      delay(50);
      /*HTTP_DEBUG_PRINT("HTTP: client stopped\n");*/
      Serial.println("success");
    }else{
      /*HTTP_DEBUG_PRINT("HTTP Connection failed\n");*/
      Serial.println("connection fail");
    }

    /*int statusCode = client.request("POST", "/products/button_order", post);
    Serial.println(statusCode);*/

    toggled_time = millis();
  }

  digitalWrite(OUT_PIN, state);
  previous_reading = reading;
}
