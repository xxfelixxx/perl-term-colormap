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
          rgb2color
          print_colored
          print_colored_text
          color_table
          )
    ) || print "Bail out on imports!\n";
}

my @valid_colormaps = qw(
    ash
    bright
    gray
    primary
    rainbow
    snow
    blue-cyan-green
    red-pink-yellow
    green-orange-pink-blue
);

for my $name ( @valid_colormaps ) {
    my $mapping = colormap($name);
    ok ( scalar @$mapping, "Colormap $name" );
}

dies_ok { colormap('foo') } 'Colormap catches invalid names';

my $colors_seen = {};
for my $color ( 0 .. 255 ) {
    my $rgb = color2rgb($color);
    ok( 6 == length($rgb), 'color2rgb( ' . $color . ' ) = ' . $rgb);
    push @{ $colors_seen->{ $rgb } }, $color;
}

for my $rgb ( keys %$colors_seen ) {
    my $color_new = rgb2color( $rgb );
    ok( ( grep { $color_new == $_ } @{ $colors_seen->{$rgb} } ),
        'rgb2color( ' . $rgb . ' ) = ' . $color_new);
}

for my $color ( qw( -2 -1 256 257 foo ) ) {
    dies_ok { color2rgb($color) } 'color2rgb catches invalid colors';
}

done_testing();
