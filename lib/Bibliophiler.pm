package Bibliophiler;

use strict;
use warnings;
use 5.010;

use Catalyst::Runtime 5.80;

use parent 'Catalyst';

use Catalyst qw/
                 -Debug
                 ConfigLoader
                 Static::Simple

                 +CatalystX::SimpleLogin

                 Authentication
                 Authorization::Roles
                 Session
                 Session::State::Cookie
                 Session::Store::FastMmap
               /;

our $VERSION = '0.01';

__PACKAGE__->config(
  name => 'Bibliophiler' ,
  'View::TT' => {
    INCLUDE_PATH => [
      __PACKAGE__->path_to( 'templates' ) ,
      __PACKAGE__->path_to( 'root'      ) ,
    ] ,
    TEMPLATE_EXTENSION => '.tt' ,
    CATALYST_VAR       => 'c' ,
    TIMER              => 0 ,
    WRAPPER            => 'wrapper.tt' ,
  } ,
  'Plugin::Authentication' => {
    default => {
      credential => {
        class                    => 'Password' ,
        password_field           => 'password' ,
        password_type            => 'hashed'   ,
        password_hash_type        => 'SHA-1'    ,
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
  'Controller::Login' => {
    traits => [ 'Logout' , 'WithRedirect' ] ,
  } ,
  'Plugin::Session' => {
    flash_to_stash => 1 ,
  } ,
);

__PACKAGE__->setup();

1;

__END__

=head1 NAME

Bibliophiler - Read, track, enjoy.

=head1 SYNOPSIS

    script/bibliophiler_server.pl

=head1 DESCRIPTION

DB-backed web app to track books you've read.

=head1 SEE ALSO

L<Bibliophiler::Controller::Root>, L<Catalyst>

=head1 AUTHOR

John SJ Anderson C<<genehack@genehack.org>>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.
