#!/usr/bin/perl
# by Adam Bielinski
use warnings;
use strict;

use Gtk2 -init;

my $time = 30; #seconds


my $window = Gtk2::Window->new ('toplevel');
$window->set_title ('Tea Reminder');
$window->set_position('center' );


my $not_done = Gtk2::Button->new ('I\'m not done my tea');
my $done = Gtk2::Button->new ('I\'m finished');

my $label = Gtk2::Label->new("You're drinking tea! How's it doing?");


my $hcontainer = Gtk2::HBox->new();
$hcontainer->set_size_request(-1, 30);


sub main_continue{
	$window->hide_all();
}


$not_done->signal_connect (clicked => \&main_continue);
$done->signal_connect (clicked => sub { Gtk2->main_quit });


$hcontainer->add($done);
$hcontainer->add($not_done);

my $vcontainer = Gtk2::VBox->new();
$vcontainer->set_border_width(10);

$vcontainer->add($label);
$vcontainer->add($hcontainer);

$window->add($vcontainer);

$not_done->grab_focus();

$window->show_all();

$window->signal_connect (delete_event => \&Gtk2::Widget::hide_on_delete);


Glib::Timeout->add ($time*1000, sub {
	$not_done->grab_focus(); 
	$window->show_all(); 
	$window->set_urgency_hint(1);#urgent
	1;});

Gtk2->main;


