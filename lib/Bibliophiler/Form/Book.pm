package Bibliophiler::Form::Book;

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Model::DBIC';
### FIXME replace this with custom
with 'HTML::FormHandler::Render::Table';

has '+item_class' => ( default => 'Books' );

# legend: add a book

# default_args:
# elements:
# Text:
# size: 50
# Submit:
# retain_default: 1
# force_default: 0

has_field 'title' => (
  type      => 'Text'     ,
  label     => 'Book title' ,
  required  => 1          ,
);

has_field 'authors' => (
  type      =>  'Text'         ,
  label     =>  'Book author(s)' ,
  required  => 1                ,
);

has_field 'pages' => (
  type      => 'Number'          ,
  label     => 'Page count' ,
);

has_field 'isbn' => (
  type      => 'Text' ,
  label     => 'ISBN' ,
);

has_field 'tags' => (
  type     => 'Text'     ,
  label    => 'Tags' ,
  required => 1                  ,
);

has_field 'read_now' => (
  type  => 'Submit'         ,
  value => 'Read Now' ,
);

has_field 'read_later' => (
  type  => 'Submit'         ,
  value => 'Read Later' ,
);

sub validate {
  my $self = shift;

  $self->field( 'email' )->add_error( 'Emails must match' )
    if ( $self->field( 'email' )->value ne $self->field( 'email2' )->value );
}

use namespace::autoclean;
1;
