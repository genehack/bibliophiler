package Bibliophiler::Schema::Result::Users;

use strict;
use warnings;
use 5.010;

use base 'DBIx::Class';

use Mail::VRFY;

__PACKAGE__->load_components(
  'InflateColumn::DateTime' ,
  'TimeStamp'               ,
  'Core'                    ,
);

__PACKAGE__->table( 'users' );

__PACKAGE__->resultset_class( 'Bibliophiler::Schema::ResultSet::Users' );

__PACKAGE__->add_columns(
  'id'            => { data_type => 'INTEGER' , is_auto_increment => 1 } ,
  'username'      => { data_type => 'TEXT' } ,
  'password'      => { data_type => 'TEXT' } ,
  'last_modified' => { data_type => 'DATETIME' , set_on_create => 1 , set_on_update => 1 } ,
);

__PACKAGE__->set_primary_key( 'id' );

__PACKAGE__->add_unique_constraint([ 'username' ]);

__PACKAGE__->has_many(
  'readings' => 'Bibliophiler::Schema::Result::Readings' ,
  { 'foreign.user_id' => 'self.id' } ,
);

__PACKAGE__->has_many(
  'user_book_tags' => 'Bibliophiler::Schema::Result::UserBookTags' ,
  { 'foreign.user_id' => 'self.id' } ,
);

__PACKAGE__->many_to_many( 'books' , 'user_book_tags' , 'book' );

__PACKAGE__->has_many(
  'user_roles' => 'Bibliophiler::Schema::Result::UserRoles' ,
  { 'foreign.user_id' => 'self.id' } ,
);

__PACKAGE__->many_to_many( 'roles' , 'user_roles' , 'role' );

sub new {
  my( $class , $args ) = @_;

  if ( exists $args->{username} and Mail::VRFY::CheckAddress(
    addr   => $args->{username} ,
    method => 'syntax'  ,
  )) {
    die 'Invalid email address';
  }

  return $class->next::method( $args );
}

1;
