#!perl

use strict;
use warnings;
use WebService::ImKayac::Simple;

use Test::More;

my $user     = $ENV{IMKAYAC_PASSWORD_USER};
my $password = $ENV{IMKAYAC_PASSWORD};
plan skip_all => "IMKAYAC_PASSWORD_USER or IMKAYAC_PASSWORD is not given." if !$user || !$password;

my $im = WebService::ImKayac::Simple->new(
    type     => 'password',
    user     => $user,
    password => $password,
);

eval { $im->send("Hello!") };
ok !$@;

done_testing;

