package Lingua::XFSM;

use strict;
use warnings;

use Lingua::XFSM::Network;
use Lingua::XFSM::Privates qw//;

our $VERSION = '0.0.1';

our $context;

BEGIN {
    $context = Lingua::XFSM::Privates::initialize_cfsm();
    # Turn off verbose mode.
    $context->{interface}{general}{verbose} = 0;
}

END {
    Lingua::XFSM::Privates::reclaim_cfsm($context);
}

1;

__END__

=head1 NAME

Lingua::XFSM - Perl bindings for the Xerox FSM libraries


=head1 VERSION

This document describes Lingua::XFSM version 0.0.1


=head1 SYNOPSIS

    use Lingua::XFSM;

    my $net = Lingua::XFSM::Network->new(file => $filename); # Load network in file $filename
    my $strings = $net->apply_up($string);           # Strings from applying up
    my $strings = $net->apply_down($string);         # Strings from applying down


=head1 DESCRIPTION

This module wraps the XFSM C library and provides a Perl object interface to
it. Currently only the bare minimum of functionality is provided, but more is
coming. The only interface supported is the network class, which can be
applied to strings in both directions.

For detailed documentation of the network class, see L<Lingua::XFSM::Network>.
The brave (and/or desperate) seeking more functionality can access the
SWIG-generated interface via L<Lingua::XFSM::Privates>; see that file for
details.


=head1 BUGS & LIMITATIONS

No known bugs yet. The biggest limitation is the sheer lack of functionality.


=head1 SEE ALSO

L<Lingua::XFSM::Network>, L<Lingua::XFSM::Privates>


=head1 AUTHOR

Arne SkjE<aelig>rholt C<< <arnsholt@gmail.com> >>
