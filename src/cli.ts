#!/usr/bin/env node
'use strict';

import http = require('http');
import cp = require('child_process');
import * as path from "path";
import net = require('net');

// https://registry.npmjs.org/

const s = net.createServer(function (s) {
  
  console.log('received request...');
  
  const k = cp.spawn('bash');
  k.stdin.end('npm pack');
  
  // k.stdin.end('exit 0;');
  
  const pwd = process.cwd();
  let stdout = '';
  
  k.stdout.on('data', function (d) {
     stdout += String(d);
  });
  
  k.stderr.pipe(process.stderr);
  
  k.once('exit', function(code){
    
      if(code > 0){
        return s.end('error');
      }
      
      const file1 = path.resolve(pwd + '/' + String(stdout).trim());
    // const file2 = path.resolve(pwd + '/' + String('ores.tgz').trim());
      const tar = cp.spawn('bash');
      tar.stdin.end(`tar c ${file1};\n`);
      tar.stdout.pipe(s);
  });
  
  
});

s.listen(3440);





