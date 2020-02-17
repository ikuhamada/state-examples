#! /usr/bin/perl -w
# $Id: traj2xyz.pl,v 1.4 2004/07/12 08:21:59 akohlmey Exp $
# small script to convert a cpmd TRAJECTORY file into a multi step xyz file.
# needs a single step .xyz file for assignment of the atom labels.
# supports path-integral runs as well, where it prepends the replica
# coordinate data with the average of the replica positions.
#
# an updated version may be found at
# http://www.theochem.ruhr-uni-bochum.de/go/cpmd-vmd.html
#
# (c) 2002-2004 by axel.kohlmeyer@theochem.ruhr-uni-bochum.de

use strict;
use Getopt::Long;
use Pod::Usage;
use IO::File;

# initialize variables
my @x = ();
my @y = ();
my @z = ();
my @vx = ();
my @vy = ();
my @vz = ();
my @a = ();
my ($atoms, $atmcount, $step, $nfi, $nfioffs) = (0,0,0,0,0);
my $bohr = 0.529177249;
my $atu  = 0.0241888428;

# variables for commandline parsing.
my $trajfile = "TRAJECTORY";
my $geomfile = "GEOMETRY.xyz";
my $in = 0;
my $out = \*STDOUT;
my $help = 0;
my $first = 1;
my $delta = 1;

# parse commandline arguments
Getopt::Long::Configure ("bundling");
GetOptions( 'input|i=s'    => \$trajfile,
            'delta|d=i'    => \$delta,
            'geometry|g=s' => \$geomfile,
            'output|o=s'  => sub { $out = new IO::File "$_[1]", "w";
                                   die "\ncould not open file $_[1] for writing: $!\n\n"
                                       unless defined $out;},
            'help|h'      => \$help,)
  or pod2usage(2);

# print man page and exit if requested.
pod2usage(-exitstatus => 0, -verbose => 2) if $help;

# read in the reference geometry
$in = new IO::File $geomfile, "r";
die "\ncould not open reference geometry file '$geomfile' for reading: $!\n\n"
  unless defined $in;

# the first line of an .xyz file has to be the number of atoms.
# the next one is the (to be ignored) title.
$_ = <$in>;
chomp $_;
if (/^\s*(\d+)\s*$/) {
    $atoms = $1;
} else {
    die "\nunsupported xyz format in $geomfile.\n",
      "first line was not a sole number\n";
}
$_ = <$in>;

# loop through xyz file (or first section of an xyz movie).
foreach (my $i=0; $i < $atoms; ++$i) {
    $_ = <$in> || die "\npremature end of file $geomfile\n";
    chomp $_;
    my @line = split;
    if ($#line < 3) {
        die "\nmissing data in line ", $i + 1, " in $geomfile\n";
    }
    $a[$i] = $line[0];
    $x[$i] = $line[1];
    $y[$i] = $line[2];
    $z[$i] = $line[3];
    if ($#line >= 6) {
        $vx[$i] = $line[4];
        $vy[$i] = $line[5];
        $vz[$i] = $line[6];
    } else {
	$vx[$i] = 0.0;
	$vy[$i] = 0.0;
	$vz[$i] = 0.0;
    }
}

# read and convert the trajectory file
$atmcount = 0;
my $nbeads   = 0;
my $oldnfi   = 0;
my $savedline = "";
if ("$trajfile" eq "-") {
    $in = \*STDIN;
} else {
    $in = new IO::File $trajfile, "r";
}
die "\ncould not open TRAJECTORY file '$trajfile' for reading: $!\n\n"
  unless defined $in;

while (<$in>) {
  AGAIN:
    if ((/<<<<<<  NEW DATA  >>>>>>/)
        || (($atoms*$nbeads > 0) && ($atmcount == $atoms*$nbeads))) {

        # in case the first chunch is only one timestep we enter with
        # $nbeads == 0. fix this.
        if ($nbeads == 0) {$nbeads = 1; }

        # sanity check
        if ($atmcount != $atoms*$nbeads) {
            die "atom count mismatch ($atoms * $nbeads vs $atmcount) step\# $step,",
              " NFI $nfi (+ $nfioffs). exiting\n";
        }

        # one configuration complete. print out xyz.
        # we first calculate and print the (arithmetic) average
        # coordinates and velocities for the 'classical atoms'.
        # the replica have the label string prefixed with an X.
        ++ $step; $atmcount=0;
	if (0 == ($step % $delta)) {
            # prefix string for PI-trajectories:
            my $prefix = "";
            if ($nbeads > 1) {
                $prefix = "X";
                print $out $atoms*($nbeads + 1),"\nconverted from cpmd TRAJECTORY.",
                  " NFI: ", $nfi + $nfioffs, "  step\#: $step\n";
                for (my $i = 0 ; $i < $atoms; ++ $i) {
                    my ($tx,$ty,$tz,$tvx,$tvy,$tvz) = (0.0,0.0,0.0,0.0,0.0,0.0);
                    for (my $j = 0 ; $j < $nbeads; ++ $j) {
                        $tx  += $x[$j*$atoms + $i];
                        $ty  += $y[$j*$atoms + $i];
                        $tz  += $z[$j*$atoms + $i];
                        $tvx += $vx[$j*$atoms + $i];
                        $tvy += $vy[$j*$atoms + $i];
                        $tvz += $vz[$j*$atoms + $i];
                    }
                    printf $out "%-3s %12.6f %12.6f %12.6f    %18.12g %18.12g %18.12g\n",
                      $a[$i], $tx/$nbeads, $ty/$nbeads, $tz/$nbeads,
                        $tvx/$nbeads, $tvy/$nbeads, $tvz/$nbeads;
                }
            } else {
                print $out $atoms,"\nconverted from cpmd TRAJECTORY.",
                  " NFI: ", $nfi + $nfioffs, "  step\#: $step\n";
            }
            for (my $i = 0 ; $i < $atoms*$nbeads; ++ $i) {
                printf $out "%-3s %12.6f %12.6f %12.6f    %18.12g %18.12g %18.12g\n",
                  $prefix . $a[$i % $atoms], $x[$i], $y[$i], $z[$i], $vx[$i], $vy[$i], $vz[$i];
            }
        }
    }

    # skip over NEW DATA line
    if (/<<<<<<  NEW DATA  >>>>>>/) {
        $_ = <$in> if defined($in) or exit 0;
    }

    my @line = split;
    # fix NFI, if we have restarted without accumulators
    if ($line[0] < $nfi) {
        $nfioffs += $nfi;
    }
    $oldnfi = $nfi;
    $nfi = $line[0];

    # detect number of beads by switch in NFI
    if (($atmcount > 0)&& ($oldnfi != $nfi)) {
        print STDERR "bingo: $oldnfi $nfi $atmcount $atoms\n";
        $nbeads = $atmcount/$atoms;
        goto AGAIN;
    }

    $x[$atmcount] = $line[1]*$bohr;
    $y[$atmcount] = $line[2]*$bohr;
    $z[$atmcount] = $line[3]*$bohr;
    if ($#line >= 6) {
        $vx[$atmcount] = $line[4]*$bohr/$atu;
        $vy[$atmcount] = $line[5]*$bohr/$atu;
        $vz[$atmcount] = $line[6]*$bohr/$atu;
    } else {
        $vx[$atmcount] = 0.0;
        $vy[$atmcount] = 0.0;
        $vz[$atmcount] = 0.0;
    }

    ++ $atmcount;
}

# print out final configuration.
++ $step; $atmcount=0;
print $out "$atoms\nconverted from cpmd TRAJECTORY.",
  " NFI: ", $nfi + $nfioffs, "  step\#: $step\n";
for (my $i = 0 ; $i < $atoms; ++ $i) {
    printf $out "%-3s %12.6f %12.6f %12.6f    %18.12g %18.12g %18.12g\n",
      $a[$i], $x[$i], $y[$i], $z[$i], $vx[$i], $vy[$i], $vz[$i];
}

exit 0;


# embedded documentation.

__END__

=head1 NAME

traj2xyz.pl - convert cpmd trajectory file into multistep XYZ format.

=head1 SYNOPSIS

traj2xyz.pl [options] 

Options:

 --input=<name>, -i <name>    set input file to '<name>'.
                              defaults to TRAJECTORY.
 --geometry=<name>, -g <name> set name of reference geometry file
                              (in xyz format) defaults to GEOMETRY.xyz.
 --output=<name>, -o <name>  set output file to '<name>'. defaults to stdout.
 --help, -h                  print full manual page.

=head1 DESCRIPTION

B<traj2xyz.pl> tries to convert a cpmd style TRAJECTORY file into
a multistep xyz format movie file. The output has been tested with
VMD. Other programs to view the resulting xyz file may or may not work.

Data from path-integral runs is supported as well. In this case the
each coordinate data step is prepended with the (arithmetic) average
positions of each set of replica. Replica labels are prepended with X.

The program stops, if the number of atoms in the reference xyz file
and the trajectory file do not match.

=head1 OPTIONS

=over 8

=item B<-i, --input>

Set the input file name. If you do not set this option the program 
tries to read a file named 'TRAJECTORY' in the current directory.

=item B<-o, --output>

Set the output file name. If you do not set this option the program
writes to the standard output (i.e. your terminal).

=item B<-g, --geometry>

Set the reference geometry file name. If you do not set this option, 
the program  tries to read a file named 'GEOMETRY.xyz' in the current 
directory. This file B<has> to be in xyz-format, but the coordinate
data of this file is ignored. It is only needed for reading the atom
labels. For path-integral data it must only contain the coordinates
for one replica.

=item B<-h, --help>

Prints this manual page and exits.

=back

=head1 KNOWN BUGS

no coordinate boxshift postprocessing when using PBC.

=head1 VERSION

$Id: traj2xyz.pl,v 1.4 2004/07/12 08:21:59 akohlmey Exp $

=cut

# Local Variables:
# mode: cperl
# cperl-indent-level: 4
# End:
