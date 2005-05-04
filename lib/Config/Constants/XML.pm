
package Config::Constants::XML;

use strict;
use warnings;

our $VERSION = '0.01';

use base 'Config::Constants::Perl';

use XML::SAX::ParserFactory;

sub _init {
    my ($self, $file) = @_;
    (-e $file && -f $file)
        || die "Bad config file '$file' either it doesn't exist or it's not a file";    
    my $handler = Config::Constants::XML::SAX::Handler->new();
    my $p = XML::SAX::ParserFactory->parser(Handler => $handler);
    $p->parse_uri($file);
    $self->{_config} = $handler->config();
}

package Config::Constants::XML::SAX::Handler;

use strict;
use warnings;

our $VERSION = '0.01';

use base 'XML::SAX::Base';

sub new {
    my $class = shift;
    my $self = $class->SUPER::new(@_);
    $self->{_config} = undef;
    $self->{_current_module} = undef;
    $self->{_current_constant} = undef;    
    return $self;
}

sub config { (shift)->{_config} }

sub start_element {
    my ($self, $el) = @_;
    my $tag_name = lc($el->{Name});
    if ($tag_name eq 'config') {
        $self->{_config} = {};    
    }
    elsif ($tag_name eq 'module') {
        $self->{_current_module} = $self->_get_value($el, 'name');
        $self->{_config}->{$self->{_current_module}} = [];
    }
    elsif ($tag_name eq 'constant') {
        $self->{_current_constant} = $self->_get_value($el, 'name');
        push @{$self->{_config}->{$self->{_current_module}}} => (
            { $self->{_current_constant} => $self->_get_value($el, 'value') }
        );
    }
    else {
        die "did not recognize the tag: $tag_name";
    }
}

#sub end_element {
#    my ($self, $el) = @_;
#    my $tag_name = lc($el->{Name});
#}

#sub characters {
#    my ($self, $el) = @_;
#    my $data = $el->{Data};
#}

sub _get_value {
    my ($self, $el, $key) = @_;
    return undef unless exists $el->{Attributes}->{'{}' . $key};
    return $el->{Attributes}->{'{}' . $key}->{Value};        
}

1;

__END__

=head1 NAME

Config::Constants::XML - Configuration loader for Config::Constants

=head1 SYNOPSIS
  
  use Config::Constants::XML;

=head1 DESCRIPTION

This module reads and parses XML files as configuration files that look like this:

  <config>
      <module name='Foo::Bar'>
          <constant name='BAZ' value='the coolest module ever' />
      </module>
  </config>  

=head1 METHODS

=over 4

=item B<new ($file)>

This takes the file, loads, parses and stores the resulting configuration.

=item B<modules>

This will return an array of modules in this configuration.

=item B<constants ($module_name)>

Given a C<$module_name>, this will return an array of hash references for each constant specified.

=back

=head1 TO DO

=head1 BUGS

None that I am aware of. Of course, if you find a bug, let me know, and I will be sure to fix it. 

=head1 CODE COVERAGE

I use B<Devel::Cover> to test the code coverage of my tests, see the L<Config::Constants> module for more information.

=head1 SEE ALSO

=over 4

=item L<XML::SAX>

=back

=head1 AUTHOR

stevan little, E<lt>stevan@iinteractive.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2005 by Infinity Interactive, Inc.

L<http://www.iinteractive.com>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

