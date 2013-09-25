#!/usr/bin/perl

use DBI;
#use strict;
use warnings;
use Sys::Hostname;
use diagnostics;

#Montando o send-xml.pl

my $server      = 'bd1-oricola.srv.intranet';
my $dsn         = 'DBI:Sybase:server=bpag1-bd.srv.intranet';
my $var         = 0;
my $item        = 'blo';
my $monitor     = 'teste1';
my $service     = 'teste2';
my $match       = 'true';
my $status      = 0;
my $srvhost     = hostname;

# Abertura da conexao com o banco de dados
my $dbh = DBI->connect( $dsn, "relatorio", 'zxnm890');

if ($dbh){
   $value= "OK\n";
   $status = "0";
         } else {
                $value="$srvhost nao conseguiu se conectar com o banco $server\n";
                $status = "2";
         }

# desconecta do banco
$dbh->disconnect;

system ("/export/scripts/send-xml.pl -h $srvhost -i $item -m $monitor -v $var -s $service -u $status -t $match");

~                                                                                                                                                                                                                                   
~                                                                                                                             
