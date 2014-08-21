perl-term-colormap
==================

ANSITerm 256 colormaps

Name
-----
Term::Colormap - Colormaps for ANSI 256 Color Terminals!

Version
---------
Version 0.06

Synopsis
-----------
Perl library providing colormaps and functions to simplify rendering colored text using ANSI 256 colors.

    use Term::Colormap qw( colormap colorbar print_colored );

    my $rainbow = colormap('rainbow');

    colorbar($rainbow);

    print_colored( $rainbow->[3], "orange" )';

Example Scripts
------------------
[git-blame-summary](https://github.com/xxfelixxx/perl-term-colormap/blob/master/bin/git_blame_summary) - Summarize git commits

    $ git clone git://perl5.git.perl.org/perl.git
    $ cd perl
    $ git-blame-summary run.c

![alt text](https://raw.githubusercontent.com/xxfelixxx/perl-term-colormap/master/images/git_blame_summary_on_perl_run.c.png "git-blame-summary")

[hbar](https://github.com/xxfelixxx/perl-term-colormap/blob/master/bin/hbar) - Create horizontal bar graphs from the command line

    $ echo '
      hello,-5
      world,-4
      bob,-3
      cat,-2
      foo,-1
      bar,0
      qux,1
      qix,5
      baz,20
    ' | hbar

![alt text](https://raw.githubusercontent.com/xxfelixxx/perl-term-colormap/master/images/hbar_hello_world.png "hbar hello world")

    $ echo '
      1  one
      1  one
      2  two
      5  five
      8  eight
      13 thirteen
      21 twenty one
     ' | hbar

![alt text](https://raw.githubusercontent.com/xxfelixxx/perl-term-colormap/master/images/hbar_fibonacci.png "hbar fibonacci")

Available Colormaps
-------------------------

![alt text](https://raw.githubusercontent.com/xxfelixxx/perl-term-colormap/master/images/color_table_rainbow.png "rainbow")

![alt text](https://raw.githubusercontent.com/xxfelixxx/perl-term-colormap/master/images/color_table_primary.png "primary")

![alt text](https://raw.githubusercontent.com/xxfelixxx/perl-term-colormap/master/images/color_table_bright.png "bright")

![alt text](https://raw.githubusercontent.com/xxfelixxx/perl-term-colormap/master/images/color_table_gray.png "gray")
