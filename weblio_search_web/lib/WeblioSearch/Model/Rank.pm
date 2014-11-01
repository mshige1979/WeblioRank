package WeblioSearch::Model::Rank{
    use Mouse;
    use WeblioSearch::Model::App;

    extends WeblioSearch::Model::App;

    has 'table' => (
        is => 'ro',
        isa => 'Str',
        default => 'rank'
    );

    # 削除
    sub delete{
        my ($self, $where) = @_;

        # 全件取得
        my $data = $self->db->delete($self->table, $where);

        # 結果返却
        return $data;

    }

    # 削除
    sub insert{
        my ($self, $params) = @_;

        # 全件取得
        my $data = $self->db->insert($self->table, $params);

        # 結果返却
        return $data;

    }

    __PACKAGE__->meta->make_immutable();

}


