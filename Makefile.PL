#!/usr/bin/env perl
# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
use inc::Module::Install;

name 'Bibliophiler';
all_from 'lib/Bibliophiler.pm';

requires 'Catalyst::Runtime' => '5.80014';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'Catalyst::Controller::HTML::FormFu';
requires 'parent';
requires 'Config::General'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats


requires 'Catalyst::Plugin::Authentication';
requires 'Catalyst::Plugin::Authorization::Roles';
requires 'Catalyst::Plugin::Session';
requires 'Catalyst::Plugin::Session::State::Cookie';
requires 'Catalyst::Plugin::Session::Store::FastMmap';
requires 'Catalyst::Authentication::Store::DBIx::Class';

requires 'DBIx::Class::TimeStamp';

requires 'HTML::FormHandler::Moose';
requires 'HTML::FormHandler::Model::DBIC';
requires 'HTML::FormHandler::Render::Table';
requires 'Digest';

catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
