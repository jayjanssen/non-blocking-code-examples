#!/usr/bin/perl -w

use strict;

use AnyEvent;
use AnyEvent::DBI;

my $cv = AnyEvent->condvar;

my $dbh = new AnyEvent::DBI "DBI:mysql:dbname=test", 'root', '';

$dbh->exec ("select * from test where id=?", 10, sub {
    my ($dbh, $rows, $rv) = @_;

    $#_ or die "failure: $@";
    
    my $arr = $rows->[0];
    print "(";
    print join( ', ', @$arr );
    print ")\n";

    $cv->send;
});

$cv->wait;
