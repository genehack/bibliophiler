package Bibliophiler::Schema::Result::Tags;

use strict;
use warnings;
use 5.010;

use base 'DBIx::Class';

__PACKAGE__->load_components( 'InflateColumn::DateTime' , 'TimeStamp' , 'Core' );

__PACKAGE__->table( 'tags' );

__PACKAGE__->add_columns(
  'id'   => { data_type => 'INTEGER' , is_nullable => 0 , size => undef , is_auto_increment => 1 } ,
  'name' => { data_type => 'TEXT'    , is_nullable => 0 , size => undef } ,
);

__PACKAGE__->set_primary_key( 'id' );

__PACKAGE__->add_unique_constraint( 'name_unique' , [ 'name' ]);

__PACKAGE__->has_many(
  'user_book_tags' ,
  'Bibliophiler::Schema::Result::UserBookTags' ,
  { 'foreign.tag_id' => 'self.id' } ,
);

__PACKAGE__->many_to_many( 'books' , 'user_book_tags' , 'book' );
__PACKAGE__->many_to_many( 'users' , 'user_book_tags' , 'user' );

1;
