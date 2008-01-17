use strict;
use warnings;
use Test::Base;
BEGIN {
    eval q[use Sledge::TestPages;];
    plan skip_all => "Sledge::TestPages required for testing base" if $@;
};
use t::TestPages;

plan tests => 2;

run {
    my $block = shift;

    $ENV{HTTP_USER_AGENT} = $block->input;

    no strict 'refs';
    local *{"t::TestPages::dispatch_test"} = sub {}; ## no critic

    my $pages = t::TestPages->new;
    $pages->dispatch('test');

    ok($pages->output =~ /@{[ $block->expected]}/, $pages->output);
};

__END__
=== agent is pc (use cookie)
--- input chomp
Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1)
--- expected chomp
<a href="/foo">bar</a>
=== agent is mobile (use query)
--- input chomp
KDDI-HI31 UP.Browser/6.2.0.5 (GUI) MMP/2.0
--- expected chomp
<a href="/foo\?sid=(.+)">bar</a>
