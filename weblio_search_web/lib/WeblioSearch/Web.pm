package WeblioSearch::Web;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer');

  # Router
  my $r = $self->routes;

  # 初期ページ
  $r->get('/')->to('root#index');

  # 日付でその日付の順位を取得
  $r->get('/api/rank')->to('app#rank');
  $r->get('/api/rank/:date')->to('app#rank');

  # 指定期間の順位を取得
  $r->get('/api/rankPeriod/:date1')->to('app#rankPeriod');

  # 1位の表示
  $r->get('/api/rankTop')->to('app#rankTop');

  # ランクイン数の表示
  $r->get('/api/rankCount')->to('app#rankCount');
}

1;
