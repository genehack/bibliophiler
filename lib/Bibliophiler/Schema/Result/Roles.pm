package Bibliophiler::Schema::Result::Roles;

use strict;
use warnings;
use 5.010;

use base 'DBIx::Class';

__PACKAGE__->load_components(
  'InflateColumn::DateTime' ,
  'TimeStamp'               ,
  'Core'                    ,
);

__PACKAGE__->table( 'roles' );

__PACKAGE__->add_columns(
  'id'   => { data_type => 'INTEGER' , is_auto_increment => 1 } ,
  'name' => { data_type => 'TEXT'    } ,
);

__PACKAGE__->set_primary_key( 'id' );

__PACKAGE__->add_unique_constraint([ 'name' ]);

__PACKAGE__->has_many(
  'user_roles' => 'Bibliophiler::Schema::Result::UserRoles' ,
  { 'foreign.role_id' => 'self.id' } ,
);

__PACKAGE__->many_to_many( 'users' , 'user_roles' , 'role' );

1;
