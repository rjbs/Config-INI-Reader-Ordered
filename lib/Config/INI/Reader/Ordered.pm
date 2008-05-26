use strict;

package Config::INI::Reader::Ordered;

use Config::INI::Reader;
use vars qw(@ISA $VERSION);
BEGIN { @ISA = qw(Config::INI::Reader) }

=head1 NAME

Config::INI::Reader::Ordered -- .ini-file parser that returns sections in order

=head1 VERSION

version 0.011

=cut

$VERSION = '0.011';

=head1 SYNOPSIS

If F<family.ini> contains:

  admin = rjbs

  [rjbs]
  awesome = yes
  height = 5' 10"

  [mj]
  awesome = totally
  height = 23"

Then when your program contains:

  my $array = Config::INI::Reader->read_file('family.ini');

C<$array> will contain:

  [
    [ '_'  => { admin => 'rjbs' } ],
    [
      rjbs => {
        awesome => 'yes',
        height  => q{5' 10"},
      }
    ],
    [ 
      mj   => {
        awesome => 'totally',
        height  => '23"',
      }
    ],
  ]

=head1 DESCRIPTION

Config::INI::Reader::Ordered is a subclass of L<Config::INI::Reader> which
preserves section order.  See L<Config::INI::Reader> for all documentation; the
only difference is as presented in the L</SYNOPSIS>.

=cut

=head1 METHODS

=head2 change_section

=head2 set_value

=head2 finalize

Overridden to preserve and present section order.

=cut

sub change_section {
  my ($self, $section) = @_;
  $self->SUPER::change_section($section);
  $self->{order} ||= [];
  push @{ $self->{order} }, $section
    unless grep { $_ eq $section } @{ $self->{order} };
}

sub set_value {
  my ($self, $name, $value) = @_;
  $self->SUPER::set_value($name, $value);
  unless ($self->{order}) {
    $self->{order} = [ $self->starting_section ];
  }
}

sub finalize {
  my ($self) = @_;
  my $data = [];
  for my $section (@{ $self->{order} || [] }) {
    push @$data, [ $section, $self->{data}{$section} ];
  }
  $self->{data} = $data;
}

1;
