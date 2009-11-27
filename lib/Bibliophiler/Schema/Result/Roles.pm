package Bibliophiler::Schema::Result::Roles;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components( 'InflateColumn::DateTime' , 'TimeStamp' , 'Core' );
__PACKAGE__->table( 'roles' );

__PACKAGE__->add_columns(
  'id'   => { data_type => 'INTEGER' , is_nullable => 0 , size => undef , is_auto_increment => 1 } ,
  'name' => { data_type => 'TEXT'    , is_nullable => 0 , size => undef } ,
);

__PACKAGE__->set_primary_key( 'id' );
__PACKAGE__->add_unique_constraint( 'name_unique' , [ 'name' ]);

__PACKAGE__->has_many(
  'user_roles' ,
  'Bibliophiler::Schema::Result::UserRoles' ,
  { 'foreign.role_id' => 'self.id' } ,
);

__PACKAGE__->many_to_many(
  'users' , 'user_roles' , 'role'
);

1;

