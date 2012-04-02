#!/usr/bin/perl -w 

use strict;

use AnyEvent;

my $cv = AnyEvent->condvar;

my $t; $t = AnyEvent->timer( after => 5, cb => sub { print "5 seconds passed\n"; $cv->send; });

my $t2; $t2 = AnyEvent->timer( interval => 1, cb => sub {print "1 second passed\n"; });

$cv->wait;