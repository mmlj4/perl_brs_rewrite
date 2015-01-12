#!/usr/bin/perl
# bible.pl
# Version 0.02
# Joey Kelly
# 2/25/2011

# This script is meant to emulate the wonderful Bible Retreival System software,
# written by Chip Chapin, but has sadly been abandoned. I can't get the original
# software to compile, though Debian and the BSDs have gotten it updated.

# Aside from the issue above, I have a found a few glitches in BRS, for example:
#
# Searching for "??dogs", then "?and without" yields no hits, but Rev 22.15
# reads "For without are dogs, and sorcerers, and whoremongers, and murderers,
# and idolaters, and whosoever loveth and maketh a lie."

use strict;
use warnings;

my $biblepath = '/home/jkelly/bin';
my $bible = "$biblepath/KJV.txt";


# this obviously can't stand...
my $term1   = shift;
my $term2   = shift;
my $term3   = shift;
my $term4   = shift;
$term1      = '' unless $term1;
$term2      = '' unless $term2;
$term3      = '' unless $term3;
$term4      = '' unless $term4;
chomp $term1;
chomp $term2;
chomp $term3;
chomp $term3;
chomp $term4;
my $search  = "grep -i $term1 $bible";
$search     .= " | grep -i $term2" if $term2;
$search     .= " | grep -i $term3" if $term3;
$search     .= " | grep -i $term4" if $term4;
my @hits    = `$search`;
print "@hits";
my $hits    = @hits;
print "showing $hits matches\n";
