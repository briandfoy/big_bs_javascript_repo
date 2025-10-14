#!/usr/bin/perl
use utf8;
use v5.10;

use IO::Interactive qw( is_interactive interactive );
use List::Util qw(shuffle);

my @suffices = map { "GitHub #$_" } 1 .. 4;
push @suffices, map { "Jira #$_" } map { int(rand 10000) } 1 .. 10;

chomp( my @messages = <DATA> );
my @files = shuffle( glob('js/*.js') );

system 'git', 'add', 'js';
foreach my $file ( @files ) {
	sleep rand(300) unless is_interactive;
	say { interactive } "Committing <$file>";
	system 'git', 'commit', '--quiet', '-m', $messages[rand @messages] . ' ' . $suffices[rand @suffices],  $file;
	}

system 'git', 'commit', '--quiet', '-a', '-m', $messages[rand @messages] . ' ' . $suffices[rand @suffices];
system 'git', 'push','--quiet', 'origin', 'master';

__END__
Minimize Javascript
Adjust for latest style
Typos
Whitespace and bracing
Refactor into smaller functions
The quick brown fox
The medium is the message
Add new role
Re-order to make more sense
Bullet points are okay, too
Everything related to documentation
You all know this is bs
Otters are cool
The big, brown pelican flies over the lazy fox
