package Bibliophiler::Form::Register;

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Model::DBIC';
### FIXME replace this with custom
with 'HTML::FormHandler::Render::Table';

has '+item_class' => ( default => 'Users' );

has_field 'username' => (
  type      => 'Text'     ,
  label     => 'Username' ,
  required  => 1          ,
  unique    => 1          ,
);

has_field 'email' => (
  type      =>  'Email'         ,
  label     =>  'Email Address' ,
  required  => 1                ,
  unique    => 1                ,
);

has_field 'email2' => (
  type      => 'Text'          ,
  label     => 'Confirm Email' ,
  required  => 1               ,
);

has_field 'password' => (
  type      => 'Password' ,
  label     => 'Password' ,
  required  => 1          ,
);

has_field 'password2' => (
  type     => 'PasswordConf'     ,
  label    => 'Confirm Password' ,
  required => 1                  ,
);

has_field 'submit' => (
  type  => 'Submit'         ,
  value => 'Create Account' ,
);

sub validate {
  my $self = shift;

  $self->field( 'email' )->add_error( 'Emails must match' )
    if ( $self->field( 'email' )->value ne $self->field( 'email2' )->value );
}

use namespace::autoclean;
1;
