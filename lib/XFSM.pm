package XFSM;

use strict;
use warnings;

use XFSM::Privates qw//;

our $VERSION = '0.0.1';

my $context;

BEGIN {
    $context = XFSM::Privates::initialize_cfsm();
    # Turn of verbose mode.
    $context->{interface}{general}{verbose} = 0;
}

END {
    XFSM::Privates::reclaim_cfsm($context);
}

package XFSM::Network;

use Carp;

my $separator;
my $splitter;
BEGIN {
    $separator = pack("U[30]", map {int(rand(26)) + ord('A')} 1 .. 30);
    $splitter = qr/\Q$separator\E/o;
}

sub new {
    my $package = shift;
    $package = ref $package if ref $package;
    my %args = (@_,
        side => XFSM::Privates::UPPER
    );

    croak qq{Can't create $package from both file and string}
        if exists $args{file} and exists $args{string};

    # TODO: Handle multiple nets in a file, creating net from string.
    my $self = {};
    if(exists $args{file}) {
        $self->{net} = XFSM::Privates::load_net($args{file}, $context);
    }

    $self->{side} = $args{side};

    $self->{apply} = XFSM::Privates::init_apply($self->{net}, $self->{side}, $context);
    $self->{apply}{eol_string} = $separator;

    return bless $self => $package;
}

sub apply {
    my ($self, $string, %args) = @_;
}

sub apply_down {
    my ($self, $string) = @_;

    if($self->{side} != XFSM::Privates::UPPER) {
        XFSM::Privates::switch_input_side($self->{apply});
        $self->{side} = XFSM::Privates::UPPER;
    }

    return $self->_do_apply($string);
}

sub apply_up {
    my ($self, $string) = @_;

    if($self->{side} != XFSM::Privates::LOWER) {
        XFSM::Privates::switch_input_side($self->{apply});
        $self->{side} = XFSM::Privates::LOWER;
    }

    return $self->_do_apply($string);
}

sub _do_apply {
    my ($self, $string) = @_;

    my $output = XFSM::Privates::apply_to_string($string, $self->{apply});
    return [split m/$splitter/o, $output];
}

# XXX: Looks like this doesn't free all the memory. Need to figure out how to
# fix that.
sub DESTROY {
    my ($self) = @_;

    XFSM::Privates::free_network($self->{net});
    XFSM::Privates::free_applyer($self->{applyer});
}

1;
