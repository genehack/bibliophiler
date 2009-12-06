package Bibliophiler::Controller::Register;

use Moose;
BEGIN { extends 'Catalyst::Controller' }

use Bibliophiler::Form::Register;

has 'form' => (
  isa     => 'Bibliophiler::Form::Register' ,
  is      => 'rw' ,
  lazy    => 1 ,
  default => sub { Bibliophiler::Form::Register-> new } ,
);

sub index :Path {
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

  $c->stash->{username} = $form->values->{username};
  $c->stash->{message}  = 'Account created. Please log in.';

  $c->forward( 'Bibliophiler::Controller::Root' , 'index' );
}

1;
