package Bibliophiler::Controller::Book;

use strict;
use warnings;
use 5.010;

use parent 'Catalyst::Controller::HTML::FormFu';

sub add :Local :FormConfig {
  my( $self , $c ) = @_;

  my $form = $c->stash->{form};

  if ( $form->submitted_and_valid ) {
    my $value;

    if ( $value = $form->param( 'submit_now' )) {

    }
    elsif ( $value = $form->param( 'submit_later' )) {

    }
    else { $value = 'wtf' }

    $c->response->body( $value );
    $c->detach;

  }
}

1;
