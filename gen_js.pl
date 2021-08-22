#!/usr/bin/perl
use v5.10;

use List::Util qw(shuffle);

my @files = shuffle( glob( 'js/*.js' ) );
say 'Found ' . @files . ' files';

foreach my $file ( @files ) {
	say "Processing <$file>";
	open my $fh, '<:utf8', $file or next;
	chomp( my @lines = <$fh> );
	close $fh;

	foreach my $i ( 0 .. 10 + rand(87) ) {
		push @lines, make_js_line();
		}

	shuffle(@lines);

	open my $out_fh, '>:utf8', $file;
	say { $out_fh } $_ for @lines;
	close $out_fh;
	}

rename $files[0] => random_var_name() . '.js';
unlink $files[-1] if time % 2;

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
