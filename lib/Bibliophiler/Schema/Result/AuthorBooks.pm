package Bibliophiler::Schema::Result::AuthorBooks;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components( 'Core' );
__PACKAGE__->table( 'author_books' );

__PACKAGE__->add_columns(
  'author_id' => { data_type => 'INTEGER' , is_nullable => 0 , size => undef } ,
  'book_id'   => { data_type => 'INTEGER' , is_nullable => 0 , size => undef } ,
);

__PACKAGE__->set_primary_key( 'author_id' , 'book_id' );

__PACKAGE__->belongs_to(
  'author_id' ,
  'Bibliophiler::Schema::Result::Authors' ,
  { 'foreign.id' => 'self.author_id' } ,
);

__PACKAGE__->belongs_to(
  'book_id' ,
  'Bibliophiler::Schema::Result::Books' ,
  { 'foreign.id' => 'self.book_id' } ,
);

1;

