perl-brs-rewrite
Written by Joey Kelly

This script is meant to emulate the wonderful Bible Retreival System software,
written by Chip Chapin, but has sadly been abandoned. I can't get the original
software to compile, though Debian and the BSDs have gotten it updated.

Aside from the issue above, I have a found a few glitches in BRS, for example:

Searching for "??dogs", then "?and without" yields no hits, but Rev 22.15
reads "For without are dogs, and sorcerers, and whoremongers, and murderers,
and idolaters, and whosoever loveth and maketh a lie."

NOTE: I have made a few typo corrects in KJV.txt here and there
(changing "rereward" to "rearward", for example), and will correct anything
else I find that seems to be misspelled, etc.

Usage:
*        search (up to 4 terms): ./bible.pl the Lord Jesus Christ
*        read chapter:           ./bible.pl ?ch Pro 31
*        read verse:             ./bible.pl ?vs Joh 3:16
*        read verse range:       ./bible.pl ?vs Pro 3:4-5
*        show book list:         ./bible.pl ?books
