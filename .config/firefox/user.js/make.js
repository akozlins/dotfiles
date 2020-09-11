#!/bin/node

"use strict";

const fs = require("fs");
const path = require("path");

let prefs = new Map();
let user_pref = function (key, value) {
    prefs.set(key, value);
}
let del_pref = function(key) {
    if(prefs.get(key) === undefined) {
        throw `no such key: '${key}'`;
    }
    prefs.delete(key);
}

eval("" + fs.readFileSync(__dirname + "/ghacks.js"));
eval("" + fs.readFileSync(__dirname + "/my.js"));

prefs.forEach((value, key) => {
    switch(typeof(value)) {
    case "boolean" :
    case "number" :
        console.log(`user_pref("${key}", ${value})`);
        break;
    case "string" :
        console.log(`user_pref("${key}", "${value}")`);
        break;
    default :
        throw `unknown type: ${typeof(value)}`;
    }
});
