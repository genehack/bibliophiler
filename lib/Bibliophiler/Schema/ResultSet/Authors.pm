package Bibliophiler::Schema::ResultSet::Authors;

use strict;
use warnings;
use 5.010;

use base 'DBIx::Class::ResultSet';

sub name {
  my( $self ) = @_;
  return sprintf "%s %s" , $self->fname , $self->lname;
}

1;
