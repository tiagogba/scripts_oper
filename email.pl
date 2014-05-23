use strict;
use MIME::Lite;

my $smtp_server = "smtp.gmail.com";
my $smtp_port   = 465;
my $debug       = 1;
my $user        = "usuario";
my $passwd      = "senha";

MIME::Lite->send('smtp', $smtp_server ,
                          Port =>$smtp_port ,
                          Timeout=>60 ,
                          Debug => $debug ,
                          Hello => 'domain.com',
                          User  => $user,
                          Password  => $passwd);

my $msg = MIME::Lite->new(
        From    =>'email from',
        To      =>'email to',
        Subject =>'This is a test',
        Data    =>"this is the body"
        );

$msg->send();
