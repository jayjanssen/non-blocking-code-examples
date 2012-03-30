#!/usr/bin/perl -w

use strict;

use AnyEvent;
use AnyEvent::HTTP;

my $cv = AnyEvent->condvar;

$cv->begin;
print "Sending request for '/'\n";
http_get "http://127.0.0.1:8080/", sub {
    my( $data, $headers ) = @_;
    
    print "Got HTTP response for '/': " . $headers->{Status} . "\n";
    print "Got HTTP data for '/': " . $data . "\n";
    
    $cv->end;
};


$cv->begin;
print "Sending request for '/test'\n";
http_get "http://127.0.0.1:8080/test", sub {
    my( $data, $headers ) = @_;
    
    print "Got HTTP response for '/test': " . $headers->{Status} . "\n";
    print "Got HTTP data for '/test': " . $data . "\n";
    
    $cv->end;
};


# Waits for both 'begin's to 'end'.
$cv->wait;

