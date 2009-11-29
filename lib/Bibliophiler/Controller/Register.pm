package Bibliophiler::Controller::Register;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Bibliophiler::Controller::Register - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

use Digest;

sub index :Path :Args(0) {
  my( $self , $c ) = @_;

  if ( $c->request->method eq 'POST' ) {
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


=head1 AUTHOR

genehack

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
