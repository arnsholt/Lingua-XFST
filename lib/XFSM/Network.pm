package XFSM::Network;

use strict;
use warnings;

use Carp;

use XFSM::Privates qw//;

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
        $self->{net} = XFSM::Privates::load_net($args{file}, $XFSM::context);
    }

    $self->{side} = $args{side};

    $self->{apply} = XFSM::Privates::init_apply($self->{net}, $self->{side}, $XFSM::context);
    $self->{apply}{eol_string} = $separator;

    return bless $self => $package;
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

__END__

=head1 NAME

XFSM::Network - Perl interface to XFSM networks


=head1 VERSION

This document describes XFSM version 0.0.1


=head1 SYNOPSIS

    use XFSM;

    my $net = XFSM::Network->new(file => $filename); # Load network in file $filename
    my $strings = $net->apply_up($string);           # Strings from applying up
    my $strings = $net->apply_down($string);         # Strings from applying down


=head1 DESCRIPTION

=over 4

=item new

    my $net = XFSM::Network->new(file => $filename);

Loads a network from the file specified in $filename and creates an applyer
instance bound to that network.

=item apply_up

    $net->apply_up($string);

Takes $string and applies the network to it in the upward direction. Returns a
reference to an array containing the resulting strings.

=item apply_down

    $net->apply_down($string);

Takes $string and applies the network to it in the downward direction. Returns
a reference to an array containing the resulting strings.

=back


=head1 BUGS & LIMITATIONS

No known bugs yet. The biggest limitation is the sheer lack of functionality.


=head1 AUTHOR

Arne SkjE<aelig>rholt C<< <arnsholt@gmail.com> >>
