#!/usr/bin/perl
use utf8;
use v5.10;

use IO::Interactive qw(interactive);
use List::Util qw(shuffle);

chomp( my @messages = <DATA> );
my @files = shuffle( glob('js/*.js') );

system 'git', 'add', 'js';
foreach my $file ( @files ) {
	say { interactive } "Processing <$file>";
	system 'git', 'commit', '--quiet', '-m', $messages[rand @messages],  $file;
	}

system 'git', 'commit', '--quiet', '-a', '-m', $messages[rand @messages];
system 'git', 'push', 'origin', 'master';

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
