#!/usr/bin/perl -w
open(OUT,">test.out");

print OUT "vector interrupts ";
for($i=7;$i>=0;$i--) { print OUT "interrupts[$i] "; }
print OUT "\n\n";

print OUT "vector writedata ";
for($i=31;$i>=0;$i--) { print OUT "writedata[$i] "; }
print OUT "\n\n";

print OUT "vector dataadr "
for($i=31;$i>=0;$i--) { print OUT "dataadr[$i] "; }
print OUT "\n\n";
            
print OUT "vector memadr "
for($i=31;$i>=0;$i--) { print OUT "memadr[$i] "; }
print OUT "\n\n";
 
print OUT "vector memdata "
for($i=31;$i>=0;$i--) { print OUT "memdata[$i] "; }
print OUT "\n\n";

print OUT "vector membyteen "
for($i=3;$i>=0;$i--) { print OUT "membyteen[$i] "; }
print OUT "\n\n";

