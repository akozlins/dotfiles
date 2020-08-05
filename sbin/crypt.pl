#!/bin/perl -w

if ( $#ARGV + 1 != 2 ) {
    print "Usage $0 <password> <salt>\n";
    exit;
}

my $password = $ARGV[0];
my $salt = $ARGV[1];

print crypt($password, "\$6\$$salt\$");
