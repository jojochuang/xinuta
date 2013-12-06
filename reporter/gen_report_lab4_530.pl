#!/usr/bin/perl

use lib '/homes/chuangw/cs503/fall2013/Text-CSV-1.21/lib/';
use Text::CSV;

my @rows;
my $csv = Text::CSV->new ( { binary => 1 }, {empty_is_undef => 1} )  # should set binary attribute.
or die "Cannot use CSV: ".Text::CSV->error_diag ();

open my $fh, "<:encoding(utf8)", "cs503lab4.csv" or die "cs503lab4.csv: $!";
my $caption = $csv->getline( $fh );
foreach (@{ $caption }){
  print "|$_|\t";
}
my $user_name = 1;

my $problem_1_score = 2;
my $problem_1_comment = 3;
my $problem_1_report_score = 4;
my $problem_1_report_comment = 5;
my $problem_2_score = 6;
my $problem_2_comment = 7;
my $problem_2_report_score = 8;
my $problem_2_report_comment = 9;
my $problem_3_score = 10;
my $problem_3_comment = 11;
#my $problem_33_report_score = 12;
#my $problem_33_report_comment = 13;

#my $problem_4_score = 14;
#my $problem_4_comment = 15;

#my $problem_5_score = 16;
#my $problem_5_comment = 17;
#my $problem_5_report_score = 18;
#my $problem_5_report_comment = 19;

my $bonus_score = 14;
my $bonus_comment = 15;
#my $bonus_report_score = 22;
#my $bonus_report_comment = 23;

my $raw_total = 18;
my $other_adjustments = 19;
my $adjusted = 20;
my $early_bonus = 21;
my $late_days = 22;
my $total = 23;
print "\n";

my $labid = "lab4";
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

Part 1 Implementation: ${ $row }[ $problem_1_score ]
${ $row }[ $problem_1_comment ]

Part 1 Report: ${ $row }[ $problem_1_report_score ]
${ $row }[ $problem_1_report_comment ]

Part 2 Implementation: ${ $row }[ $problem_2_score ]
${ $row }[ $problem_2_comment ]

Part 2 Report: ${ $row }[ $problem_2_report_score ]
${ $row }[ $problem_2_report_comment ]

Part 3 Implementation: ${ $row }[ $problem_3_score ]
${ $row }[ $problem_3_comment ]

Bonus Implementation: ${ $row }[ $bonus_score ]
${ $row }[ $bonus_comment ]


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
