#!/usr/bin/perl -w

use strict;

use AnyEvent;

my $t; $t = AnyEvent->timer( after => 1, cb => sub{ print "timer fired!\n" });

print "MODEL: " . $AnyEvent::MODEL . "\n";