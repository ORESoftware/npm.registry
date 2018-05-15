#!/usr/bin/env node
'use strict';

import http = require('http');
import cp = require('child_process');
import * as path from "path";
import net = require('net');
import * as https from "https";

// https://registry.npmjs.org/

// npm config set registry https://registry.npmjs.org/
// npm config set registry localhost:3441
// npm config set proxy http://localhost:3441
// npm config set https-proxy http://localhost:3441

// npm config set strict-ssl false

const s = http.createServer(function (clientRequest, clientResponse) {
  
  console.log('server got a request');
  
  if (clientRequest.url === 'x') {
    clientResponse.write('retrieve the tarball from local fs');
    clientResponse.end();
    return;
  }
  
  console.log('req.method', clientRequest.method);
  console.log('req.url', clientRequest.url);
  console.log('req.headers', clientRequest.headers);
  
  const proxy = http.request({
      hostname: 'registry.npmjs.org',
      port: 80,
      path: clientRequest.url,
      method: clientRequest.method
    },
    function (res) {
      res.pipe(clientResponse);
    });
  
  clientRequest.on('data', function(d){
    console.log('client request data:', String(d));
  });
  
  const h = clientRequest.headers;
  Object.keys(h).forEach(function(k){
      proxy.write(`${k}\t${h[k]}\r\n`);
  });
  
  clientRequest.pipe(proxy);
  
});

s.listen(3441);





