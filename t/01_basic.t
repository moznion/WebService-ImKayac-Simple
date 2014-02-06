#!perl

use strict;
use warnings;
use utf8;
use WebService::ImKayac::Simple;

use Test::More;

subtest 'on new()' => sub {
    eval { WebService::ImKayac::Simple->new() };
    ok $@, "Dies when user name doesn't exist";

    eval {
        WebService::ImKayac::Simple(
            user => 'foo',
            type => 'bar',
        );
    };
    ok $@, "Dies when invalid type is given";

    subtest "Dies when password doesn't exist" => sub {
        eval {
            WebService::ImKayac::Simple(
                user => 'foo',
                type => 'password',
            );
        };
        ok $@, "Type is 'password'";

        eval {
            WebService::ImKayac::Simple(
                user => 'foo',
                type => 'secret',
            );
        };
        ok $@, "Type is 'secret'";
    };
};

subtest 'on send()' => sub {
    my $im = WebService::ImKayac::Simple->new(user => 'foo');
    eval { $im->send() };
    ok $@, "Message doesn't exist";
};

done_testing;
