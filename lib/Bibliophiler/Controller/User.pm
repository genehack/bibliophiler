package Bibliophiler::Controller::User;

use strict;
use warnings;
use 5.010;

use parent 'Catalyst::Controller';

sub index :Path {
  my( $self , $c , $id , $username ) = @_;

  $c->stash->{id}   = $id;
  $c->stash->{user} = $username;
}

1;
