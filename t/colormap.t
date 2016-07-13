#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;
use Test::Exception;
use Capture::Tiny ':all';

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

# Colorbar Tests
my $rainbow = colormap( 'rainbow' );
ok( scalar @$rainbow, 'Colormap rainbow');
my $colorbar_output = capture_merged {
    colorbar($rainbow);
};

chomp($colorbar_output);
my $output_normalized = join('|',split //, $colorbar_output);
# ASCII Escape Sequences
my $expected = '|[|4|8|;|5|;|1|m| | ||[|0|m||[|4|8|;|5|;|1|9|6|m| | ||[|0|m||[|4|8|;|5|;|2|0|2|m| | ||[|0|m||[|4|8|;|5|;|2|0|8|m| | ||[|0|m||[|4|8|;|5|;|2|1|4|m| | ||[|0|m||[|4|8|;|5|;|2|2|0|m| | ||[|0|m||[|4|8|;|5|;|2|2|6|m| | ||[|0|m||[|4|8|;|5|;|1|1|m| | ||[|0|m||[|4|8|;|5|;|1|9|0|m| | ||[|0|m||[|4|8|;|5|;|1|5|4|m| | ||[|0|m||[|4|8|;|5|;|1|1|8|m| | ||[|0|m||[|4|8|;|5|;|8|2|m| | ||[|0|m||[|4|8|;|5|;|4|6|m| | ||[|0|m||[|4|8|;|5|;|1|0|m| | ||[|0|m||[|4|8|;|5|;|4|7|m| | ||[|0|m||[|4|8|;|5|;|4|8|m| | ||[|0|m||[|4|8|;|5|;|4|9|m| | ||[|0|m||[|4|8|;|5|;|5|0|m| | ||[|0|m||[|4|8|;|5|;|5|1|m| | ||[|0|m||[|4|8|;|5|;|1|4|m| | ||[|0|m||[|4|8|;|5|;|4|5|m| | ||[|0|m||[|4|8|;|5|;|3|9|m| | ||[|0|m||[|4|8|;|5|;|3|3|m| | ||[|0|m||[|4|8|;|5|;|2|7|m| | ||[|0|m||[|4|8|;|5|;|2|1|m| | ||[|0|m||[|4|8|;|5|;|1|2|m| | ||[|0|m||[|4|8|;|5|;|5|7|m| | ||[|0|m||[|4|8|;|5|;|9|3|m| | ||[|0|m||[|4|8|;|5|;|1|2|9|m| | ||[|0|m||[|4|8|;|5|;|1|6|5|m| | ||[|0|m||[|4|8|;|5|;|2|0|1|m| | ||[|0|m||[|4|8|;|5|;|5|m| | ||[|0|m';
ok($output_normalized eq $expected, "Rainbow is $colorbar_output")
    or diag( "Got \n$output_normalized\n, but expected \n$expected\n");

# Color Table Tests

my $colortable_output = capture_merged {
    color_table('rainbow');
};

my $color_table_normalized = join('|',split //, $colorbar_output);

my $expected_color_table = '|[|4|8|;|5|;|1|m| | ||[|0|m||[|4|8|;|5|;|1|9|6|m| | ||[|0|m||[|4|8|;|5|;|2|0|2|m| | ||[|0|m||[|4|8|;|5|;|2|0|8|m| | ||[|0|m||[|4|8|;|5|;|2|1|4|m| | ||[|0|m||[|4|8|;|5|;|2|2|0|m| | ||[|0|m||[|4|8|;|5|;|2|2|6|m| | ||[|0|m||[|4|8|;|5|;|1|1|m| | ||[|0|m||[|4|8|;|5|;|1|9|0|m| | ||[|0|m||[|4|8|;|5|;|1|5|4|m| | ||[|0|m||[|4|8|;|5|;|1|1|8|m| | ||[|0|m||[|4|8|;|5|;|8|2|m| | ||[|0|m||[|4|8|;|5|;|4|6|m| | ||[|0|m||[|4|8|;|5|;|1|0|m| | ||[|0|m||[|4|8|;|5|;|4|7|m| | ||[|0|m||[|4|8|;|5|;|4|8|m| | ||[|0|m||[|4|8|;|5|;|4|9|m| | ||[|0|m||[|4|8|;|5|;|5|0|m| | ||[|0|m||[|4|8|;|5|;|5|1|m| | ||[|0|m||[|4|8|;|5|;|1|4|m| | ||[|0|m||[|4|8|;|5|;|4|5|m| | ||[|0|m||[|4|8|;|5|;|3|9|m| | ||[|0|m||[|4|8|;|5|;|3|3|m| | ||[|0|m||[|4|8|;|5|;|2|7|m| | ||[|0|m||[|4|8|;|5|;|2|1|m| | ||[|0|m||[|4|8|;|5|;|1|2|m| | ||[|0|m||[|4|8|;|5|;|5|7|m| | ||[|0|m||[|4|8|;|5|;|9|3|m| | ||[|0|m||[|4|8|;|5|;|1|2|9|m| | ||[|0|m||[|4|8|;|5|;|1|6|5|m| | ||[|0|m||[|4|8|;|5|;|2|0|1|m| | ||[|0|m||[|4|8|;|5|;|5|m| | ||[|0|m';
ok($color_table_normalized eq $expected_color_table, "Rainbow table is \n$colortable_output")
    or diag( "Got \n$output_normalized\n, but expected \n$expected_color_table\n");

done_testing();
