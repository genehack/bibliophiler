package Bibliophiler::Schema::Result::UserRoles;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components( 'InflateColumn::DateTime' , 'TimeStamp' , 'Core' );
__PACKAGE__->table( 'user_roles' );

__PACKAGE__->add_columns(
  'user_id' => { data_type => 'INTEGER' , is_nullable => 0 , size => undef } ,
  'role_id' => { data_type => 'INTEGER' , is_nullable => 0 , size => undef } ,
);

__PACKAGE__->set_primary_key( 'user_id' , 'role_id' );

__PACKAGE__->belongs_to(
  'user' ,
  'Bibliophiler::Schema::Result::Users' ,
  { 'foreign.id' => 'self.user_id' } ,
);

__PACKAGE__->belongs_to(
  'role' ,
  'Bibliophiler::Schema::Result::Roles' ,
  { 'foreign.id' => 'self.role_id' } ,
);

1;

