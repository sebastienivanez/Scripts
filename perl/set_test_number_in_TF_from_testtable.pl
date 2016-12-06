#! /usr/bin/env perl


use POSIX;
#### VARIABLES DECLARATION
my %tm_table;
my %tsuite_table;
my %testtable;

$InFil=$ARGV[0] || die "ERROR: no test flow specified !";
$TTFil=$ARGV[1] || die "ERROR: test table specified !";



open(INPFIL1, $TTFil ) || die "ERROR:   Unable to read the file $TTFil";
print "\n";
print "INFO: File $TTFil is open...\n";

while (<INPFIL1>) {
my $cur_line=$_;
$cur_line =~ s/"//g;
my @ligne = split( /\,/, $cur_line );
$testtable{$ligne[0]}{'testsuite'}=$ligne[0];
$testtable{$ligne[0]}{'testname'}=$ligne[1];
$testtable{$ligne[0]}{'testnumber'}=$ligne[2];
$testtable{$ligne[0]}{'low_lim'}=$ligne[3];
$testtable{$ligne[0]}{'low_cmp'}=$ligne[4];
$testtable{$ligne[0]}{'high_lim'}=$ligne[5];
$testtable{$ligne[0]}{'high_cmp'}=$ligne[6];
$testtable{$ligne[0]}{$ligne[1]}=$ligne[2];
}
close INPFIL1;



open(INPFIL, $InFil ) || die "ERROR:   Unable to read the file $InFil";
print "\n";
print "INFO: File $InFil is open...\n";

##print "INFO: var $InFil  created\n";

$ResFil=$InFil."_out";
$ResFil2=$InFil."_testmethodlimits";


open(OUTFIL,  ">$ResFil") || die "ERROR:   Unable to open the file $ResFil";
print "INFO: File $ResFil created\n";

my $detect_override_testf=0;
my $detect_override_test_number=0;
my $tm_number;

while (<INPFIL>) {

my $current_ligne = $_;

		if (/^testmethodparameters/)
		{
		$testmethodparameters_fields=1;
		$record_testmethodparameters_fields=0;
		$record_testmethodlimits_fields=0;
		$record_testmethods_fields=0;
		$detect_override_testf=0;
		$detect_override_test_number=0;

		}
		elsif (/^testmethodlimits/)
		{
		$testmethodlimits_fields=1;
		$testmethodparameters_fields=0;
		$record_testmethodparameters_fields=0;
		$record_testmethodlimits_fields=0;
		$record_testmethods_fields=0;
		$detect_override_testf=0;
		$detect_override_test_number=0;
		}
		elsif (/^testmethods/)
		{
		$testmethods_fields=1;
		$testmethodlimits_fields=0;
		$testmethodparameters_fields=0;
		$record_testmethodparameters_fields=0;
		$record_testmethodlimits_fields=0;
		$record_testmethods_fields=0;
		$detect_override_testf=0;
		$detect_override_test_number=0;
		}
		elsif (/^test_suites/)
		{
		$test_suites_fields=1;
		$testmethods_fields=0;
		$testmethodlimits_fields=0;
		$testmethodparameters_fields=0;
		$record_testmethodparameters_fields=0;
		$record_testmethodlimits_fields=0;
		$record_testmethods_fields=0;
		$detect_override_testf=0;
		$detect_override_test_number=0;
		}
			
		
		elsif ( (/^tm_(\d+):/) and ($testmethodparameters_fields == 1) )
		{
		$tm_number="tm_".$1;
		$record_testmethodparameters_fields=1;
		}
		
		elsif ( (/^\s+\"([a-zA-Z0-9 _]+)\"\s+=\s+\"([a-zA-Z0-9 _]+)\"/) and ($record_testmethodparameters_fields == 1) )
		
		{
		$tm_table{$tm_number}{'parameters'}{$1}= $2;
		if ($1 =~ /testName/)
			{		$tm_table{$tm_number}{'parameters'}{$1}{$2}=$2;

			}
		}
		
		elsif ((/^tm_(\d+):/) and ($testmethodlimits_fields == 1) )
		{
		$tm_number="tm_".$1;
		$record_testmethodlimits_fields=1;
		}
			
		#elsif ((/^\s+\"([a-zA-Z0-9 _]+)\"\s+=\s+(.*)/) and ($record_testmethodlimits_fields == 1))
		
		elsif ((/^\s+\"([a-zA-Z0-9 _]+)\"\s+=\s+\"([-0-9.]*)\":\"([A-Z]+)\":\"([-0-9.]*)\":\"([A-Z]+)\":\"\":\"([-0-9.]*)\":\"([-0-9.]*)\"/) and ($record_testmethodlimits_fields == 1))
	
		{chomp $2;
		#$tm_table{$tm_number}{'limits'}=$1." = ".$2;
		$tm_table{$tm_number}{'limits'}{$1}{'low_limit'} = $2;
		$tm_table{$tm_number}{'limits'}{$1}{'low_cmp'} = $3;
		$tm_table{$tm_number}{'limits'}{$1}{'high_limit'} = $4;
		$tm_table{$tm_number}{'limits'}{$1}{'high_cmp'} = $5;
		$tm_table{$tm_number}{'limits'}{$1}{'test_number'} = $6;
		$tm_table{$tm_number}{'limits'}{$1}{'last'} = $7;
			#ODL add test name for this format:
		$tm_table{$tm_number}{'parameters'}{'testName'}{$1}=$1;
		
		}
		
		elsif ((/^tm_(\d+):/) and ($testmethods_fields == 1))
		{
		$record_testmethods_fields=1;
		$tm_number="tm_".$1;
		}

		elsif ( (/^\s+testmethod_class\s+=\s+(.*)/) and ($record_testmethods_fields == 1) )
		{chomp $1;
		$tm_table{$tm_number}{'class'}=$1;
		
		}

		
		elsif ((/^([a-zA-Z0-9_]+):/) and ($test_suites_fields == 1) )
		{
		$record_test_suites_fields=1;
		$test_suite=$1;
		$detect_override_testf=0;
		$detect_override_test_number=0;
		}

		elsif ((/^\s+local_flags\s+=\s+(.*)/) and ($record_test_suites_fields == 1) )
		{chomp $1;
		$field1=$1;
		$field1=~s/\"//;
		$field1=~s/\;//;
		$tsuite_table{$test_suite}{'local_flags'}=$field1;
		}

		elsif ((/^\s+override\s+=\s+(.*)/) and ($record_test_suites_fields == 1))
		{chomp $1;
		$field1=$1;
		$field1=~s/\"//;
		$field1=~s/\;//;
		$tsuite_table{$test_suite}{'override'}=$field1;
		}

		elsif ((/^\s+override_lev_equ_set\s+=\s+(.*)/) and ($record_test_suites_fields == 1))
		{chomp $1;
		$field1=$1;
		$field1=~s/\"//;
		$field1=~s/\;//;
		$tsuite_table{$test_suite}{'override_lev_equ_set'}=$field1;
		}

		elsif ((/^\s+override_lev_spec_set\s+=\s+(.*)/) and ($record_test_suites_fields == 1))
		{chomp $1;
		$field1=$1;
		$field1=~s/\"//;
		$field1=~s/\;//;
		$tsuite_table{$test_suite}{'override_lev_spec_set'}=$field1;
		}

		elsif ((/^\s+override_levset\s+=\s+(.*)/) and ($record_test_suites_fields == 1))
		{chomp $1;
		$field1=$1;
		$field1=~s/\"//;
		$field1=~s/\;//;
		$tsuite_table{$test_suite}{'override_levset'}=$field1;
		}

		elsif ((/^\s+override_seqlbl\s+=\s+(.*)/) and ($record_test_suites_fields == 1))
		{chomp $1;
		$field1=$1;
		$field1=~s/\"//;
		$field1=~s/\;//;
		$tsuite_table{$test_suite}{'override_seqlbl'}=$field1;
		}
		

		elsif ((/^\s+override_test_number\s+=\s+(.*)/) and ($record_test_suites_fields == 1))
		{chomp $1;
		$field1=$1;
		$field1=~s/\"//;
		$field1=~s/\;//;
		$tsuite_table{$test_suite}{'override_test_number'}=$field1;
		$detect_override_test_number=1;
		}
		

		elsif ((/^\s+override_testf\s+=\s+(.*)/) and ($record_test_suites_fields == 1))
		{chomp $1;
		$field1=$1;
		$field1=~s/\"//;
		$field1=~s/\;//;
		$tsuite_table{$test_suite}{'override_testf'}=$field1;
		$detect_override_testf=1;
		$tm_table{$field1}{'test_suite'}=$test_suite;
		$detect_override_test_number=0;
		}

		elsif ((/^\s+override_tim_spec_set\s+=\s+(.*)/) and ($record_test_suites_fields == 1))
		{chomp $1;
		$field1=$1;
		$field1=~s/\"//;
		$field1=~s/\;//;
		$tsuite_table{$test_suite}{'override_tim_spec_set'}=$field1;
		$detect_override_testf=0;
		}

		elsif ((/^\s+override_timset\s+=\s+(.*)/) and ($record_test_suites_fields == 1))
		{chomp $1;
		$field1=$1;
		$field1=~s/\"//;
		$field1=~s/\;//;
		$tsuite_table{$test_suite}{'override_timset'}=$field1;
		}


		elsif ((/^\s+site_control\s+=\s+(.*)/) and ($record_test_suites_fields == 1))
		{chomp $1;
		$field1=$1;
		$field1=~s/\"//;
		$field1=~s/\;//;
		$tsuite_table{$test_suite}{'site_control'}=$field1;
		}


		elsif ((/^\s+site_match\s+=\s+(.*)/) and ($record_test_suites_fields == 1))
		{chomp $1;
		$field1=$1;
		$field1=~s/\"//;
		$field1=~s/\;//;
		$tsuite_table{$test_suite}{'site_match'}=$field1;
		$record_test_suites_fields =0;
		}
		
	 else 
		 {
		 }
## ODL: print global test suite test number for functional test
#if ((exists $testtable{$test_suite}{'testsuite'}) and ($detect_override_testf==1) and ($test_suite =~ /TF/ ))
if ((exists $testtable{$test_suite}{'testsuite'}) and ($detect_override_test_number==1) and ($test_suite =~ /TF/ ))
	{ #print "test_suite $test_suite\n";
	#: ODL this to not overwrite the testflow testnumber if existing,  if you wish
	#if (exists $tsuite_table{$test_suite}{'override_test_number'})
	#	{
	#	print OUTFIL $current_ligne;
	#	}
	#	
	#else
	#	{
		print OUTFIL "  override_test_number = $testtable{$test_suite}{'testnumber'};\n";
	#	print OUTFIL $current_ligne;
	#	}
		
	}


else
{
print OUTFIL $current_ligne;
}



}


close (INPFIL);
close (OUTFIL);


open(OUTFIL,  ">$ResFil2") || die "ERROR:   Unable to open the file $ResFil2";
print "INFO: File $ResFil2 created\n";


foreach $key_tm_table (sort keys %tm_table)
{#print $key_tm_table."\n";
foreach $key_test_suite (keys %tsuite_table)
{ 
if ( $tm_table{$key_tm_table}{'test_suite'} eq  $key_test_suite)
{
	#print $key_test_suite."\n";
	#print $tsuite_table{$key_test_suite}{'override_testf'}."\n";
	#print $tm_table{$tsuite_table{$key_test_suite}{'override_testf'}}{'parameters'}{'testName'}."\n";
	
	# my $current_test_name=$tm_table{$tsuite_table{$key_test_suite}{'override_testf'}}{'parameters'}{'testName'};
	foreach $current_test_name (keys  %{$tm_table{$tsuite_table{$key_test_suite}{'override_testf'}}{'parameters'}{'testName'}})
	{
	if ($current_test_name ne "")
	{
	if ($yet_printed == 0) 
		{		print OUTFIL $key_tm_table.":\n";$yet_printed =1;

		}
	print OUTFIL "\t\"".$current_test_name."\" = \"".$tm_table{$key_tm_table}{'limits'}{$current_test_name}{'low_limit'}."\":\"".$tm_table{$key_tm_table}{'limits'}{$current_test_name}{'low_cmp'}."\":\"".$tm_table{$key_tm_table}{'limits'}{$current_test_name}{'high_limit'}."\":\"".$tm_table{$key_tm_table}{'limits'}{$current_test_name}{'high_cmp'}."\":\"\":\"".$testtable{$key_test_suite}{$current_test_name}."\":\"".$tm_table{$key_tm_table}{'limits'}{$current_test_name}{'last'}."\";\n";
	}
	}
$yet_printed =0;
}
}


}
#		$tm_table{$key_tm_table}{'limits'}{$current_test_name}{'low_limit'}
#		$tm_table{$key_tm_table}{'limits'}{$current_test_name}{'low_cmp'}
#		$tm_table{$key_tm_table}{'limits'}{$current_test_name}{'high_limit'}
#		$tm_table{$key_tm_table}{'limits'}{$current_test_name}{'high_cmp'}
#		$tm_table{$key_tm_table}{'limits'}{$current_test_name}{'test_number'}
#		$tm_table{$key_tm_table}{'limits'}{$current_test_name}{'last'}

#$testtable{$key_test_suite}{'testsuite'}
#$testtable{$key_test_suite}{'testname'}
#$testtable{$key_test_suite}{'testnumber'}
#$testtable{$key_test_suite}{'low_lim'}
#$testtable{$key_test_suite}{'low_cmp'}
#$testtable{$key_test_suite}{'high_lim'}
#$testtable{$key_test_suite}{'high_cmp'}
