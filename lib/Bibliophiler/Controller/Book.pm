package Bibliophiler::Controller::Book;

use Moose;
BEGIN { extends 'Catalyst::Controller' }

use Bibliophiler::Form::Book;

has 'form' => (
  isa     => 'Bibliophiler::Form::Book' ,
  is      => 'rw' ,
  lazy    => 1 ,
  default => sub { Bibliophiler::Form::Book->new } ,
);

sub root :Chained('/') PathPart('book') CaptureArgs(0) {
  my( $self , $c ) = @_;

  $c->stash->{model} = $c->model( 'DB::Books' );
}

sub base :Chained('root') PathPart('') CaptureArgs(1) {
  my( $self , $c , $id ) = @_;

  $c->stash->{id} = $id;

}

sub view :Chained('base') PathPart('') Args(0) {
  my( $self , $c ) = @_;

  my $id = $c->stash->{id};

  $c->response->body( "View page for ID $id" );
}

sub edit :Chained('base') PathPart('edit') Args(0) {
  my( $self , $c ) = @_;

  my $id = $c->stash->{id};

  $c->response->body( "Edit page for ID $id" );
}

sub start_reading :Chained('base') PathPart('start') Args(0) {
  my( $self , $c ) = @_;

  my $id = $c->stash->{id};

  $c->response->body( "start reading ID $id" );
}

sub view_all :Chained('root') PathPart('') Args(0) {
  my( $self , $c ) = @_;

  $c->response->body( "View all books" );
}

sub add :Local {
  my( $self , $c ) = @_;

  $c->stash(
    form     => $self->form         ,
    template => 'register/index.tt' ,
  );

  my $form = $self->form;

  return unless $form->process(
    params => $c->request->parameters ,
    schema => $c->model( 'DB' )->schema ,
  );
}

1;
