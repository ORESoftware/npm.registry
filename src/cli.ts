#!/usr/bin/env node
'use strict';

// import http = require('http');
//
//
// (function(){
//
//   return;
//
//   // https://registry.npmjs.org/
//
//   const s = http.createServer(function(req,res){
//
//     res.write('got it');
//     res.end();
//   });
//
//
//   s.listen(3440);
//
// })();


console.log('loading nock..3.');

var nock = require('nock');

nock('http://registry.npmjs.org/')
  .get('/')
  .reply(200, function(uri: any, requestBody: any) {
    console.log('path:', this.req.path);
    console.log('headers:', this.req.headers);
    this.res.json({foo:'bar'})
  });



