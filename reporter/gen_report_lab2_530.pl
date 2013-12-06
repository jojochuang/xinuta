#!/usr/bin/perl

use lib '/homes/chuangw/cs503/fall2013/Text-CSV-1.21/lib/';
use Text::CSV;

my @rows;
my $csv = Text::CSV->new ( { binary => 1 }, {empty_is_undef => 1} )  # should set binary attribute.
or die "Cannot use CSV: ".Text::CSV->error_diag ();

open my $fh, "<:encoding(utf8)", "cs503lab2.csv" or die "cs503lab2.csv: $!";
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
my $problem_35_score = 10;
my $problem_35_comment = 11;

my $problem_41_score = 12;
my $problem_41_comment = 13;
my $problem_42_score = 14;
my $problem_42_comment = 15;
my $problem_43_score = 16;
my $problem_43_comment = 17;
my $problem_44_score = 18;
my $problem_44_comment = 19;
my $problem_45_score = 20;
my $problem_45_comment = 21;

my $raw_total = 22;
my $other_adjustments = 23;
my $adjusted = 24;
my $early_bonus = 25;
my $late_days = 26;
my $total = 27;
print "\n";

my $labid = "lab2";
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

Problem3.5: ${ $row }[ $problem_35_score ]
${ $row }[ $problem_35_comment ]

Problem4.1: ${ $row }[ $problem_41_score ]
${ $row }[ $problem_41_comment ]

Problem4.2: ${ $row }[ $problem_42_score ]
${ $row }[ $problem_42_comment ]

Problem4.3: ${ $row }[ $problem_43_score ]
${ $row }[ $problem_43_comment ]

Problem4.4: ${ $row }[ $problem_44_score ]
${ $row }[ $problem_44_comment ]

Problem4.5: ${ $row }[ $problem_45_score ]
${ $row }[ $problem_45_comment ]

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
Part 3: Josh reese5\@purdue.edu
Part 4: Wei-Chiu weichiu\@purdue.edu

Please make sure your code compiles even after main.c is replaced. Do not declare global variables in main.c and use it somewhere else. Also, please also make sure the function name and the parameter type are correct. File name of the reports must be 'LabXAnswers.pdf' in system directory.

In 4.3.2, to be more specific, when main process resumes a child process, resume() calls ready(), which in turn calls resched(). Because main and the process A has the same priority, resched() context-swtiches to process A. Note that this happens right when resume() is called, not because timeslice expires. Therefore, it is ambiguous to simply say "because main and the process A are of equal priority, they context switch in round-robin fashion." because it implies main() would have continue to run until its timeslice expires and creates process B and C before process A ever get a chance to run.
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
