package Mock::Pages;
use strict;
use warnings;
use Test::More;
BEGIN {
    eval q[use base qw(Sledge::TestPages)];
    plan skip_all => "Sledge::TestPages required for testing base" if $@;
};

use Sledge::SessionManager::Auto;

sub create_session_manager { Sledge::SessionManager::Auto->new }

sub dispatch_test {
    my $self = shift;

    is $self->session->id, 'SIDSIDSIDSID';
}

1;

package main;
my $x;
$x = $Mock::Pages::TMPL_PATH = 't/';
$x = $Mock::Pages::COOKIE_NAME = 'sid';
$ENV{HTTP_COOKIE} = 'seid=SIDSIDSIDSID';
$ENV{REQUEST_METHOD} = 'GET';
$ENV{QUERY_STRING} = 'sid=bar';

my $page = Mock::Pages->new;
$page->dispatch('test');

1;
