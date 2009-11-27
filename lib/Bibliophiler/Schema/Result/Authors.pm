package Bibliophiler::Schema::Result::Authors;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components( 'InflateColumn::DateTime' , 'TimeStamp' , 'Core' );
__PACKAGE__->table( 'authors' );

__PACKAGE__->add_columns(
  'id'    => { data_type => 'INTEGER' , is_nullable => 0 , size => undef , is_auto_increment => 1 } ,
  'lname' => { data_type => 'VARCHAR' , is_nullable => 0 , size => 255   } ,
  'fname' => { data_type => 'VARCHAR' , is_nullable => 0 , size => 255   } ,
);

__PACKAGE__->set_primary_key( 'id' );
__PACKAGE__->add_unique_constraint( 'name_unique' , [ 'lname' , 'fname' ] );

__PACKAGE__->has_many(
  'author_books' ,
  'Bibliophiler::Schema::Result::AuthorBooks' ,
  { 'foreign.author_id' => 'self.id' } ,
);

__PACKAGE__->many_to_many(
  'books' , 'author_books' , 'book'
);

sub name {
  my( $self ) = @_;
  return $self->fname . ' ' . $self->lname;
}

1;

