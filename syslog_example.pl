#!"C:\Strawberry\perl\bin\perl.exe" 
use Sys::Syslog;
# Misses setlogsock.
use Sys::Syslog qw(:DEFAULT setlogsock);
# Also gets setlogsock.

#============================================
#!"C:\Strawberry\perl\bin\perl.exe" 

use strict;
use Sys::Syslog;


openlog(maillog, 'cons,pid', 'user');
syslog('info', 'this is another test');
syslog('mail|warning', '=========this is a better test: %d', time());
closelog();


my $date = `date '+%d%m%Y:%H%M%S'`;


my $mesg = "======== Start =======\n";
$mesg .= "TIME :\t $date\n";

$mesg .=  "\n";
$mesg .= "========The end==========\n";
print $mesg;

openlog( 'maillog', 'const,pid,ndelay', 'user' );
syslog('mail|warning', '%s', $mesg);

closelog();

#=========================================
#A syslog message is typically only one line (single CR) long. If a message needs to span multiple lines to avoid having a 500+ character line width, it's broken into separate messages.
#The easy way to do this with what you have is:

#!/usr/bin/perl -w

#use strict;
#use Sys::Syslog;

 my $date = `date '+%d-%m-%Y//%H:%M:%S'`;
 my $morestuff ='This is is test ~~';
 my @msgs = ( "======== Start =========",
              $date,
              $morestuff,
              "======== End ==========" );

openlog( 'maillog', 'const,pid,ndelay', 'user' );
map { syslog( 'mail|warning', '%s', $_ ) } @msgs;

 closelog()