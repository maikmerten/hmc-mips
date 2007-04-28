#Robert Moric April 2007
#robertmoric at gmail dot com
#
#IRSIM cmd generator for testing the topmips module.
#This script is tailored to the signal listing of the topmips module.

use Switch;
#print "Enter path of file to be read: ";
#chomp ($readpath = <STDIN>); # path of file to be read

#print "Enter path of file to be written: ";
#chomp ($writepath = <STDIN>); # path of file to be written
$readpath = "samplevcd.txt";#"robsout.vcd";
$writepath = "irsim_vcd.cmd";
open(SOURCE, "<", $readpath) || die "couldnt open source file: $readpath ! \n";
open(SINK, ">", $writepath) || die "couldnt open destination file: $writepath ! \n";


#headers and vector definition.
print SINK "| vcd_irsim.cmd\n\n";
print SINK "stepsize 1ps\n\n";

print SINK "vector interrupts interrupts[7] interrupts[6] interrupts[5] interrupts[4] interrupts[3] interrupts[2] interrupts[1] interrupts[0]\n\n";

print SINK "vector memadr memadr[31] memadr[30] memadr[29] memadr[28] memadr[27] memadr[26] memadr[25] memadr[24] memadr[23] memadr[22] memadr[21] memadr[20] memadr[19] memadr[18] memadr[17] memadr[16] memadr[15] memadr[14] memadr[13] memadr[12] memadr[11] memadr[10] memadr[9] memadr[8] memadr[7] memadr[6] memadr[5] memadr[4] memadr[3] memadr[2] memadr[1] memadr[0]\n\n";

print SINK "vector memdata memdata[31] memdata[30] memdata[29] memdata[28] memdata[27] memdata[26] memdata[25] memdata[24] memdata[23] memdata[22] memdata[21] memdata[20] memdata[19] memdata[18] memdata[17] memdata[16] memdata[15] memdata[14] memdata[13] memdata[12] memdata[11] memdata[10] memdata[9] memdata[8] memdata[7] memdata[6] memdata[5] memdata[4] memdata[3] memdata[2] memdata[1] memdata[0]\n\n";

print SINK "vector membyteen membyteen[3] membyteen[2] membyteen[1] membyteen[0]\n\n";


#definition
#inputs
$ph1;
$ph2;
$reset;
@interrupts;
$memdone;
#in-outs
@memdata;
#outputs
@memadr;
@membyteen;
#memrwb & memen are useful in determining when to 
#assert memdata as an output. 
$memrwb;
$memen;


$memdata_is_output = 0; 
$ph1_at_posedge = 0;

$TIME1=0;
$DELTA = 0;

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
    $DELTA = $str_sym_token - $TIME1;
    
    print SINK "\n\ns ",$DELTA,"\n\n";
    $TIME1 = $str_sym_token;

    if($memdata_is_output && $ph1_at_posedge){
      @temp = reverse @memdata;
      print SINK "assert memdata @temp\n";
    }

    if($ph1_at_posedge eq "1"){    
      print SINK "assert memen $memen\n";
      print SINK "assert memrwb $memrwb\n";
      @temp = reverse @memadr;
      print SINK "assert memadr @temp\n";
      @temp = reverse @membyteen;
      print SINK "assert membyteen @temp\n\n";       
    }
    
    $memdata_is_output = 0; 
    $ph1_at_posedge = 0;

  }
  else{
    
    if($str_sym_token eq '!') {
      $ph1 = $value; 
      print SINK convert_to_LHU_Stimulus($ph1)," ph1\n";
      if($ph1 eq "1"){
	$ph1_at_posedge =1; 
      }
    }
    elsif($str_sym_token eq '"') { $ph2 = $value; print SINK convert_to_LHU_Stimulus($value)," ph2\n"}
    elsif($str_sym_token eq '#') { $reset = $value; print SINK convert_to_LHU_Stimulus($value)," reset\n"}
    elsif($str_sym_token eq '$') { $interrupts[7] = $value; print SINK convert_to_LHU_Stimulus($value)," interrupts[7]\n"}
    elsif($str_sym_token eq '%') { $interrupts[6] = $value; print SINK convert_to_LHU_Stimulus($value)," interrupts[6]\n"}
    elsif($str_sym_token eq '&') { $interrupts[5] = $value; print SINK convert_to_LHU_Stimulus($value)," interrupts[5]\n"}
    elsif($str_sym_token eq "'") { $interrupts[4] = $value; print SINK convert_to_LHU_Stimulus($value)," interrupts[4]\n"}
    elsif($str_sym_token eq '(') { $interrupts[3] = $value; print SINK convert_to_LHU_Stimulus($value)," interrupts[3]\n"}
    elsif($str_sym_token eq ')') { $interrupts[2] = $value; print SINK convert_to_LHU_Stimulus($value)," interrupts[2]\n"}
    elsif($str_sym_token eq '*') { $interrupts[1] = $value; print SINK convert_to_LHU_Stimulus($value)," interrupts[1]\n"}
    elsif($str_sym_token eq '+') { $interrupts[0] = $value; print SINK convert_to_LHU_Stimulus($value)," interrupts[0]\n"}
    elsif($str_sym_token eq ',') { $memadr[31] = $value}
    elsif($str_sym_token eq '-') { $memadr[30] = $value}
    elsif($str_sym_token eq '.') { $memadr[29] = $value}
    elsif($str_sym_token eq '/') { $memadr[28] = $value}
    elsif($str_sym_token eq '0') { $memadr[27] = $value}
    elsif($str_sym_token eq '1') { $memadr[26] = $value}
    elsif($str_sym_token eq '2') { $memadr[25] = $value}
    elsif($str_sym_token eq '3') { $memadr[24] = $value}
    elsif($str_sym_token eq '4') { $memadr[23] = $value}
    elsif($str_sym_token eq '5') { $memadr[22] = $value}
    elsif($str_sym_token eq '6') { $memadr[21] = $value}
    elsif($str_sym_token eq '7') { $memadr[20] = $value}
    elsif($str_sym_token eq '8') { $memadr[19] = $value}
    elsif($str_sym_token eq '9') { $memadr[18] = $value}
    elsif($str_sym_token eq ':') { $memadr[17] = $value}
    elsif($str_sym_token eq ';') { $memadr[16] = $value}
    elsif($str_sym_token eq '<') { $memadr[15] = $value}
    elsif($str_sym_token eq '=') { $memadr[14] = $value}
    elsif($str_sym_token eq '>') { $memadr[13] = $value}
    elsif($str_sym_token eq '?') { $memadr[12] = $value}
    elsif($str_sym_token eq '@') { $memadr[11] = $value}
    elsif($str_sym_token eq 'A') { $memadr[10] = $value}
    elsif($str_sym_token eq 'B') { $memadr[9] = $value}
    elsif($str_sym_token eq 'C') { $memadr[8] = $value}
    elsif($str_sym_token eq 'D') { $memadr[7] = $value}
    elsif($str_sym_token eq 'E') { $memadr[6] = $value}
    elsif($str_sym_token eq 'F') { $memadr[5] = $value}
    elsif($str_sym_token eq 'G') { $memadr[4] = $value}
    elsif($str_sym_token eq 'H') { $memadr[3] = $value}
    elsif($str_sym_token eq 'I') { $memadr[2] = $value}
    elsif($str_sym_token eq 'J') { $memadr[1] = $value}
    elsif($str_sym_token eq 'K') { $memadr[0] = $value}
    elsif($str_sym_token eq 'L') { $memdata[31] = $value}
    elsif($str_sym_token eq 'M') { $memdata[30] = $value}
    elsif($str_sym_token eq 'N') { $memdata[29] = $value}
    elsif($str_sym_token eq 'O') { $memdata[28] = $value}
    elsif($str_sym_token eq 'P') { $memdata[27] = $value}
    elsif($str_sym_token eq 'Q') { $memdata[26] = $value}
    elsif($str_sym_token eq 'R') { $memdata[25] = $value}
    elsif($str_sym_token eq 'S') { $memdata[24] = $value}
    elsif($str_sym_token eq 'T') { $memdata[23] = $value}
    elsif($str_sym_token eq 'U') { $memdata[22] = $value}
    elsif($str_sym_token eq 'V') { $memdata[21] = $value}
    elsif($str_sym_token eq 'W') { $memdata[20] = $value}
    elsif($str_sym_token eq 'X') { $memdata[19] = $value}
    elsif($str_sym_token eq 'Y') { $memdata[18] = $value}
    elsif($str_sym_token eq 'Z') { $memdata[17] = $value}
    elsif($str_sym_token eq "'['") { $memdata[16] = $value}
    elsif($str_sym_token eq "'\'") { $memdata[15] = $value}
    elsif($str_sym_token eq "']'") { $memdata[14] = $value}
    elsif($str_sym_token eq "'^'") { $memdata[13] = $value}
    elsif($str_sym_token eq "'_'") { $memdata[12] = $value}
    elsif($str_sym_token eq "'`'") { $memdata[11] = $value}
    elsif($str_sym_token eq 'a') { $memdata[10] = $value}
    elsif($str_sym_token eq 'b') { $memdata[9] = $value}
    elsif($str_sym_token eq 'c') { $memdata[8] = $value}
    elsif($str_sym_token eq 'd') { $memdata[7] = $value}
    elsif($str_sym_token eq 'e') { $memdata[6] = $value}
    elsif($str_sym_token eq 'f') { $memdata[5] = $value}
    elsif($str_sym_token eq 'g') { $memdata[4] = $value}
    elsif($str_sym_token eq 'h') { $memdata[3] = $value}
    elsif($str_sym_token eq 'i') { $memdata[2] = $value}
    elsif($str_sym_token eq 'j') { $memdata[1] = $value}
    elsif($str_sym_token eq 'k') { $memdata[0] = $value}
    elsif($str_sym_token eq 'l') { $membyteen[3] = $value}
    elsif($str_sym_token eq 'm') { $membyteen[2] = $value}
    elsif($str_sym_token eq 'n') { $membyteen[1] = $value}
    elsif($str_sym_token eq 'o') { $membyteen[0] = $value}
    elsif($str_sym_token eq 'p') { $memrwb = $value}
    elsif($str_sym_token eq 'q') { $memen = $value}
    elsif($str_sym_token eq 'r') { $memdone = $value; print SINK convert_to_LHU_Stimulus($value)," memdone\n"}
    else{}
  }#end else from if( #)...
  
  
}#end while(source)

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


#convert 0,1,x to irsim node inpts of l,h, & u.
sub convert_to_LHU_Stimulus{
  my $stim=shift;
  if($stim=~ /0/){return "l"}
  elsif($stim=~ /1/){return "h"}
  else{return "u"}
}
