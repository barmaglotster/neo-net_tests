use strict;
use warnings;
use locale;
use Text::Format; # ����� �� ���������� ��������� � ��������������� (�� ��, Laziness, Impatience and Hubris)

# ������ ������� (��������)
my @txt = (
q(This is the header),
q(Text::Wrap::wrap() starts its work by expanding all the tabs in its input into spaces. The last thing it does it to turn spaces back into tabs. If you do not want tabs in your results, set $Text::Wrap::unexpand to a false value. Likewise if you do not want to use 8-character tabstops, set $Text::Wrap::tabstop to the number of characters you do want for your tabstops.),
q(The format routine will format under all circumstances even if the width isn't enough to contain the longest words. Text::Wrap will die under these circumstances, although I am told this is fixed. If columns is set to a small number and words are longer than that and the leading 'whitespace' than there will be a single word on each line. This will let you make a simple word list which could be indented or right aligned. There is a chance for croaking if you try to subvert the module. If you don't pass in text then the internal text is worked on, though not modfied.),
q(�� ����� ��� ��������� ��� ��������� �������� ������������ ��������, ������� �������� �������� �� ����� �����. ��� � 2011 ���� ���� ������� ���������� ����������� ������� ��������� ���������, Hoverbike, � ������ �� �������� �������� �� ������������ ���������� ������ �������. ),
);

# ���������� ���������� �������� (������ ������)
my $columns      = 70;
# ���������� ������ ������ ������ ������
my $first_indent = 4;

my $text = Text::Format->new ({
    columns     => $columns,
    firstIndent => $first_indent,
    justify     => 1, # ������������ �� ������
    leftMargin  => 0, # ������ ����� �� ������
    rightMargin => 0, # ������ ������ �� ������
    bodyIndent  => 0, # ������ �� ��������� ������ ("����" ������)
});

# ��������� �� ���� �������
for ( @txt ) {
	# ���� ����� ������ (������) ������ �������� ������ ������,
	# �� � �� ������������
    if ( length($_) < $columns / 2 ) {
		print "$_\n";
    }
    else {
    	# ������� �������...
		print $text->format( [$_] );
    };
};


