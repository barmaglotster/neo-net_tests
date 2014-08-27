use strict;
use warnings;
use locale;
use Digest::MD5 qw(md5_hex);
use DB_File;

# ������������ �����
my $file1 = "big/1.log";
my $file2 = "big/2.log";

# ��� ��� md5-����� ����� ������� �����
my %one = ();
#  ��������� � ������, ����� �� ������� �� ��� ����� � ������, � �� ������� �����...
tie %one,  'DB_File', 'one_hash', O_CREAT|O_TRUNC;

my $cnt = 1; # ������� �����

# ��������� ������ ����
open my $f, "<", $file1 or die "Can't open file [$file1]!\n$!\n";

while ( my $str = <$f> ) {
    #  ��������� md5-��� ��� ����� � ��������� ����� ������ ��� ��������
    $one{ md5_hex( $str ) } = $cnt++;
};

close $f;

# ��������� ������ ����
open $f, "<", $file2 or die "Can't open file [$file2]!\n$!\n";

while ( my $str = <$f> ) {
    # ��������� md5-��� � ���� ����� �� ��� ������������ � ������ �����, �� ������� ���
    delete $one{ md5_hex( $str ) };
};

close $f;

$cnt = 1;
my $str = "";

# ����� ��������� �� ������� ����� � ������� �� ������, ������� ��������
# � ���� � �������� �����
open $f, "<", $file1 or die "Can't open file [$file1]!\n$!\n";

for my $num ( sort { $a <=> $b } values %one ) {
    $str = <$f> while ( ++$cnt <= $num );
    print "". <$f>; # ����� ��� ��������� ��������
};

close $f;
