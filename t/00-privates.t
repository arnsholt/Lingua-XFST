use XFSM::Privates;
use feature qw/say/;

use Test::Simple tests => 1;

# TODO: Can probably do more thorough checking of internals.
my $ctx = XFSM::Privates::initialize_cfsm();
ok $ctx, "creating context";
