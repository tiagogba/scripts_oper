#!/usr/bin/perl

use strict;
use warnings;
use Net::SFTP::Foreign;

my $sftp = Net::SFTP::Foreign->new(
    'uolcs@10.129.88.71',
    password => 'u@lc$13',
    more     => ['-v']
);

$sftp->get('/inbox/*', '/tmp/')
  or die "unable to retrieve copy: ".$sftp->error;

