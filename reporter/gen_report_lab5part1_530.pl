#!/usr/bin/perl

use lib '/homes/chuangw/cs503/fall2013/Text-CSV-1.21/lib/';
use Text::CSV;

my @rows;
my $csv = Text::CSV->new ( { binary => 1 }, {empty_is_undef => 1} )  # should set binary attribute.
or die "Cannot use CSV: ".Text::CSV->error_diag ();

open my $fh, "<:encoding(utf8)", "cs503lab5part1.csv" or die "cs503lab5part1.csv: $!";
my $caption = $csv->getline( $fh );
foreach (@{ $caption }){
  print "|$_|\t";
}
my $user_name = 1;

my $problem_1_score = 2;
my $problem_1_comment = 3;

my $problem_2_score = 4;
my $problem_2_comment = 5;

my $raw_total = 6;
my $other_adjustments = 7;
my $adjusted = 8;
my $early_bonus = 9;
my $late_days = 10;
my $total = 11;
print "\n";

my $labid = "lab5part1";
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

Test0-12: (Test0 accounts for 70 points. Test1~13 are 30 points each)

${ $row }[ $problem_1_score ]
${ $row }[ $problem_1_comment ]

Test13: ${ $row }[ $problem_2_score ]
${ $row }[ $problem_2_comment ]

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


ALl inquries:
Wei-Chiu weichiu\@purdue.edu

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
