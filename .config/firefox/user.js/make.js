#!/bin/node
"use strict";

const fs = require("fs");
const path = require("path");

const read_prefs = function(prefs, f) {
    const user_pref = function(key, value) {
        prefs.set(key, value);
    };
    eval("" + fs.readFileSync(f));
};

const FIREFOX_HOME = path.normalize(__dirname + "/..");

const prefs = new Map();
read_prefs(prefs, FIREFOX_HOME + "/user.js/ghacks.js");
read_prefs(prefs, FIREFOX_HOME + "/user.js/my.js");

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
