#!/bin/node
"use strict";

const fs = require("fs");
const path = require("path");

const read_prefs = function(prefs, f, warn = true) {
    const user_pref = function(key, value) {
        prefs.set(key, value);
    };
    eval("" + fs.readFileSync(f));
};

const FIREFOX_HOME = path.normalize(__dirname + "/..");

const prefs = new Map();
read_prefs(prefs, FIREFOX_HOME + "/ghacks-user.js/user.js", warn = False);
read_prefs(prefs, FIREFOX_HOME + "/user.js/ghacks.js");
read_prefs(prefs, FIREFOX_HOME + "/user.js/my.js");

prefs.forEach((value, key) => {
    if ( value === null ) return;
    const value_type = typeof(value);

    if ( value_type === "boolean" && value === false )
        value = "false";
    else if ( value_type === "boolean" && value === true )
        value = "true";
    else if ( value_type === "number" )
        value = value;
    else if ( value_type === "string" )
        value = '"' + value + '"';
    else
        throw `unknown type: ${value_type}`;

    console.log(`user_pref("${key}", ${value});`);
});
