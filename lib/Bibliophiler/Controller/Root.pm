package Bibliophiler::Controller::Root;

use strict;
use warnings;
use parent 'Catalyst::Controller';

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config->{namespace} = '';

=head1 NAME

Bibliophiler::Controller::Root - Root Controller for Bibliophiler

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=cut

=head2 index

=cut

sub index :Path :Args(0) {
  my ( $self, $c ) = @_;

  $c->stash->{template} = 'index.tt';

}

sub login :Local {
  my( $self , $c ) = @_;

  if ( $c->request->method eq 'POST' ) {
    $c->authenticate( $c->request->body_params );
  }

  $c->response->redirect( $c->uri_for( '/' ));
}

sub logout :Local {
  my( $self , $c ) = @_;

  $c->logout();
  $c->stash->{message} = 'You have been logged out.';
  $c->forward( 'index' );
}

sub default :Path {
  my ( $self, $c ) = @_;
  $c->response->body( 'Page not found' );
  $c->response->status(404);
}

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

John SJ Anderson

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
