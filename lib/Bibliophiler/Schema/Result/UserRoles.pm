package Bibliophiler::Schema::Result::UserRoles;

use strict;
use warnings;
use 5.010;

use base 'DBIx::Class';

__PACKAGE__->load_components(
  'InflateColumn::DateTime' ,
  'TimeStamp'               ,
  'Core'                    ,
);

__PACKAGE__->table( 'user_roles' );

__PACKAGE__->add_columns(
  'user_id' => { data_type => 'INTEGER' } ,
  'role_id' => { data_type => 'INTEGER' } ,
);

__PACKAGE__->set_primary_key( 'user_id' , 'role_id' );

__PACKAGE__->belongs_to(
  'user' => 'Bibliophiler::Schema::Result::Users' ,
  { 'foreign.id' => 'self.user_id' } ,
);

__PACKAGE__->belongs_to(
  'role' => 'Bibliophiler::Schema::Result::Roles' ,
  { 'foreign.id' => 'self.role_id' } ,
);

1;
