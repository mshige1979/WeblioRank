package WeblioSearch::DB::Schema;
use strict;
use warnings;
use Teng::Schema::Declare;
use utf8;
use Encode;

table{
    name 'rank';
    pk   'id';
    columns qw/id rank category word date/;

};

1;
