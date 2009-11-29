package Bibliophiler::Controller::User;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Bibliophiler::Controller::User

=cut

sub index :Path {
  my( $self , $c , $id , $username ) = @_;

  $c->stash->{id} = $id;
  $c->stash->{user} = $username;

}

1;
