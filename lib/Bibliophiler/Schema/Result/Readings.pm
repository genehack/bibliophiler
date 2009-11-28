package Bibliophiler::Schema::Result::Readings;

use strict;
use warnings;
use 5.010;

use base 'DBIx::Class';

__PACKAGE__->load_components( 'InflateColumn::DateTime' , 'TimeStamp' , 'Core' );

__PACKAGE__->table( 'readings' );

__PACKAGE__->add_columns(
  'id'            => { data_type => 'INTEGER'  , is_nullable => 0 , size => undef , is_auto_increment => 1 } ,
  'user_id'       => { data_type => 'INTEGER'  , is_nullable => 0 , size => undef } ,
  'book_id'       => { data_type => 'INTEGER'  , is_nullable => 0 , size => undef } ,
  'start'         => { data_type => 'DATE'     , is_nullable => 0 , size => undef } ,
  'finish'        => { data_type => 'DATE'     , is_nullable => 1 , size => undef } ,
  'last_modified' => { data_type => 'DATETIME' , is_nullable => 0 , size => undef , set_on_create => 1 , set_on_update => 1 } ,
);

__PACKAGE__->set_primary_key( 'id' );

__PACKAGE__->belongs_to(
  'reader' ,
  'Bibliophiler::Schema::Result::Users' ,
  { 'foreign.id' => 'self.user_id' } ,
);

__PACKAGE__->belongs_to(
  'book' ,
  'Bibliophiler::Schema::Result::Books' ,
  { 'foreign.id' => 'self.book_id' } ,
);

1;
