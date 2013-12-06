#!/usr/bin/perl

use lib '/homes/chuangw/cs503/fall2013/Text-CSV-1.21/lib/';
use Text::CSV;

my @rows;
my $csv = Text::CSV->new ( { binary => 1 }, {empty_is_undef => 1} )  # should set binary attribute.
or die "Cannot use CSV: ".Text::CSV->error_diag ();

open my $fh, "<:encoding(utf8)", "cs503lab1.csv" or die "cs503lab1.csv: $!";
my $caption = $csv->getline( $fh );
foreach (@{ $caption }){
  print "|$_|\t";
}
my $user_name = 1;

my $problem_31_score = 2;
my $problem_31_comment = 3;
my $problem_32_score = 4;
my $problem_32_comment = 5;
my $problem_33_score = 6;
my $problem_33_comment = 7;
my $problem_34_score = 8;
my $problem_34_comment = 9;

my $problem_4_score = 10;
my $problem_41_comment = 11;
my $problem_42_comment = 12;

my $problem_5_programming_score = 13;
my $problem_5_programming_comment = 14;
my $problem_5_written_score = 15;
my $problem_5_written_comment = 16;

my $problem_6_programming_score = 17;
my $problem_6_programming_comment = 18;
my $problem_6_written_score = 19;
my $problem_6_written_comment = 20;

my $raw_total = 21;
my $other_adjustments = 22;
my $adjusted = 23;
my $early_bonus = 24;
my $late_days = 25;
my $total = 26;
print "\n";

my $labid = "lab1";
my $report_dir = "grading_reports";
while ( my $row = $csv->getline( $fh ) ) {
  my $s_name = trim(${ $row }[ $user_name ]);
  next if $s_name eq "";
  create_dir(  $s_name, $labid );
  gen_student_report( $row );
}
$csv->eof or $csv->error_diag();
close $fh;

sub create_dir{
  my $s_name = shift;
  my $labid = shift;

  my $student_report_dir = "./$report_dir/$s_name";
  unless( -d $student_report_dir ){
    print "create directory for student '$s_name'\n";
    mkdir( $student_report_dir );
  }
}

sub gen_student_report {
  my $row = shift;
  my $s_name = trim(${ $row }[ $user_name ]);

  my $student_report_dir = "./$report_dir/$s_name";
  my $report_path = "$student_report_dir/$labid.rpt";
  my $fh;
  open( $fh, ">", $report_path ) or die("can't open file $report_path to write");

  print $fh <<EOF;
${ $row }[ $user_name ]
Total: ${ $row }[ $total ]

Here's the breakdown:

Problem3.1: ${ $row }[ $problem_31_score ]
${ $row }[ $problem_31_comment ]

Problem3.2: ${ $row }[ $problem_32_score ]
${ $row }[ $problem_32_comment ]

Problem3.3: ${ $row }[ $problem_33_score ]
${ $row }[ $problem_33_comment ]

Problem3.4: ${ $row }[ $problem_34_score ]
${ $row }[ $problem_34_comment ]

Problem4: ${ $row }[ $problem_4_score ]
4.1:
${ $row }[ $problem_41_comment ]
4.2:
${ $row }[ $problem_42_comment ]

Problem5 Programming: ${ $row }[ $problem_5_programming_score ]
${ $row }[ $problem_5_programming_comment ]

Problem5 Written: ${ $row }[ $problem_5_written_score ]
${ $row }[ $problem_5_written_comment ]

Problem6 Programming: ${ $row }[ $problem_6_programming_score ]
${ $row }[ $problem_6_programming_comment ]

Problem6 Written: ${ $row }[ $problem_6_written_score ]
${ $row }[ $problem_6_written_comment ]

Raw Total:
${ $row }[ $raw_total ]

Other Adjustments:
${ $row }[ $other_adjustments ]

Early Submission Bonus:
${ $row }[ $bonus ]

Late Days Used:
${ $row }[ $late_days ]

Final Total:
${ $row }[ $total ]


Inquries:
Programming part: Wei-Chiu weichiu\@purdue.edu
Written part: Josh reese5\@purdue.edu

Please make sure your code compiles even after main.c is replaced. A lot of time I see people declaring global variables in main.c and use it somewhere else. Also, please also make sure the function name and the parameter type are correct. File name of the reports must be 'LabXAnswers.pdf'.
EOF

  close $fh;
}

sub trim($)
{
  my $string = shift;
  $string =~ s/^\s+//;
  $string =~ s/\s+$//;
  return $string;
}
