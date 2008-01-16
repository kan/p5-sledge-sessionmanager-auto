package Sledge::SessionManager::Auto;

use strict;
use warnings;
use base 'Sledge::SessionManager';
our $VERSION = '0.01';

use Sledge::SessionManager::Cookie;
use Sledge::SessionManager::StickyQuery;
use HTTP::MobileAgent;

sub import {
    my $class = shift;
    my $pkg   = caller(0);
    no strict 'refs';
    *{"$pkg\::redirect"} = sub {
        my $self = shift;

        my $meth =
          $self->mobile_agent->is_non_mobile
          ? 'Sledge::Pages::Base::redirect'
          : 'Sledge::SessionManager::StickyQuery::redirect_filter';

        $meth->(@_);
    };
}

sub new {
    my ( $class, $page ) = @_;

    my $klass =
      $page->mobile_agent->is_non_mobile
      ? 'Sledge::SessionManager::Cookie'
      : 'Sledge::SessionManager::StickyQuery';

    my $self = $klass->new($page);
    return $self;
}

1;
__END__

=head1 NAME

Sledge::SessionManager::Auto -

=head1 SYNOPSIS

  use Sledge::SessionManager::Auto;

=head1 DESCRIPTION

Sledge::SessionManager::Auto is

=head1 AUTHOR

KAN Fushihara E<lt>kan at mobilefactory dot jpE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
