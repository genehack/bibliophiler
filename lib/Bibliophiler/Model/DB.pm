package Bibliophiler::Model::DB;

use strict;
use warnings;
use 5.010;

use base 'Catalyst::Model::DBIC::Schema';

__PACKAGE__->config(
    schema_class => 'Bibliophiler::Schema',
    connect_info => 'dbi:SQLite:db/bibliophiler.db' ,
);

1;
