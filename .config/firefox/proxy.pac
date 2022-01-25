"use strict";

let patterns = [
    "example.com"
];

let socks5 = "SOCKS5 localhost:1080";

function FindProxyForURL(url, host) {
    for(let i = 0; i < patterns.length; i++) {
        let p = patterns[i];
        if(shExpMatch(host, p) || shExpMatch(host, "*." + p)) {
            return socks5;
        }
    }

//    if(shExpMatch(host, "example.com") || shExpMatch(host, "*.example.com")
//    ) {
//        return socks5;
//    }

    return "DIRECT";
}
