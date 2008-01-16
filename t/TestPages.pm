package t::TestPages;
BEGIN {
    eval q{ use base qw(Sledge::TestPages); };
    die $@ if $@;
}

use Sledge::SessionManager::Auto;

sub create_session_manager { Sledge::SessionManager::Auto->new }

$t::TestPages::TMPL_PATH = 't/';
$t::TestPages::COOKIE_NAME = 'sid';
$ENV{HTTP_COOKIE} = 'seid=SIDSIDSIDSID';
$ENV{REQUEST_METHOD} = 'GET';
$ENV{QUERY_STRING} = 'sid=bar';

1;
