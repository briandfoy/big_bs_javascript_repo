#!/usr/bin/perl
use v5.10;

use IO::Interactive qw(is_interactive interactive);
use List::Util qw(shuffle);

my @files = shuffle( glob( 'js/*.js' ) );
say { interactive } 'Found ' . @files . ' files';

sleep rand(15) unless is_interactive;

exit if( ! is_interactive && time % 5 );

sleep rand(3000) unless is_interactive;

foreach my $file ( shuffle(@files) ) {
	say { interactive } "Processing <$file>";
	open my $fh, '<:utf8', $file or next;
	chomp( my @lines = <$fh> );
	close $fh;

	foreach my $i ( 0 .. 10 + rand(87) ) {
		push @lines, make_js_line();
		}

	shuffle(@lines) if time % 2;

	open my $out_fh, '>:utf8', $file;
	say { $out_fh } $_ for @lines;
	close $out_fh;
	}

rename $files[0] => 'js/' . random_var_name() . '.js';
unlink $files[-1] if time % 2;

if( time % 3 ) {
	foreach my $i ( 0 .. 3 ) {
		open my $fh, '>:utf8', 'js/' . random_var_name() . '.js';
		say { $fh } make_js_line() for 0 .. 3 + rand(15);
		close $fh;
		}
	}

sub make_js_line {
	my $s1 = random_var_name();
	my $s2 = random_var_name();
	my @lines = (
		"let @{[random_var_name()]} = @{[ sprintf '%.2f', rand 137]};",
		"// @{[random_var_name()]} @{[random_var_name()]}",
		"function @{[random_var_name()]}($s1, $s2) { return $s1 * $s2; }",
	);

	$lines[rand @lines]
	}

sub random_var_name {
	my @chars = ( 'a' .. 'z', 'A' .. 'Z' );

	join '', map { $chars[rand @chars] } 0 .. (8+rand 9);
	}
