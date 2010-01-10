package Bibliophiler::Controller::Root;

use Moose;
use namespace::autoclean;
BEGIN { extends 'Catalyst::Controller::ActionRole' }

__PACKAGE__->config->{namespace} = '';

sub index :Path :Args(0) {
  my ( $self, $c ) = @_;

  $c->stash->{readings} = [ $c->model( 'DB::Readings' )->search(
    undef , { order_by => { -desc => 'finish' } }
  )->all ];

  $c->stash->{template} = 'index.tt';
}

sub default :Path {
  my ( $self, $c ) = @_;

  $c->response->body( 'Page not found' );
  $c->response->status(404);
}

sub hello :Local Does('NeedsLogin') {
  my( $self , $c ) = @_;

  my $username = $c->user->username;

  $c->response->body( "<h2>hello $username</h2>" );
}

sub end : ActionClass('RenderView') {}

1;
