#!/usr/bin/perl
use strict;
use warnings;
use File::Copy;
use Net::Ping;
use Time::HiRes qw(sleep);

my %servers = (
    'ip' => 'name',
    'ip' => 'name',
    'ip' => 'name',
    'ip' => 'name',
    'ip' => 'name',
    'ip' => 'name',
);

my $image = 'on.png';
my $image2 = 'off.png';

my $ping_interval = 60;

while (1) {
    foreach my $ip (keys %servers) {
        my $machine_name = $servers{$ip};

        my $ping_result = `ping -c 1 -w 1 $ip`;  # Sending 1 packet with a 1-second timeout

        if ($ping_result =~ /1 packets transmitted, 1 received/) {
            print "Ping to $ip ($machine_name) successful\n";

            my $destination = "$machine_name.png";

            if (copy($image, $destination)) {
                print "Image copied to $destination\n";
            } else {
                print "Failed to copy image to $destination: $!\n";
            }
        } else {
            my $destination = "$machine_name.png";
	    copy($image2, $destination);
            print "Ping to $ip ($machine_name) failed\n";
        }
    }

    sleep($ping_interval);
}

