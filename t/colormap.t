#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;
use Test::Exception;

BEGIN {
    use_ok(
        'Term::Colormap', qw(
          colorbar
          colormap
          color2rgb
          print_colored
          print_colored_text
          color_table
          )
    ) || print "Bail out on imports!\n";
}

my @valid_colormaps = qw( rainbow primary bright ash snow gray );

for my $name ( @valid_colormaps ) {
    my $mapping = colormap($name);
    ok ( scalar @$mapping, "Colormap $name" );
}

dies_ok { colormap('foo') } 'Colormap catches invalid names';

