package WebService::ImKayac::Simple;
use 5.008005;
use strict;
use warnings;
use Carp;
use Digest::SHA1 qw/sha1_hex/;
use Furl;
use JSON ();

use constant IM_KAYAC_BASE_URL => 'http://im.kayac.com/api/post/';

our $VERSION = "0.01";

sub new {
    my ($class, %arg) = @_;

    my $user = $arg{user};
    croak "[ERROR] User name is required" unless $user;

    my $password = '';
    my $type = $arg{type};
    if ($type) {
        if ($type !~ /(?:password|secret)/) {
            croak "[ERROR] Invalid type: $type (type must be 'password' or 'secret')";
        }

        $password = $arg{password};
        croak "[ERROR] Password is required" unless $password;
    }

    bless {
        user     => $user,
        password => $password,
        type     => $type,
        furl     => Furl->new(
            agent   => 'WebService::ImKayac::Simple (Perl)',
            timeout => 10,
        ),
    }, $class;
}

sub send {
    my ($self, $message, $handler) = @_;

    croak "[ERROR] Message is required" unless $message;
    my $param = {message => $message};

    if (my $type = $self->{type}) {
        if ($type eq 'password') {
            $param->{password} = $self->{password};
        }
        elsif ($type eq 'secret') {
            $param->{sig} = sha1_hex($message . $self->{password});
        }
    }

    if ($handler) {
        $param->{handler} = $handler;
    }

    my $res = $self->{furl}->post(
        IM_KAYAC_BASE_URL . $self->{user},
        ["Content-Type" => "application/x-www-form-urlencoded"],
        $param,
    );

    my $json = JSON::decode_json($res->{content});
    if (my $error = $json->{error}) {
        croak "[ERROR] $error";
    }
}

1;
__END__

=encoding utf-8

=head1 NAME

WebService::ImKayac::Simple - It's new $module

=head1 SYNOPSIS

    use WebService::ImKayac::Simple;

=head1 DESCRIPTION

WebService::ImKayac::Simple is ...

=head1 LICENSE

Copyright (C) moznion.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

moznion E<lt>moznion@gmail.comE<gt>

=cut

