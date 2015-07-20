//
//  httparticle.cpp
//  httparticle
//
//  Created by Joseph on 2015-07-20.
//  Copyright (c) 2015 Joseph Kim. All rights reserved.
//

#include "httparticle.h"
#include "application.h"
#include "string.h"

HttParticle::HttParticle(String _address, String _hostname) {
  ip[4] = {0};
  ipAddress(_address, ip);
  hostname = _hostname;
  port = 80;
}

HttParticle::HttParticle(String _address, String _hostname, int _port) {
  ip[4] = {0};
  ipAddress(_address, ip);
  hostname = _hostname;
  port = _port;
}

void HttParticle::ipAddress(String address, byte ip[]) {
  for (int i = 0; i < 4; i++) {
    size_t pos = 0;
    ip[i] = address.substring(0, address.indexOf('.')).toInt();
    address.replace(address.substring(0, address.indexOf('.') + 1), "");
  }
}

void HttParticle::get(String path) {
  request("GET", path, NULL, "url");
}

void HttParticle::post(String path, String body, String type) {
  request("POST", path, body, type);
}

void HttParticle::put(String path, String body, String type) {
  request("PUT", path, body, type);
}

void HttParticle::del(String path, String body, String type) {
  request("DELETE", path, body, type);
}

void HttParticle::request(String verb, String path, String body, String type) {

  if (client.connect(ip, port)) {
    client.print(verb);
    client.print(" ");
    client.print(path);
    client.print(" HTTP/1.1\r\n");
    client.print("Host: ");
    client.print(hostname);
    client.print("\r\n");
    client.print("Connection: close\r\n");

    if (body != NULL) {
      client.print("Content-Length: ");
      client.print(body.length());
      client.print("\r\n");

      if (type == "url") {
        client.print("Content-Type: application/x-www-form-urlencoded\r\n\r\n");
      } else if (type == "json") {
        client.print("Accept: application/json\r\n");
        client.print("Content-Type: application/json\r\n\r\n");
      }

      client.print(body);
      client.print("\r\n\r\n");
    }

    delay(500);
    client.stop();
    delay(500);

    Serial.println("Connection successful!");
  } else {
    Serial.println("Connection failed.");
  }
}
