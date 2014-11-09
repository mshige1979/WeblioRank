package WeblioSearch::Web::Controller::App;
use Mojo::Base 'Mojolicious::Controller';

use Data::Dumper;
use Date::Simple(':all');
use WeblioSearch::Model::Rank;

# 日付の順位を取得
 sub rank {
   my $self = shift;
   my $date_param = $self->param('date');;
   my $log = $self->app->log;
   my $date_format;
   my $date;
   my $list = [];

   # 日付チェック
   if(defined $date_param){
     $date = d8($date_param);
     my $date_check = date($date_param);

     # 日付チェック失敗時はエラー画面へ遷移
     if(!defined $date_check){
       #die;
       return $self->render_exception;
     }else{
        $log->debug("date check = " . $date_check);
     }

   }else{
     $date = Date::Simple->new();
   }

   # 日付
   $date_format = $date->format('%Y-%m-%d');
   $log->debug("date = " . $date_format);

   # 日付パラメータでデータを取得
   my $model = new WeblioSearch::Model::Rank();
   $list = $model->find_date($date_format);
   $log->debug(Dumper($list));

   # json指定
   $self->render(json => {
    list => $list,
    date => $date_format
   });

 }

 # 期間の順位を取得
 sub rankPeriod {
   my $self = shift;
   my $date_param1 = $self->param('date1');
   my $log = $self->app->log;
   my $date_format1;
   my $date1;
   my $list = [];

   # 日付チェック
   if((defined $date_param1)){
     $date1 = d8($date_param1);
     my $date_check1 = date($date_param1);
     $log->debug("date check1 = " . $date_check1);

     # 日付チェック失敗時はエラー画面へ遷移
     if((!defined $date_check1)){
       #die;
       return $self->render_exception;
     }

   }else{
     return $self->render_exception;
   }

   # 6日前の日付を取得
   my $date2 = $date1 - 6;
   my $date_format2 = $date2->format('%Y-%m-%d');

   # 日付
   $date_format1 = $date1->format('%Y-%m-%d');
   $log->debug("date = " . $date_format2 . " - " . $date_format1);

   # 日付パラメータでデータを取得
   my $model = new WeblioSearch::Model::Rank();
   $list = $model->find_date_period($date_format2, $date_format1);
   $log->debug(Dumper($list));

   # json指定
   $self->render(json => {
       date1 => $date_format1,
       date2 => $date_format2,
       list => $list,
   });

 }

 # １位数の多い順のデータを取得
 sub rankTop {
    my $self = shift;
    my $log = $self->app->log;
    my $list = [];

    # TOPデータを取得
    my $model = new WeblioSearch::Model::Rank();
    $list = $model->find_date_top();
    $log->debug(Dumper($list));

    # json指定
    $self->render(json => {
        list => $list
    });

 }

 # rankテーブルに出現した単語の多い順に50件
  sub rankCount {
     my $self = shift;
     my $log = $self->app->log;
     my $list = [];

     # TOPデータを取得
     my $model = new WeblioSearch::Model::Rank();
     $list = $model->find_date_count();
     $log->debug(Dumper($list));

     # json指定
     $self->render(json => {
         list => $list
     });

  }

1;
