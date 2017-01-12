#!/usr/bin/env node

var mosca   = require('mosca');

var S = {
  mosca: {
    port: 1883
  },
  debug: true
};

function initMosca() {
    var server = new mosca.Server(S.mosca);   //here we start mosca

    // fired when the mqtt server is ready
    server.on('ready', function() {
        console.log('Mosca server is up and running on ', S.mosca.port)
    });

    // fired when a message is published
    server.on('published', function(packet, client) {
        // if (S.debug) {
            console.log('Published', packet);
            // console.log("Payload", packet.payload.toString());
        // }
    });

    // fired when a client connects
    server.on('clientConnected', function(client) {
        console.log('Client Connected:', client.id);
    });

    // fired when a client disconnects
    server.on('clientDisconnected', function(client) {
        console.log('Client Disconnected:', client.id);
    });
    return server;
}

initMosca();