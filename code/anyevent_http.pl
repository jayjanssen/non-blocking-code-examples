#!/usr/bin/perl -w

use strict;

use AnyEvent;
use AnyEvent::HTTP;

my $cv = AnyEvent->condvar;

http_get "http://forecast.weather.gov/MapClick.php?lat=42.12100&lon=-77.94750&FcstType=dwml", sub {
    my( $data, $headers ) = @_;
    
    print "Got HTTP response: " . $headers->{Status} . "\n";
    
    $cv->send;
};

print "Request sent\n";

$cv->wait;

print "Data received\n";