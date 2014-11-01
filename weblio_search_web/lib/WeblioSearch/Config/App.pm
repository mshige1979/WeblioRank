package WeblioSearch::Config::App{
    use Mouse;
    use Config::PL;

    sub config{
        return config_do "config.pl";
    }

    __PACKAGE__->meta->make_immutable();
}

1;
