{
    connect_info => [ "dbi:mysql:$ENV{'WEBSEARCHAPP_DATABASE'}:$ENV{'WEBSEARCHAPP_HOST'}", $ENV{'WEBSEARCHAPP_USER'}, $ENV{'WEBSEARCHAPP_PASS'}, +{ mysql_enable_utf8 => 1 } ]
}
