package Bibliophiler::Schema::Result::AuthorBooks;

use strict;
use warnings;
use 5.010;

use base 'DBIx::Class';

__PACKAGE__->load_components(
  'InflateColumn::DateTime' ,
  'TimeStamp'               ,
  'Core'                    ,
);

__PACKAGE__->table( 'author_books' );

__PACKAGE__->add_columns(
  'author_id' => { data_type => 'INTEGER' } ,
  'book_id'   => { data_type => 'INTEGER' } ,
);

__PACKAGE__->set_primary_key( 'author_id' , 'book_id' );

__PACKAGE__->belongs_to(
  'author' => 'Bibliophiler::Schema::Result::Authors' ,
  { 'foreign.id' => 'self.author_id' } ,
);

__PACKAGE__->belongs_to(
  'book' => 'Bibliophiler::Schema::Result::Books' ,
  { 'foreign.id' => 'self.book_id' } ,
);

1;
