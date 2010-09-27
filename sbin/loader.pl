#! /opt/perl/bin/perl

use strict;
use warnings;

use YAML qw/ LoadFile /;

use FindBin;
use lib "$FindBin::Bin/lib";

use Bibliophiler::Schema;

my $schema = Bibliophiler::Schema->connect( 'dbi:SQLite:db/bibliophiler.db' );

my $yaml = LoadFile( './books.yaml' );

foreach my $book ( @$yaml) {
  my $book_obj = $schema->resultset( 'Books' )->create({
    title => $book->{title} ,
    pages => $book->{pages} ,
    isbn  => time ,
  });

  foreach my $author ( @{ $book->{authors} }) {
    my $author_obj = $schema->resultset( 'Authors' )->find_or_create({
      lname => $author->{last} ,
      fname => $author->{first} ,
    });
    $schema->resultset( 'AuthorBooks' )->create({
      author_id => $author_obj->id ,
      book_id   => $book_obj->id
    });
  }

  foreach my $tag ( @{ $book->{tags} }) {
    my $tag_obj = $schema->resultset( 'Tags' )->find_or_create({
      name => $tag
    });
    $schema->resultset( 'UserBookTags' )->create({
      book_id => $book_obj->id ,
      tag_id  => $tag_obj->id ,
      user_id => 1 ,
    });
  }

  my( $start , $finish );

  my( $s_yr , $s_mo , $s_dy ) = $book->{start}  =~ /(\d{4})(\d{2})(\d{2})/;
  $start = DateTime->new( year => $s_yr , month => $s_mo , day => $s_dy );

  if ( $book->{finish} ) {
    my( $f_yr , $f_mo , $f_dy ) = $book->{finish} =~ /(\d{4})(\d{2})(\d{2})/;
    $finish = DateTime->new( year => $f_yr , month => $f_mo , day => $f_dy );
  }

  my $reading = $schema->resultset( 'Readings' )->create({
    user_id => 1 ,
    book_id => $book_obj->id ,
    start   => $start ,
    finish  => $finish ,
  });
}

