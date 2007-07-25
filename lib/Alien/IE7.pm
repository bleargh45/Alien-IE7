package Alien::IE7;

# Required inclusions.
use strict;
use warnings;
use Carp;
use File::Copy qw(copy);
use File::Path qw(mkpath);
use File::Find qw(find);
use File::Basename qw(dirname);

# Version number
our $VERSION = '0.9';

# Returns the IE7 version number.
sub version {
    return $VERSION;
}

# Returns the path to the available copy of IE7.
sub path {
    my $base = $INC{'Alien/IE7.pm'};
    $base =~ s{\.pm$}{};
    return $base;
}

# Installs the IE7 compatibility library into the given '$destdir'.
sub install {
    my ($class, $destdir) = @_;
    if (!-d $destdir) {
        mkpath( [$destdir] ) || croak "can't create '$destdir'; $!";
    }
    my $path = $class->path();

    # Install files...
    my @files = grep { -f $_ }
                    ( glob("$path/*.js"),
                      glob("$path/*.htc"),
                      glob("$path/*.gif"),
                    );
    foreach my $file (@files) {
        copy( $file, $destdir ) || croak "can't copy '$file' to '$destdir'; $!";
    }
}

1;

=head1 NAME

Alien::IE7 - installing and finding IE7 JS compatibility library

=head1 SYNOPSIS

  use Alien::IE7;
  ...
  $version = Alien::IE7->version();
  $path    = Alien::IE7->path();
  ...
  Alien::IE7->install( $my_destination_directory );

=head1 DESCRIPTION

Please see L<Alien> for the manifesto of the Alien namespace.

=head1 AUTHOR

Graham TerMarsch (cpan@howlingfrog.com)

=head1 LICENSE

Copyright (C) 2007, Graham TerMarsch.  All rights reserved.

This is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=head1 SEE ALSO

http://dean.edwards.name/ie7/
L<Alien>.

=cut
