#!/usr/bin/perl

use lib '/homes/chuangw/cs503/fall2013/Text-CSV-1.21/lib/';
use Text::CSV;

my @rows;
my $csv = Text::CSV->new ( { binary => 1 }, {empty_is_undef => 1} )  # should set binary attribute.
or die "Cannot use CSV: ".Text::CSV->error_diag ();

open my $fh, "<:encoding(utf8)", "cs503lab3.csv" or die "cs503lab3.csv: $!";
my $caption = $csv->getline( $fh );
foreach (@{ $caption }){
  print "|$_|\t";
}
my $user_name = 1;

my $problem_31_score = 2;
my $problem_31_comment = 3;
my $problem_31_report_score = 4;
my $problem_31_report_comment = 5;
my $problem_32_score = 6;
my $problem_32_comment = 7;
my $problem_32_report_score = 8;
my $problem_32_report_comment = 9;
my $problem_33_score = 10;
my $problem_33_comment = 11;
my $problem_33_report_score = 12;
my $problem_33_report_comment = 13;

my $problem_4_score = 14;
my $problem_4_comment = 15;

my $problem_5_score = 16;
my $problem_5_comment = 17;
my $problem_5_report_score = 18;
my $problem_5_report_comment = 19;

my $bonus_score = 20;
my $bonus_comment = 21;
my $bonus_report_score = 22;
my $bonus_report_comment = 23;

my $raw_total = 24;
my $other_adjustments = 25;
my $adjusted = 26;
my $early_bonus = 27;
my $late_days = 28;
my $total = 29;
print "\n";

my $labid = "lab3";
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

CPU Intensive: ${ $row }[ $problem_31_score ]
${ $row }[ $problem_31_comment ]

CPU Intensive Report: ${ $row }[ $problem_31_report_score ]
${ $row }[ $problem_31_report_comment ]

IO-Intensive: ${ $row }[ $problem_32_score ]
${ $row }[ $problem_32_comment ]

IO-Intensive Report: ${ $row }[ $problem_32_report_score ]
${ $row }[ $problem_32_report_comment ]

Half-Half: ${ $row }[ $problem_33_score ]
${ $row }[ $problem_33_comment ]

Half-Half Report: ${ $row }[ $problem_33_report_score ]
${ $row }[ $problem_33_report_comment ]

Accurate Kernel Measure: ${ $row }[ $problem_4_score ]
${ $row }[ $problem_4_comment ]

Starvation: ${ $row }[ $problem_5_score ]
${ $row }[ $problem_5_comment ]

Starvation Report: ${ $row }[ $problem_5_report_score ]
${ $row }[ $problem_5_report_comment ]

Bonus: ${ $row }[ $bonus_score ]
${ $row }[ $bonus_comment ]

Bonus Report: ${ $row }[ $bonus_report_score ]
${ $row }[ $bonus_report_comment ]

Raw Total:
${ $row }[ $raw_total ]

Other Adjustments:
${ $row }[ $other_adjustments ]

Early Submission Bonus:
${ $row }[ $early_bonus ]

Late Days Used:
${ $row }[ $late_days ]

Final Total:
${ $row }[ $total ]


Inquries:
Report: Josh reese5\@purdue.edu
Implementation: Wei-Chiu weichiu\@purdue.edu

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
