[![Build Status](https://travis-ci.org/moznion/WebService-ImKayac-Simple.png?branch=master)](https://travis-ci.org/moznion/WebService-ImKayac-Simple)
# NAME

WebService::ImKayac::Simple - Simple message sender for im.kayac

# SYNOPSIS

    use WebService::ImKayac::Simple;

    my $im = WebService::ImKayac::Simple->new(
        type     => 'password',
        user     => '__USER_NAME__',
        password => '__PASSWORD__',
    );

    $im->send('Hello!');

# DESCRIPTION

WebService::ImKayac::Simple is the simple message sender for im.kayac.

# METHODS

- WWW::NHKProgram::API->new()

    Constructor. You can specify `user`, `password` and `type` through this method.

    Essential arguments are changed according to the `type`.

    With no authentication:

        my $im = WebService::ImKayac::Simple->new(
            user => '__USER_NAME__',
        );

    With password authentication:

        my $im = WebService::ImKayac::Simple->new(
            type     => 'password',
            user     => '__USER_NAME__',
            password => '__PASSWORD__',
        );

    With secret key authentication:

        my $im = WebService::ImKayac::Simple->new(
            type     => 'secret',
            user     => '__USER_NAME__',
            password => '__SECRET_KEY__',
        );

- $im->send($message, $handler)

    Send message.

    `$message` is required. It must be utf-8 string.

    `handler` is optional. Please refer [http://im.kayac.com/#docs](http://im.kayac.com/#docs) if you wanna get details.

# FOR DEVELOPERS

Tests which are calling web API directly in `xt/webapi`. If you want to run these tests, please execute like so;

    $ IM_KAYAC_NONE_USER=__USER_NAME__ prove xt/webapi/00_none.t

# LICENSE

Copyright (C) moznion.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

moznion <moznion@gmail.com>
