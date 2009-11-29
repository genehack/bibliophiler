package Bibliophiler;

use strict;
use warnings;

use Catalyst::Runtime 5.80;

# Set flags and add plugins for the application
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use parent qw/Catalyst/;
use Catalyst qw/
                 -Debug
                 ConfigLoader
                 Static::Simple

                 Authentication
                 Authorization::Roles
                 Session
                 Session::State::Cookie
                 Session::Store::FastMmap
/;
our $VERSION = '0.01';

# Configure the application.
#
# Note that settings in bibliophiler.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config(
  name => 'Bibliophiler' ,
  'View::TT' => {
    INCLUDE_PATH => [
      __PACKAGE__->path_to( 'inc'  ) ,
      __PACKAGE__->path_to( 'root' ) ,
    ] ,
    TEMPLATE_EXTENSION => '.tt' ,
    CATALYST_VAR       => 'c' ,
    TIMER              => 0 ,
    WRAPPER            => 'wrapper.tt' ,
  } ,
  'Plugin::Authentication' => {
    default => {
      credential => {
        class              => 'Password' ,
        password_field     => 'password' ,
        password_type      => 'hashed'   ,
        password_hash_type => 'SHA-1'    ,
      } ,
      store => {
        class                     => 'DBIx::Class' ,
        user_model                => 'DB::Users' ,
        role_relation             => 'roles' ,
        role_field                => 'role' ,
        use_userdata_from_session => 0 ,
      } ,
    } ,
  } ,
);

# Start the application
__PACKAGE__->setup();


=head1 NAME

Bibliophiler - Catalyst based application

=head1 SYNOPSIS

    script/bibliophiler_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<Bibliophiler::Controller::Root>, L<Catalyst>

=head1 AUTHOR

John SJ Anderson

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
