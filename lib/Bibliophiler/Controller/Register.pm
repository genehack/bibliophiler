package Bibliophiler::Controller::Register;

use strict;
use warnings;
use 5.010;

use parent 'Catalyst::Controller::HTML::FormFu';

use Digest;

sub index :Path :FormConfig {
  my( $self , $c ) = @_;

  my $form = $c->stash->{form};

  if ( $form->submitted_and_valid ) {
    my $params = $c->request->body_params;

    my $username = $params->{email};

    my $users_rs = $c->model( 'DB::Users' );

    my $pass1 = $params->{password1} or die "Need password";
    my $pass2 = $params->{password2} or die "Need to confirm password";

    $pass1 eq $pass2 or die "Passwords don't match";

    my $sha = Digest->new( 'SHA-1' );
    $sha->add( $pass1 );
    $pass1 = $sha->hexdigest();

    my $user;
    eval { $user = $users_rs->create({ username => $username , password => $pass1 }) };
    if ( $@ ) {
      $c->stash->{message} = $@;
      $c->detach;
    }

    $c->stash->{username} = $user->username;
    $c->stash->{message}  = 'Account created. Please log in.';

    $c->forward( 'Bibliophiler::Controller::Root' , 'index' );
  }
}

1;
