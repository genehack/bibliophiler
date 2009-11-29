package Bibliophiler::Schema::ResultSet::Users;

use strict;
use warnings;
use 5.010;

use base 'DBIx::Class::ResultSet';

use Digest;
use Mail::VRFY;

sub create_new_user {
  my( $class , %args ) = @_;

  my $username = $args{email}
    or die "Need username";

  if ( Mail::VRFY::CheckAddress(
    addr   => $username ,
    method => 'syntax'  ,
  )) {
    die 'Invalid email address';
  }

  die "Account name already used"
    if ( $class->find({ username => $username }));

  my $pass1 = $args{password1} or die "Need password";
  my $pass2 = $args{password2} or die "Need to confirm password";

  $pass1 eq $pass2 or die "Passwords don't match";

  my $sha = Digest->new( 'SHA-1' );
  $sha->add( $pass1 );
  $pass1 = $sha->hexdigest();

  my $user = $class->create({
    username => $username ,
    password => $pass1    ,
  });

  return $user;
}

1;
