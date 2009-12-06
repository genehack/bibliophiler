package Bibliophiler::Schema::Result::Readings;

use strict;
use warnings;
use 5.010;

use base 'DBIx::Class';

__PACKAGE__->load_components(
  'InflateColumn::DateTime' ,
  'TimeStamp'               ,
  'Core'                    ,
);

__PACKAGE__->table( 'readings' );

__PACKAGE__->add_columns(
  'id' => {
    data_type         => 'INTEGER'  ,
    is_auto_increment => 1          ,
  } ,
  'user_id'       => { data_type => 'INTEGER'  } ,
  'book_id'       => { data_type => 'INTEGER'  } ,
  'start'         => { data_type => 'DATE'     , accessor => '_start'  } ,
  'finish'        => { data_type => 'DATE'     , accessor => '_finish' , is_nullable => 1 } ,
  'last_modified' => {
    data_type     => 'DATETIME' ,
    set_on_create => 1          ,
    set_on_update => 1          ,
  } ,
);

__PACKAGE__->set_primary_key( 'id' );

__PACKAGE__->belongs_to(
  'reader' => 'Bibliophiler::Schema::Result::Users' ,
  { 'foreign.id' => 'self.user_id' } ,
);

__PACKAGE__->belongs_to(
  'book' => 'Bibliophiler::Schema::Result::Books' ,
  { 'foreign.id' => 'self.book_id' } ,
);

sub start {
  my( $self ) = shift;

  return $self->_start( @_ ) if @_;

  my $start = $self->_start;
  return $start->ymd('.');
}

sub finish {
  my( $self ) = shift;

  return $self->_finish( @_ ) if @_;

  if ( my $finish = $self->_finish ) {
    return $finish->ymd('.');
  }
  else {
    return "NOT DONE YET";
  }
}

sub duration {
  my( $self ) = shift;

  my $start = $self->_start;
  my $finish = $self->_finish;

  if ( $start and $finish ) {
    return $finish - $start;
  }
  else {
    return undef;
  }
}

1;
