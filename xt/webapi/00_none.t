#!perl

use strict;
use warnings;
use WebService::ImKayac::Simple;

use Test::More;

my $user = $ENV{IM_KAYAC_NONE_USER};
plan skip_all => "IM_KAYAC_NONE_USER is not given." unless $user;

my $im = WebService::ImKayac::Simple->new(
    user => $user,
);

eval { $im->send("Hello!") };
ok !$@;

done_testing;

