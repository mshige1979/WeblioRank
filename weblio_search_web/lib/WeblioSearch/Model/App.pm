package WeblioSearch::Model::App{
    use Mouse;
    use WeblioSearch::Model;

    extends WeblioSearch::Model;

    has 'table' => (
        is => 'ro',
        isa => 'Str',
    );

    __PACKAGE__->meta->make_immutable();

}


