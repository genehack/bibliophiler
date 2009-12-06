package Bibliophiler::Schema::Result::Books;

use strict;
use warnings;
use 5.010;

use base 'DBIx::Class';

__PACKAGE__->load_components(
  'InflateColumn::DateTime' ,
  'TimeStamp'               ,
  'Core'                    ,
);

__PACKAGE__->table( 'books' );

__PACKAGE__->add_columns(
  'id'    => { data_type => 'INTEGER' , is_auto_increment => 1 } ,
  'title' => { data_type => 'VARCHAR' , size => 255 } ,
  'isbn'  => { data_type => 'VARCHAR' , size => 13 , is_nullable => 1 } ,
  'pages' => { data_type => 'INTEGER' , is_nullable => 1 } ,
);

__PACKAGE__->set_primary_key( 'id' );

#__PACKAGE__->add_unique_constraint([ 'isbn'  ]);

__PACKAGE__->has_many(
  'author_books' => 'Bibliophiler::Schema::Result::AuthorBooks' ,
  { 'foreign.book_id' => 'self.id' } ,
);

__PACKAGE__->many_to_many( 'authors' , 'author_books' , 'author' );

__PACKAGE__->has_many(
  'user_book_tags' => 'Bibliophiler::Schema::Result::UserBookTags' ,
  { 'foreign.book_id' => 'self.id' } ,
);

__PACKAGE__->many_to_many( 'tags' , 'user_book_tags' , 'tag' );

__PACKAGE__->has_many(
  'readings' => 'Bibliophiler::Schema::Result::Readings' ,
  { 'foreign.book_id' => 'self.id' } ,
);

__PACKAGE__->many_to_many( 'readers' , 'readings' , 'reader' );

1;
