#!/usr/bin/perl -w

#Robert Moric April 2007
#robertmoric at gmail dot com
#
#IRSIM cmd generator for testing the topmips module.
#This script is tailored to the signal listing of the topmips module.
#
#NOTE: PRODUCES A 's 0' near th ebeginning before the signal values are set.
#Just delete it from the IRSIM cmd file. no big deal.
#


#print "Enter path of file to be read: ";
#chomp ($readpath = <STDIN>); # path of file to be read

#print "Enter path of file to be written: ";
#chomp ($writepath = <STDIN>); # path of file to be written
#$readpath = "robsout.vcd";#input file.
#$writepath = "test.cmd";

if ($ARGV[0]) {
if (-T $ARGV[0]) {
        $readpath = $ARGV[0];
        if($ARGV[1]) {
          if(-T $ARGV[1]) { 
            print "output file $ARGV[1] already exists, aborting";
            exit();
            }else {
              $writepath=$ARGV[1];
            }
        } else {
         $writepath="irsim.cmd";
        }
        
        print"VCD2IRSIM\nBy Robert Moric and Joel Stanley\n\n";
        print "Converting Verilog Change Dump $readpath to IRSIM cmd file $writepath\n";
}else {
        print "input file $ARGV[0] does not exist.\n";
        print "Usage:\tvcd2irsim vcdfile.vcd [irsimfile.cmd]\n";
        exit();
}
}else {
         print "Usage:\tvcd2irsim vcdfile.vcd [irsimfile.cmd]\n";
         exit();
 }
       
        
open(SOURCE, "<", $readpath) || die "couldnt open source file: $readpath ! \n";
open(SINK, ">", $writepath) || die "couldnt open destination file: $writepath ! \n";


#headers and vector definition.
#print SINK "| vcd_irsim.cmd\n\n";
print SINK "stepsize 1ns\n\n";

print SINK "vector interrupts ";
for($i=7;$i>=0;$i--) { print SINK "interrupts_",$i,"_ " }
print SINK "\n\n";

print SINK "vector memadr ";
for($i=28;$i>=2;$i--) { print SINK "memadr_",$i,"_ " }
print SINK "\n\n";

print SINK "vector memdata ";
for($i=31;$i>=0;$i--) { print SINK "memdata_",$i,"_ " }
print SINK "\n\n";

print SINK "vector membyteen ";
for($i=3;$i>=0;$i--) { print SINK "membyteen_",$i,"_ " }
print SINK "\n\n";

print SINK "ana ph1\n";
print SINK "ana ph2\n";
print SINK "ana memen\n";
print SINK "ana memrwb\n";
print SINK "ana memdata\n";
print SINK "ana membyteen\n";
print SINK "ana memadr\n";


#definition & initialisations.
#inputs
$ph1="x";
$ph2="x";
$reset="x";
@interrupts = (1) x 8;
$memdone="1";
#in-outs
@memdata = ("x") x 32;
#outputs
@memadr= ("x") x 27;
@membyteen=("x") x 4;
#memrwb & memen are useful in determining when to 
#assert memdata as an output. 
$memrwb="1";
$memen="x";


$memdata_is_output = 0; 
$ph1_at_posedge = 0;

$TIME1=0;
$DELTA = 0;
#$elapsed=0;
while(<SOURCE>){  #each loop examines a line in the SOURCE file
  chomp;#grab a line

  # list for line. white space delimited
  @tokens = split(//,$_);
  $value=$tokens[0];
  $size = @tokens;
  @sym_token = @tokens[1 .. $size-1];
  $str_sym_token=join('',@sym_token);

  #remove any white space characters that may have been added.
  $str_sym_token =~ s/\s//g;

  if($value eq "#"){
    #step for a time delta
    $DELTA = ($str_sym_token - $TIME1);
    #$elapsed = $elapsed +$DELTA;
    print SINK "\n\ns ",$DELTA,"\n\n";
    #print SINK "print current time: $elapsed\n\n";
    $TIME1 = $str_sym_token;
  }
  else{
    
    if($str_sym_token eq '!') {
      $ph1 = $value; 
      print SINK convert_to_LHU_Stimulus($ph1)," ph1\n";
      
      if($ph1 eq "1"){

	if($memdata_is_output eq "1"){
	  @temp = reverse @memdata;
	  $print_memdata = join('',@temp);
	  print SINK "assert memdata $print_memdata\n";
	}
	
	#do asserts for all outputs at posedge of ph1
	print SINK "assert memen $memen\n";
	print SINK "assert memrwb $memrwb\n";
	@temp = reverse @memadr[2..28];
	$print_memadr = join('',@temp);
	print SINK "assert memadr $print_memadr\n";
	@temp = reverse @membyteen;
	$print_membyteen = join('',@temp);
	print SINK "assert membyteen $print_membyteen\n\n";       
	$ph1_at_posedge = 0;
	
      }#end if posedge ph1
    }
    elsif($str_sym_token eq "\"") { $ph2 = $value; print SINK convert_to_LHU_Stimulus($value)," ph2\n"}
    elsif($str_sym_token eq "#") { $reset = $value; print SINK convert_to_LHU_Stimulus($value)," reset\n"}
    elsif($str_sym_token eq "\$") { $interrupts[7] = $value; print SINK convert_to_LHU_Stimulus($value)," interrupts_7_\n"}
    elsif($str_sym_token eq "\%") { $interrupts[6] = $value; print SINK convert_to_LHU_Stimulus($value)," interrupts_6_\n"}
    elsif($str_sym_token eq "\&") { $interrupts[5] = $value; print SINK convert_to_LHU_Stimulus($value)," interrupts_5_\n"}
    elsif($str_sym_token eq "\'") { $interrupts[4] = $value; print SINK convert_to_LHU_Stimulus($value)," interrupts_4_\n"}
    elsif($str_sym_token eq "(") { $interrupts[3] = $value; print SINK convert_to_LHU_Stimulus($value)," interrupts_3_\n"}
    elsif($str_sym_token eq ")") { $interrupts[2] = $value; print SINK convert_to_LHU_Stimulus($value)," interrupts_2_\n"}
    elsif($str_sym_token eq "*") { $interrupts[1] = $value; print SINK convert_to_LHU_Stimulus($value)," interrupts_1_\n"}
    elsif($str_sym_token eq "+") { $interrupts[0] = $value; print SINK convert_to_LHU_Stimulus($value)," interrupts_0_\n"}
    elsif($str_sym_token eq ",") { $memadr[31] = $value}
    elsif($str_sym_token eq "-") { $memadr[30] = $value}
    elsif($str_sym_token eq ".") { $memadr[29] = $value}
    elsif($str_sym_token eq "/") { $memadr[28] = $value}
    elsif($str_sym_token eq "0") { $memadr[27] = $value}
    elsif($str_sym_token eq "1") { $memadr[26] = $value}
    elsif($str_sym_token eq "2") { $memadr[25] = $value}
    elsif($str_sym_token eq "3") { $memadr[24] = $value}
    elsif($str_sym_token eq "4") { $memadr[23] = $value}
    elsif($str_sym_token eq "5") { $memadr[22] = $value}
    elsif($str_sym_token eq "6") { $memadr[21] = $value}
    elsif($str_sym_token eq "7") { $memadr[20] = $value}
    elsif($str_sym_token eq "8") { $memadr[19] = $value}
    elsif($str_sym_token eq "9") { $memadr[18] = $value}
    elsif($str_sym_token eq ":") { $memadr[17] = $value}
    elsif($str_sym_token eq ";") { $memadr[16] = $value}
    elsif($str_sym_token eq "<") { $memadr[15] = $value}
    elsif($str_sym_token eq "=") { $memadr[14] = $value}
    elsif($str_sym_token eq ">") { $memadr[13] = $value}
    elsif($str_sym_token eq "?") { $memadr[12] = $value}
    elsif($str_sym_token eq "@") { $memadr[11] = $value}
    elsif($str_sym_token eq "A") { $memadr[10] = $value}
    elsif($str_sym_token eq "B") { $memadr[9] = $value}
    elsif($str_sym_token eq "C") { $memadr[8] = $value}
    elsif($str_sym_token eq "D") { $memadr[7] = $value}
    elsif($str_sym_token eq "E") { $memadr[6] = $value}
    elsif($str_sym_token eq "F") { $memadr[5] = $value}
    elsif($str_sym_token eq "G") { $memadr[4] = $value}
    elsif($str_sym_token eq "H") { $memadr[3] = $value}
    elsif($str_sym_token eq "I") { $memadr[2] = $value}
    elsif($str_sym_token eq "J") { $memadr[1] = $value}
    elsif($str_sym_token eq "K") { $memadr[0] = $value}
    elsif($str_sym_token eq "L") { $memdata[31] = $value; if($memrwb eq "1") {print SINK convert_to_LHU_Stimulus($value)," memdata_31_\n"}}
    elsif($str_sym_token eq "M") { $memdata[30] = $value; if($memrwb eq "1") {print SINK convert_to_LHU_Stimulus($value)," memdata_30_\n"}}
    elsif($str_sym_token eq "N") { $memdata[29] = $value; if($memrwb eq "1") {print SINK convert_to_LHU_Stimulus($value)," memdata_29_\n"}}
    elsif($str_sym_token eq "O") { $memdata[28] = $value; if($memrwb eq "1") {print SINK convert_to_LHU_Stimulus($value)," memdata_28_\n"}}
    elsif($str_sym_token eq "P") { $memdata[27] = $value; if($memrwb eq "1") {print SINK convert_to_LHU_Stimulus($value)," memdata_27_\n"}}
    elsif($str_sym_token eq "Q") { $memdata[26] = $value; if($memrwb eq "1") {print SINK convert_to_LHU_Stimulus($value)," memdata_26_\n"}}
    elsif($str_sym_token eq "R") { $memdata[25] = $value; if($memrwb eq "1") {print SINK convert_to_LHU_Stimulus($value)," memdata_25_\n"}}
    elsif($str_sym_token eq "S") { $memdata[24] = $value; if($memrwb eq "1") {print SINK convert_to_LHU_Stimulus($value)," memdata_24_\n"}}
    elsif($str_sym_token eq "T") { $memdata[23] = $value; if($memrwb eq "1") {print SINK convert_to_LHU_Stimulus($value)," memdata_23_\n"}}
    elsif($str_sym_token eq "U") { $memdata[22] = $value; if($memrwb eq "1") {print SINK convert_to_LHU_Stimulus($value)," memdata_22_\n"}}
    elsif($str_sym_token eq "V") { $memdata[21] = $value; if($memrwb eq "1") {print SINK convert_to_LHU_Stimulus($value)," memdata_21_\n"}}
    elsif($str_sym_token eq "W") { $memdata[20] = $value; if($memrwb eq "1") {print SINK convert_to_LHU_Stimulus($value)," memdata_20_\n"}}
    elsif($str_sym_token eq "X") { $memdata[19] = $value; if($memrwb eq "1") {print SINK convert_to_LHU_Stimulus($value)," memdata_19_\n"}}
    elsif($str_sym_token eq "Y") { $memdata[18] = $value; if($memrwb eq "1") {print SINK convert_to_LHU_Stimulus($value)," memdata_18_\n"}}
    elsif($str_sym_token eq "Z") { $memdata[17] = $value; if($memrwb eq "1") {print SINK convert_to_LHU_Stimulus($value)," memdata_17_\n"}}
    elsif($str_sym_token eq "\[") { $memdata[16] = $value; if($memrwb eq "1") {print SINK convert_to_LHU_Stimulus($value)," memdata_16_\n"}}
    elsif($str_sym_token eq "\\") { $memdata[15] = $value; if($memrwb eq "1") {print SINK convert_to_LHU_Stimulus($value)," memdata_15_\n"}}
    elsif($str_sym_token eq "\]") { $memdata[14] = $value; if($memrwb eq "1") {print SINK convert_to_LHU_Stimulus($value)," memdata_14_\n"}}
    elsif($str_sym_token eq "\^") { $memdata[13] = $value; if($memrwb eq "1") {print SINK convert_to_LHU_Stimulus($value)," memdata_13_\n"}}
    elsif($str_sym_token eq "\_") { $memdata[12] = $value; if($memrwb eq "1") {print SINK convert_to_LHU_Stimulus($value)," memdata_12_\n"}}
    elsif($str_sym_token eq "\`") { $memdata[11] = $value; if($memrwb eq "1") {print SINK convert_to_LHU_Stimulus($value)," memdata_11_\n"}}
    elsif($str_sym_token eq "a") { $memdata[10] = $value; if($memrwb eq "1") {print SINK convert_to_LHU_Stimulus($value)," memdata_10_\n"}}
    elsif($str_sym_token eq "b") { $memdata[9] = $value; if($memrwb eq "1") {print SINK convert_to_LHU_Stimulus($value)," memdata_9_\n"}}
    elsif($str_sym_token eq "c") { $memdata[8] = $value; if($memrwb eq "1") {print SINK convert_to_LHU_Stimulus($value)," memdata_8_\n"}}
    elsif($str_sym_token eq "d") { $memdata[7] = $value; if($memrwb eq "1") {print SINK convert_to_LHU_Stimulus($value)," memdata_7_\n"}}
    elsif($str_sym_token eq "e") { $memdata[6] = $value; if($memrwb eq "1") {print SINK convert_to_LHU_Stimulus($value)," memdata_6_\n"}}
    elsif($str_sym_token eq "f") { $memdata[5] = $value; if($memrwb eq "1") {print SINK convert_to_LHU_Stimulus($value)," memdata_5_\n"}}
    elsif($str_sym_token eq "g") { $memdata[4] = $value; if($memrwb eq "1") {print SINK convert_to_LHU_Stimulus($value)," memdata_4_\n"}}
    elsif($str_sym_token eq "h") { $memdata[3] = $value; if($memrwb eq "1") {print SINK convert_to_LHU_Stimulus($value)," memdata_3_\n"}}
    elsif($str_sym_token eq "i") { $memdata[2] = $value; if($memrwb eq "1") {print SINK convert_to_LHU_Stimulus($value)," memdata_2_\n"}}
    elsif($str_sym_token eq "j") { $memdata[1] = $value; if($memrwb eq "1") {print SINK convert_to_LHU_Stimulus($value)," memdata_1_\n"}}
    elsif($str_sym_token eq "k") { $memdata[0] = $value; if($memrwb eq "1") {print SINK convert_to_LHU_Stimulus($value)," memdata_0_\n"}}
    elsif($str_sym_token eq "l") { $membyteen[3] = $value}
    elsif($str_sym_token eq "m") { $membyteen[2] = $value}
    elsif($str_sym_token eq "n") { $membyteen[1] = $value}
    elsif($str_sym_token eq "o") { $membyteen[0] = $value}
    elsif($str_sym_token eq "p") 
      { 
	#MEMRWB: determines memdata as an output when MEMRWB = 0. It is an input otherwise.
	#memdata_is_output is used in ph1 to determine if memdata needs to be asserted.
	#memdata_is_output = 1 => yes it is an output. = 0 => an input
	$memrwb = $value; 
	if($value eq "0"){
	  $memdata_is_output="1";
	  #need to release memdata from being driven by IRSIM so the outputs can form on the lines....
    for($i=31;$i>=0;$i--) { print SINK "x memdata_",$i,"_\n" }
	}else{
	  $memdata_is_output="0";
	}
      }
    elsif($str_sym_token eq "q") { $memen = $value}
    elsif($str_sym_token eq "r") { $memdone = $value; print SINK convert_to_LHU_Stimulus($value)," memdone\n"}
    else{}#the default.... any tokens/signals not needed are ignored here.
  }#end else from if( #)...
  
  
}#end while(source)


#comment this out using a while loop that never enters :)
while(0){
print "interrupts: @interrupts\n\n";


$interout = join('',@interrupts);
$memdout = join('',@memdata);
$memadout = join('',@memadr);
$membyout = join('',@membyteen);

print "ph1: $ph1\n";
print "ph2: $ph2\n";
print "interrupts: $interout\n";
print "reset: $reset\n";
print "memdone: $memdone\n";
print "memdata: $memdout\t length:",length($memdout),"\n";
print "memadr: $memadout\t length:",length($memadout),"\n";
print "membyteen: $membyout\n";
print "memrwb: $memrwb\n";
print "memen: $memen\n";
}

#convert 0,1,x to irsim node inpts of l,h, & u.
sub convert_to_LHU_Stimulus{
  my $stim=shift;
  if($stim=~ /0/){return "l"}
  elsif($stim=~ /1/){return "h"}
  else{return "u"}
}
