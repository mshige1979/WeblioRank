package WeblioSearch::Model::Rank{
    use Mouse;
    use WeblioSearch::Model::App;

    extends WeblioSearch::Model::App;

    use Date::Simple(':all');

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

        for(my $i=0;$i<=6;$i++){
            my $_date = Date::Simple->new($date1) + $i;
            my $date_format = $_date->format('%Y-%m-%d');
            my $item_list = {
                date => $date_format,
                item_list => []
            };

            # 全件取得
            $data = $self->db->search(
                $self->table,
                {
                    date => $date_format
                },
                +{
                    order_by => 'date ASC, rank ASC'
                }
            );

            # ハッシュ型で設定
            while(my $row = $data->next()){
                push @{$item_list->{item_list}}, {
                    rank => $row->rank,
                    word => $row->word,
                    date => $row->date,
                    category => $row->category,
                };
            }

            # 配列追加
            push @{$list}, $item_list;
        }





        # 結果返却
        return $list;

    }

    # 1位の回数が多いデータ順
    sub find_date_top{
        my ($self, $date) = @_;

        my $data;
        my $list = [];

        # 全件取得
        $data = $self->db->search_by_sql_abstract_more(
            $self->table,
            # 条件
            {
            },
            # オプション
            +{
                # カラム
                -columns  => [
                    'rank',
                    'word',
                    'count(*) as count'
                ],
                # グループ
                -group_by => [
                    'rank',
                    'word'
                ],
                # グループ条件
                -having => [
                    -and => [
                        'rank' => {"=" => 1},
                        'count' => {
                            ">=" => 5
                        }
                    ]
                ],
                # 並べ替え
                -order_by => [
                    'count DESC',
                    'word'
                ],
            });

        # ハッシュ型で設定
        while(my $row = $data->next()){
            push @{$list}, {
                word => $row->word,
                count => $row->count,

            };
        }

        # 結果返却
        return $list;

    }

    # ランクイン回数が多いデータ順
    sub find_date_count{
        my ($self, $date) = @_;

        my $data;
        my $list = [];

        # 全件取得
        $data = $self->db->search_by_sql_abstract_more(
            $self->table,
            # 条件
            {
            },
            # オプション
            +{
                # カラム
                -columns  => [
                    'word',
                    'count(word) as count'
                ],
                # グループ
                -group_by => [
                    'word'
                ],
                # グループ条件
                -having => [
                    -and => [
                        'count' => {
                            ">=" => 1
                        }
                    ]
                ],
                # 並べ替え
                -order_by => [
                    'count DESC',
                    'word'
                ],

                # 件数
                -limit => 50,
            });

        # ハッシュ型で設定
        while(my $row = $data->next()){
            push @{$list}, {
                word => $row->word,
                count => $row->count,

            };
        }

        # 結果返却
        return $list;

    }

    __PACKAGE__->meta->make_immutable();

}


