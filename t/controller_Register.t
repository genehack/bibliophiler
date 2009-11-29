use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'Bibliophiler' }
BEGIN { use_ok 'Bibliophiler::Controller::Register' }

ok( request('/register')->is_success, 'Request should succeed' );


