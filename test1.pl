use strict;
use warnings;
use locale;
use Text::Format; # чтобы не изобретать велоспиед с форматированием (ну да, Laziness, Impatience and Hubris)

# Массив абзацев (например)
my @txt = (
q(This is the header),
q(Text::Wrap::wrap() starts its work by expanding all the tabs in its input into spaces. The last thing it does it to turn spaces back into tabs. If you do not want tabs in your results, set $Text::Wrap::unexpand to a false value. Likewise if you do not want to use 8-character tabstops, set $Text::Wrap::tabstop to the number of characters you do want for your tabstops.),
q(The format routine will format under all circumstances even if the width isn't enough to contain the longest words. Text::Wrap will die under these circumstances, although I am told this is fixed. If columns is set to a small number and words are longer than that and the leading 'whitespace' than there will be a single word on each line. This will let you make a simple word list which could be indented or right aligned. There is a chance for croaking if you try to subvert the module. If you don't pass in text then the internal text is worked on, though not modfied.),
q(На Хабре уже несколько раз упоминали летающие транспортные средства, включая летающий мотоцикл от Криса Эллоя. Еще в 2011 году этот инженер представил собственный вариант летающего мотоцикла, Hoverbike, а сейчас он собирает средства на промышленную реализацию своего проекта. ),
);

# Установить количество столбцов (ширину текста)
my $columns      = 70;
# Установить отступ первой строки абзаца
my $first_indent = 4;

my $text = Text::Format->new ({
    columns     => $columns,
    firstIndent => $first_indent,
    justify     => 1, # выравнивание по ширине
    leftMargin  => 0, # отступ слева до текста
    rightMargin => 0, # отступ справа до текста
    bodyIndent  => 0, # отступ до основного текста ("тела" текста)
});

# Пробежать по всем абзацам
for ( @txt ) {
	# Если длина строки (абзаца) меньше половины ширины текста,
	# то её не обрабатывать
    if ( length($_) < $columns / 2 ) {
		print "$_\n";
    }
    else {
    	# Сделать красиво...
		print $text->format( [$_] );
    };
};


