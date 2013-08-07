#!/usr/bin/perl

#[ Modules: ]###################################

use warnings       ;
use strict         ;
use LWP::UserAgent ;
use Getopt::Std    ;
use Sys::Hostname  ;

#[ Variables: ]#################################

my %hash = ()            ;
my $content              ;
my $service              ;
my $item                 ;
my $monitor              ;
my $value                ;
my $hostname  = hostname ;
my $timestamp = time()   ;
my $status               ;
my $response             ;
my $match                ;

#[ Verifing Parameters: ]#######################

getopts(":i:m:v:s:u:a:", \%hash);

#[ Command line Parameters: ]###################

$item    = $hash{i};
$monitor = $hash{m};
$value    = $hash{v};
$service = $hash{s};
$status  = $hash{u};
$match   = $hash{a};

if (keys(%hash) == 6 )
   {
    &createContent($item,$monitor,$value,$service,$status,$match);
   }
    else
        {
         &usage();
        }

sub createContent(){
       $content .= "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
       $content .= "<carrierList xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:noNamespaceSchemaLocation=\"quebec_carrier.xsd\">\n";
       $content .= "\t<carrier>\n";
       $content .= "\t\t<hostname>$hostname</hostname>\n";
       $content .= "\t\t<service>$service</service>\n";
       $content .= "\t\t<item>$item</item>\n";
       $content .= "\t\t<monitor>$monitor</monitor>\n";
       $content .= "\t\t<value>$value</value>\n";
       $content .= "\t\t<timestamp>$timestamp</timestamp>\n";
       $content .= "\t\t<match>$match</match>\n";
       $content .= "\t\t<status>$status</status>\n";
       $content .= "\t</carrier>\n";
       $content .= "\t</carrierList>"                                                                   ;
       &sendContent($content);
}

sub sendContent(){
       my $method    = "POST"                                              ;
       # Glete
       my $uri       = "http://quebec.api.srv.intranet/quebec-api/carrier" ;
       # Barao
       #my $uri      = "http://quebec.sys.srv.intranet/quebec-api/carrier" ;
       my $header    = HTTP::Request->new(Accept => 'application/xml')     ;
       my $request   = HTTP::Request->new($method,$uri,$header,$content)   ;
       my $useragent = LWP::UserAgent->new                                 ;
       $useragent->timeout(10);
       $useragent->request($request);
}

#[ Sub Usage: ]#################################

sub usage(){
      print "Usage: $0 -i <item> -m <monitor> -v <value> -s <service> -u <status> -a <match> \n" ;
      exit -1;
}

