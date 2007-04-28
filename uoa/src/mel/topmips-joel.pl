#!/usr/bin/perl -w

use Switch;

open(TEST,"topmipsresult.txt")|| die "can't find topmipsresult.txt.\n";
open(OUT,">IRSIM.cmd");
@input=<TEST>;
print OUT "| topmipstest.cmd\n\n";
print OUT "stepsize 1\n\n";

print OUT "vector interrupts ";
for($i=7;$i>=0;$i--) { print OUT "interrupts[$i] "; }
print OUT "\n\n";

print OUT "vector writedata ";
for($i=31;$i>=0;$i--) { print OUT "writedata[$i] "; }
print OUT "\n\n";

print OUT "vector dataadr ";
for($i=31;$i>=0;$i--) { print OUT "dataadr[$i] "; }
print OUT "\n\n";

print OUT "vector memadr ";
for($i=31;$i>=0;$i--) { print OUT "memadr[$i] "; }
print OUT "\n\n";

print OUT "vector memdata ";
for($i=31;$i>=0;$i--) { print OUT "memdata[$i] "; }
print OUT "\n\n";

print OUT "vector membyteen ";
for($i=3;$i>=0;$i--) { print OUT "membyteen[$i] "; }
print OUT "\n\n";

for($k=5;$k<=$#input;$k++){
        @split=split(/\s+/,$input[$k]);
        
        for($i=3;$i<16;$i++){
                if($i==3 or $i==4 or $i==5 or $i==9 or $i==15 or $i==13 or $i==14 ){
                        if($split[$i]=~/.*0.*/i){	$sig="l"; }
                        else if($split[$i]=~/.*1.*/i){	$sig="h"; }
                        else if($split[$i]=~/.*x.*/i){	$sig="u"; }
                }
                if($i==6 or $i==7 or $i==8 or $i==10 or $i==11 or $i==12 ){
                        $sig=$split[$i];
                        for($j=0;$j<32;$j++){$sig=~s/x/u/;}
                }
                
                switch ($i) {

                        case 3  { print OUT "$sig ph1\n" }
                        case 4  { print OUT "$sig ph2\n" }
                        case 5  { print OUT "$sig reset\n" }
                        case 6  { print OUT "set interrupts $sig\n"	}
                        case 7  { print OUT "assert writedata $sig\n"	}
                        case 8  { print OUT "assert dataadr $sig\n" }
                        case 9  { switch ($sig) {
                                        case "h" {$sig2="1";$data="in"}
                                        case "l" {$sig2="0";$data="out"}
                                        case "u" {$sig2="u";$data="out"}
                                  }
                                  print OUT "assert memwrite $sig2\n";
                                }
                        case 10 { print OUT "assert memadr $sig\n";	}
                        case 11 { if($data eq "in"){ print OUT "set memdata $sig\n"; }
                                  else if($data eq "out"){ print OUT "assert memdata $sig\n"; }
                                }     
                        case 12 { print OUT "assert membyteen $sig\n"; }
                        case 13 {	if($sig eq "h"){$sig2="1";}
                                  if($sig eq "l"){$sig2="0";}
                                  if($sig eq "u"){$sig2="u";}
                                  print OUT "assert memrwb $sig2\n";
                                }
                        case 14 { if($sig eq "h"){$sig2="1";}
                                  if($sig eq "l"){$sig2="0";}
                                  if($sig eq "u"){$sig2="u";}
                                  print OUT "assert memen $sig2\n";
                                }
                       case 15  { print OUT "$sig memdone\n";
                                  print OUT "s 1\n\n";
                                }
                        }
              while($#split>-1){pop @split;}
}

