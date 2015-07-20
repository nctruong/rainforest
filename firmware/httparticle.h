//
//  httparticle.h
//  httparticle
//
//  Created by Joseph on 2015-07-20.
//  Copyright (c) 2015 Joseph Kim. All rights reserved.
//

#include "application.h"
#include <string.h>

class HttParticle {
  public:
    HttParticle(String _address, String _hostname);
    HttParticle(String _address, String _hostname, int _port);

    // returns status code
    void request(String verb, String path, String body, String type);

    // GET request
    void get(String path);

    // POST request
    void post(String path, String body, String type); // supports url(encoded) & json

    // PUT request
    void put(String path, String body, String type);

    // DELETE requests
    void del(String path, String body, String type);

  private:
    TCPClient client;
    void ipAddress(String address, byte ip[]);
    byte ip[4];
    String hostname;
    int port;
};
