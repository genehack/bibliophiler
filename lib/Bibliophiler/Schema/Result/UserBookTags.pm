package Bibliophiler::Schema::Result::UserBookTags;

use strict;
use warnings;
use 5.010;

use base 'DBIx::Class';

__PACKAGE__->load_components(
  'InflateColumn::DateTime' ,
  'TimeStamp'               ,
  'Core'                    ,
);

__PACKAGE__->table( 'user_book_tags' );

__PACKAGE__->add_columns(
  'user_id' => { data_type => 'INTEGER' } ,
  'book_id' => { data_type => 'INTEGER' } ,
  'tag_id'  => { data_type => 'INTEGER' } ,
);

__PACKAGE__->set_primary_key( 'user_id' , 'book_id' , 'tag_id' );

__PACKAGE__->belongs_to(
  'user' => 'Bibliophiler::Schema::Result::Users' ,
  { 'foreign.id' => 'self.user_id' } ,
);

__PACKAGE__->belongs_to(
  'book' => 'Bibliophiler::Schema::Result::Books' ,
  { 'foreign.id' => 'self.book_id' } ,
);

__PACKAGE__->belongs_to(
  'tag' => 'Bibliophiler::Schema::Result::Tags' ,
  { 'foreign.id' => 'self.tag_id' } ,
);

1;
