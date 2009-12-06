package Bibliophiler::Controller::Root;

use strict;
use warnings;
use 5.010;

use parent 'Catalyst::Controller';

__PACKAGE__->config->{namespace} = '';

sub index :Path :Args(0) {
  my ( $self, $c ) = @_;

  $c->stash->{readings} = [ $c->model( 'DB::Readings' )->search(
    undef , { order_by => { -desc => 'finish' } }
  )->all ];

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

1;
