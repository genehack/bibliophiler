package Bibliophiler::Controller::Book;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Bibliophiler::Controller::Book

=cut

sub add :Path {
  my( $self , $c ) = @_;

  $c->stash->{template} = 'book/add.tt';

  if ( $c->request->method eq 'POST' ) {

  }
}

1;
