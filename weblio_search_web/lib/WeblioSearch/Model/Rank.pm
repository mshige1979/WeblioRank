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

    # 日付で抽出
    sub find_date{
        my ($self, $date) = @_;

        my $data;
        my $list = [];

        # 全件取得
        $data = $self->db->search($self->table, {date => $date}, +{order_by => 'rank ASC'});

        # ハッシュ型で設定
        while(my $row = $data->next()){
            push @{$list}, {
                rank => $row->rank,
                word => $row->word,
                date => $row->date,
                category => $row->category,
            };
        }

        # 結果返却
        return $list;

    }

    # 日付で抽出
    sub find_date_period{
        my ($self, $date1, $date2) = @_;

        my $data;
        my $list = [];

        # 全件取得
        $data = $self->db->search(
            $self->table,
            {date => +{ between => [$date1, $date2] }}, +{order_by => 'date ASC, rank ASC'}
        );

        # ハッシュ型で設定
        while(my $row = $data->next()){
            push @{$list}, {
                rank => $row->rank,
                word => $row->word,
                date => $row->date,
                category => $row->category,
            };
        }

        # 結果返却
        return $list;

    }

    __PACKAGE__->meta->make_immutable();

}


