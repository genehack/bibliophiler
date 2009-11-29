package Bibliophiler::Controller::Register;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Bibliophiler::Controller::Register - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
  my( $self , $c ) = @_;

  if ( $c->request->method eq 'POST' ) {
    my $params = $c->request->body_params;

    my $user;
    eval { $user = $c->model( 'DB' )->resultset( 'Users' )->create_new_user( %$params ) };
    if ( $@ ) {
      $c->stash->{message} = $@;
      $c->detach;
    }

    $c->stash->{username} = $user->username;
    $c->stash->{message}  = 'Account created. Please log in.';

    $c->forward( 'Bibliophiler::Controller::Root' , 'index' );
  }
}


=head1 AUTHOR

genehack

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
