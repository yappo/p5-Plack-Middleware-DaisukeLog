#!/usr/bin/env perl
# run: PLACK_ENV=production plackup
use strict;
use warnings;
use lib 'lib';

use Plack::Builder;
use Plack::Middleware::DaisukeLog;


builder {
    enable 'StackTrace';
    enable 'DaisukeLog';

    sub {
        if (time % 3 == 0) {
            warn 'warninngs!!!!!!!!!!!!!!!!!!!';
            warn 'oooohhhhhhhhhhh, myyyyyyyyyy gaaaaaaaa!';
        }
        if (time % 5 == 0) {
            die 'jyurina';
        }

        [ 200, [], ['ok'] ];
    };
};

