use strict;
use warnings;
use locale;
use Digest::MD5 qw(md5_hex);
use DB_File;

# Сравниваемые файлы
my $file1 = "big/1.log";
my $file2 = "big/2.log";

# Хэш для md5-хэшей строк первого файла
my %one = ();
#  Связываем с файлом, чтобы не хранить всё это добро в памяти, а то порвётся нафиг...
tie %one,  'DB_File', 'one_hash', O_CREAT|O_TRUNC;

my $cnt = 1; # счётчик строк

# Прочитать первый файл
open my $f, "<", $file1 or die "Can't open file [$file1]!\n$!\n";

while ( my $str = <$f> ) {
    #  Вычислить md5-хэш для строк и сохранить номер строки как значение
    $one{ md5_hex( $str ) } = $cnt++;
};

close $f;

# Прочитать второй файл
open $f, "<", $file2 or die "Can't open file [$file2]!\n$!\n";

while ( my $str = <$f> ) {
    # Вычислить md5-хэш и если такой же уже присутствует в первом файле, то удалить его
    delete $one{ md5_hex( $str ) };
};

close $f;

$cnt = 1;
my $str = "";

# Снова пробежать по первому файлу и вывести те строки, которые остались
# в хэше с номерами строк
open $f, "<", $file1 or die "Can't open file [$file1]!\n$!\n";

for my $num ( sort { $a <=> $b } values %one ) {
    $str = <$f> while ( ++$cnt <= $num );
    print "". <$f>; # чтобы был скалярный контекст
};

close $f;
