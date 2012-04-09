#!/usr/bin/perl -w

use strict;

use Coro;

use AnyEvent;
use AnyEvent::DBI;

my $cv = AnyEvent->condvar;

my $dbh = new AnyEvent::DBI "DBI:mysql:dbname=test", 'root', '';

# non-blocking call to the DB, defer handling response until later.
$dbh->exec( "select * from test where id=?", 10, Coro::rouse_cb );

# do something else here

# now block this execution path until the query results come back.
my ($dbh2, $rows, $rv) = Coro::rouse_wait;

$#_ or die "failure: $@";

my $arr = $rows->[0];
print "(";
print join( ', ', @$arr );
print ")\n";