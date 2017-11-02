#!/usr/bin/perl

use strict;
use POSIX;

print "Checking whether data is loaded";

# the usersPerAuctionScaleFactor
my $auctions = ceil($ENV{'USERS'} / $ENV{'USERSPERAUCTIONSCALEFACTOR'}); 

my $dbPrepOptions = " -a $auctions -c ";
$dbPrepOptions .= " -m $ENV{'NUMNOSQLSHARDS'} ";
$dbPrepOptions .= " -p $ENV{'NUMNOSQLREPLICAS'} ";
$dbPrepOptions .= " -f $ENV{'MAXDURATION'} ";
$dbPrepOptions .= " -u $ENV{'USERS'} ";

my $springProfilesActive = $ENV{'SPRINGPROFILESACTIVE'};
$springProfilesActive .= ",dbprep";

my $dbLoaderClasspath = "/dbLoader.jar:/dbLoaderLibs/*:/dbLoaderLibs";

`java -client -cp $dbLoaderClasspath -Dspring.profiles.active=\"$springProfilesActive\" -DDBHOSTNAME=$ENV{'DBHOSTNAME'} -DDBPORT=$ENV{'DBPORT'} -DMONGODB_HOST=$ENV{'MONGODBHOSTNAME'} -DMONGODB_PORT=$ENV{'MONGODBPORT'} -DMONGODB_REPLICA_SET=$ENV{'MONGODBREPLICASET'} com.vmware.weathervane.auction.dbloader.DBPrep $dbPrepOptions 2>&1`;

if ($?) {
	return 0;
}
else {
	return 1;
}