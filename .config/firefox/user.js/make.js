#!/bin/node

"use strict";

const fs = require("fs");
const path = require("path");

let prefs = new Map();
let user_pref = function(key, value) {
    prefs.set(key, value);
}

let eval_file = function(f) {
    eval("" + fs.readFileSync(f));
}

const FIREFOX_HOME = path.normalize(__dirname + "/..");

eval_file(FIREFOX_HOME + "/user.js/ghacks.js");
eval_file(FIREFOX_HOME + "/user.js/my.js");

prefs.forEach((value, key) => {
    if(value === null) return;
    switch(typeof(value)) {
    case "boolean" :
    case "number" :
        console.log(`user_pref("${key}", ${value});`);
        break;
    case "string" :
        console.log(`user_pref("${key}", "${value}");`);
        break;
    default :
        throw `unknown type: ${typeof(value)}`;
    }
});
