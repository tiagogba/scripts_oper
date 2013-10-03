use strict;
use MIME::Lite;

my $smtp_server = "smtp.gmail.com";
my $smtp_port   = 465;
my $debug       = 1;
my $user        = "tiagog85";
my $passwd      = "qqQQ123!@#";

MIME::Lite->send('smtp', $smtp_server ,
                          Port =>$smtp_port ,
                          Timeout=>60 ,
                          Debug => $debug ,
                          Hello => 'domain.com',
                          User  => $user,
                          Password  => $passwd);

my $msg = MIME::Lite->new(
        From    =>'talbuquerque@uoldiveo.com',
        To      =>'tiagog85@gmail.com',
        Subject =>'This is a test',
        Data    =>"this is the body"
        );

$msg->send();
