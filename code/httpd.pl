#!/usr/bin/perl -w

use strict;

use AnyEvent;
use AnyEvent::HTTPD;

my $httpd = AnyEvent::HTTPD->new (port => 8080);

$httpd->reg_cb (
   '/' => sub {
      my ($httpd, $req) = @_;
      
      print "HTTPD: Got request for '/'\n";

      $req->respond( { content => ['text/plain', 'Hello World' ] } );
   },
   '/test' => sub {
      my ($httpd, $req) = @_;

      print "HTTPD: Got request for '/test'\n";

      $req->respond( { content => ['text/plain', 'Test page' ] } );
   },
);

print "Starting HTTPD\n";
$httpd->run; # making a AnyEvent condition variable would also work

