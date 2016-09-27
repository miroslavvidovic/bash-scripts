#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	bash_pod.sh
# 	20.09.2016.-13:39:57
# -----------------------------------------------------------------------------
# Description:
#   Using Perl's Plain Old Documentation (POD) in Bash scripts
# Usage:
#   pod2html
#   pod2markdown
#   pod2man
#   pod2readme
#   pod2text
#   pod2usage bash_pod.sh > documentaton.extension(md,txt,html...)
# -----------------------------------------------------------------------------
# Script:

# Script code goes here ...

exit 0

# Use a : NOOP and here document to embed documentation,
: <<'END_OF_DOCS'

Embedded documentation such as Perl's Plain Old Documentation (POD),
or even plain text here.

Any accurate documentation is better than none at all.

Sample documentation in Perl's Plain Old Documentation (POD) format adapted
from  Perl Best Practices book.

=head1 NAME

MY~PROGRAM--One line description here

=head1 SYNOPSIS

  MY~PROGRAM [OPTIONS] <file>

=head1 DESCRIPTION

  A full description of the application and its features.
  May include numerous subsections (i.e. =head2, =head3, etc.)

  [...]

=head1 OPTIONS

  -h = This usage.
  -v = Be verbose.
  -V = Show version, copyright and license information.

=head1 AUTHOR

  Written by Miroslav Vidovic.

=head1 LICENSE AND COPYRIGHT

  MIT LICENSE ...

=head1 SEE ALSO

  command1, command2, link url...

=cut

END_OF_DOCS
