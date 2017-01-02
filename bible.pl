#!/usr/bin/perl

# bible.pl

# Version 0.9.1
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

# change this to your home directory
my $biblepath = '/home/oompaloompa/bin';
my $bible = "$biblepath/KJV.txt";


my $term1   = shift;
my $term2   = shift;
my $term3   = shift;
my $term4   = shift;
my $term5   = shift;

$term1      = '?usage'  unless $term1;   # give some hint, don't let them quess
$term2      = ''        unless $term2;
$term3      = ''        unless $term3;
$term4      = ''        unless $term4;
$term5      = ''        unless $term5;


# sanitize all input
$term1 = safechars($term1);
$term2 = safechars($term2);
$term3 = safechars($term3);
$term4 = safechars($term4);
$term5 = safechars($term5);


if ($term1 eq '?usage') {
  print "usage:\n";
  print "\tsearch (up to 4 terms):\t./bible.pl the Lord Jesus Christ\n";
  print "\treach chapter:\t\t./bible.pl ?ch Pro 31\n";
  print "\tread verse:\t\t./bible.pl ?vs Joh 3:16\n";
  print "\tread verse range:\t./bible.pl ?vs Pro 3:4-5\n";
} elsif ( ($term1 eq '?verse' || $term1 eq '?vs') && $term2 =~ /^\w{3}$/i && $term3 =~ /^(\d{1,3})(:\d{1,3})?(-\d{1,3})?$/ ) {
  my ($book, $chapter, $start, $end) = ($term2, $1, $2, $3);
  $start =~ s/://;
  $end =~ s/-// if $end;
  if ($end) {
    if ($end > $start) {
      for my $verse ($start .. $end) {
        my $search = "grep -i \"^$book $chapter:$verse \" $bible";
        my $result = `$search`;
        print "$result";
      }
    }
  } else {
    my $search = "grep -i \"^$book $chapter:$start \" $bible";
    my $result = `$search`;
    print "$result";
  }
} elsif ( ($term1 eq '?chapter' || $term1 eq '?ch')  && $term2 =~ /^\w{3}$/i  && $term3 =~ /^\d{1,3}$/ ) {
  my $chapterstring = "$term2 $term3:";
  my $search = "grep -i \"^$chapterstring\" $bible";
  #print "$search\n";
  my @chapter  = `$search`;
  foreach (@chapter) {
    print "$_";
  }
} else {
  my $search  = "grep -i $term1 $bible";
  $search     .= " | grep -i $term2" if $term2;
  $search     .= " | grep -i $term3" if $term3;
  $search     .= " | grep -i $term4" if $term4;
  $search     .= " | grep -i $term5" if $term5;
  my @hits    = `$search`;
  my @chapter  = `$search`;
  foreach (@hits) {
    print "$_";
  }
  my $hits    = @hits;
  my $report = "showing $hits match";
  $report .= 'es' unless $hits == 1;
  print "$report\n";
}



sub safechars {
  my $string = shift;
  $string =~ tr/a-zA-Z0-9:?-//dc;
  return $string;
}
