package Plack::Middleware::DaisukeLog;
use strict;
use warnings;
use parent 'Plack::Middleware::AccessLog';
our $VERSION = '0.01';

sub call {
    my $self = shift;
    my($env) = @_;

    my @warns;
    local $SIG{__WARN__} = sub {
        push @warns, \@_;
    };
    my $die = $SIG{__DIE__} || sub { die @_ };
    local $SIG{__DIE__} = sub {
        my $logger = $self->logger || sub { $env->{'psgi.errors'}->print(@_) };
        $logger->( $self->log_line(500, [], $env,) );
        $logger->( "\t", @{ $_ } ) for @warns;
        $logger->( "\t", @_ );
        undef @warns;
        $die->(@_);
    };

    my $res = $self->app->($env);
    return $self->response_cb($res, sub {
        return unless @warns;
        my $res = shift;
        my $logger = $self->logger || sub { $env->{'psgi.errors'}->print(@_) };

        my $content_length = Plack::Util::content_length($res->[2]);
        $logger->( $self->log_line($res->[0], $res->[1], $env, { content_length => $content_length }) );
        $logger->( "\t", @{ $_ } ) for @warns;
        undef @warns;
    });
}

1;
__END__

=head1 NAME

Plack::Middleware::DaisukeLog - warn 出力があった時だけ、アクセスログと一緒に warn 出力だす君

=head1 SYNOPSIS

    use Plack::Middleware::DaisukeLog;

=head1 DESCRIPTION

Plack::Middleware::DaisukeLog is

=head1 AUTHOR

Kazuhiro Osawa E<lt>yappo {at} shibuya {dot} plE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
