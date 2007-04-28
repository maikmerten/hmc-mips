#!/usr/intel/bin/perl -w
open(TEST,"topmipsresult.txt")|| die "can't find topmipsresult.txt.\n";
open(OUT,">IRSIM.cmd");
@input=<TEST>;
print OUT "| topmipstest.cmd\n\n";

ana ph1
ana ph2
ana reset
ana interrupts
ana memdone
ana memdata
ana memadr
ana membyteen
ana memen
ana memrwb

print OUT "vector interrupts interrupts[7] interrupts[6] interrupts[5] interrupts[4] interrupts[3] interrupts[2] interrupts[1] interrupts[0]\n\n";

print OUT "vector memadr memadr[28] memadr[27] memadr[26] memadr[25] memadr[24] memadr[23] memadr[22] memadr[21] memadr[20] memadr[19] memadr[18] memadr[17] memadr[16] memadr[15] memadr[14] memadr[13] memadr[12] memadr[11] memadr[10] memadr[9] memadr[8] memadr[7] memadr[6] memadr[5] memadr[4] memdata[3] memdata[2]\n\n";

print OUT "vector memdata memdata[31] memdata[30] memdata[29] memdata[28] memdata[27] memdata[26] memdata[25] memdata[24] memdata[23] memdata[22] memdata[21] memdata[20] memdata[19] memdata[18] memdata[17] memdata[16] memdata[15] memdata[14] memdata[13] memdata[12] memdata[11] memdata[10] memdata[9] memdata[8] memdata[7] memdata[6] memdata[5] memdata[4] memdata[3] memdata[2] memdata[1] memdata[0]\n\n";

print OUT "vector membyteen membyteen[3] membyteen[2] membyteen[1] membyteen[0]\n\n";

$temp1=5;
$temp2=14;
for($k=5;$k<=$#input;$k++){
    if($k==$temp1){$action="drive";}
    if($k==$temp2){$action="assert";}
    @split=split(/\s+/,$input[$k]);
    for($i=3;$i<14;$i++){
	if($i==3 or $i==4 or $i==5 or $i==7 or $i==13 or $i==11 or $i==12 ){
	    if($split[$i]=~/.*0.*/i){
		$sig="l"; 
	    }
	    if($split[$i]=~/.*1.*/i){
		$sig="h";
	    }
	    if($split[$i]=~/.*x.*/i){
		$sig="u";
	    }
	}

	if($i==6 or $i==8 or $i==9 or $i==10 ){
	    $sig=$split[$i];
	    for($j=0;$j<32;$j++){$sig=~s/x/u/;}
	}

	if($i==3 and $action eq "drive"){
	    print OUT "$sig ph1\n";
	}
	if($i==4 and $action eq "drive"){
	    print OUT "$sig ph2\n";
	}
	if($i==5 and $action eq "drive"){
	    print OUT "$sig reset\n";
	}
	if($i==6 and $action eq "drive"){
	    print OUT "set interrupts $sig\n";
	}
	if($i==7 and $action eq "drive" or $action eq "assert"){
	    if($sig eq "h"){$sig2="1"; $data="in";}
	    if($sig eq "l"){$sig2="0"; $data="out";}
	    if($sig eq "u"){$sig2="u"; $data="out";}
	}
	if($i==8 and $action eq "assert"){
	    @memadr=split(//, $sig);
	    $memadr="";
		for($count=2;$count<29;$count++){
		    $memadr=$memadr.$memadr[$count];
               }
	    print OUT "assert memadr $memadr\n";
	}

	if($i==9){
	    if($data eq "in" and $action eq "drive"){
		print OUT "set memdata $sig\n";
	    }
	    if($data eq "out" and $action eq "assert"){
		print OUT "assert memdata $sig\n";
	    }
	}

	if($i==10 and $action eq "assert"){
	    print OUT "assert membyteen $sig\n";
	}

	if($i==11 and $action eq "assert"){

	if($sig eq "h"){$sig2="1";}
	if($sig eq "l"){$sig2="0";}
	if($sig eq "u"){$sig2="u";}
	    print OUT "assert memrwb $sig2\n";
	}

	if($i==12 and $action eq "assert"){
	if($sig eq "h"){$sig2="1";}
	if($sig eq "l"){$sig2="0";}
	if($sig eq "u"){$sig2="u";}
	    print OUT "assert memen $sig2\n";
	    print OUT "s 1\n\n";
	    $temp1=$k+1;
	    $action="none";
	}
	
	if($i==13 and $action eq "drive"){
	    print OUT "$sig memdone\n";
	    print OUT "s 9\n\n";
	    $temp2=$k+9;
	    $action="none";
	}
	    
    }
	while($#split>-1){pop @split;}
}

