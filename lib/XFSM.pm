package XFSM;

use strict;
use warnings;

use XFSM::Network;
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

1;

__END__

=head1 NAME

XFSM - Perl bindings for the Xerox FSM libraries


=head1 VERSION

This document describes XFSM version 0.0.1


=head1 SYNOPSIS

    use XFSM;

    my $net = XFSM::Network->new(file => $filename); # Load network in file $filename
    my $strings = $net->apply_up($string);           # Strings from applying up
    my $strings = $net->apply_down($string);         # Strings from applying down


=head1 DESCRIPTION

This module wraps the XFSM C library and provides a Perl object interface to
it. Currently only the bare minimum of functionality is provided, but more is
coming. The only interface supported is the network class, which can be
applied to strings in both directions.

For detailed documentation of the network class, see L<XFSM::Network>. The
brave (and/or desperate) seeking more functionality can access the
SWIG-generated interface via L<XFSM::Privates>; see that file for details.


=head1 BUGS & LIMITATIONS

No known bugs yet. The biggest limitation is the sheer lack of functionality.


=head1 SEE ALSO

L<XFSM::Network>, L<XFSM::Privates>


=head1 AUTHOR

Arne SkjE<aelig>rholt C<< <arnsholt@gmail.com> >>
