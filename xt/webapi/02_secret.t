#!perl

use strict;
use warnings;
use WebService::ImKayac::Simple;

use Test::More;

my $user     = $ENV{IMKAYAC_SECRET_USER};
my $password = $ENV{IMKAYAC_SECRET};
plan skip_all => "IMKAYAC_SECRET_USER or IMKAYAC_SECRET is not given." if !$user || !$password;

my $im = WebService::ImKayac::Simple->new(
    type     => 'secret',
    user     => $user,
    password => $password,
);

eval { $im->send("Hello!") };
ok !$@;

done_testing;

