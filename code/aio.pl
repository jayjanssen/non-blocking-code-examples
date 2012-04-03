#!/usr/bin/perl -w

use strict;

use AnyEvent;
use AnyEvent::AIO;
use IO::AIO;

$| = 1;

my $cv = AnyEvent->condvar;


sub async_read {
    my( $fh, $buffer, $offset ) = @_;
    
    $offset = 0 unless defined $offset;
    $buffer = '' unless defined $buffer;
    
    my $block_size = 2**16;

    aio_read $fh, $offset, $block_size, $buffer, 0, sub {
        my $bytes_read = shift;

        $bytes_read >= 0 or die "read error: $!";

        $offset += $block_size;
        print "read " . length( $buffer ) . " bytes\n";

        if($bytes_read != $block_size ) {
            print "no more bytes to read\n";
            
            $cv->send;
        } else {
            &async_read( $fh, $buffer, $offset );
        }
    };    
}


aio_open "data.bin", IO::AIO::O_RDONLY, 0, sub {
  my $fh = shift
    or die "Could not open data.bin: $!\n";

  print "File opened\n";
  
  &async_read( $fh );
};

print "Opening file\n";

my $t = AnyEvent->idle( cb => sub { print "." });


my $file_data = $cv->wait;

print "Done\n";