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
   my $date_param2 = $self->param('date2');
   my $log = $self->app->log;
   my $date_format1;
   my $date_format2;
   my $date1;
   my $date2;
   my $list = [];

   # 日付チェック
   if((defined $date_param1) && (defined $date_param2)){
     $date1 = d8($date_param1);
     my $date_check1 = date($date_param1);
     $log->debug("date check1 = " . $date_check1);

     $date2 = d8($date_param2);
     my $date_check2 = date($date_param1);
     $log->debug("date check2 = " . $date_check2);

     # 日付チェック失敗時はエラー画面へ遷移
     if((!defined $date_check1) || (!defined $date_check2)){
       #die;
       return $self->render_exception;
     }

   }else{
     return $self->render_exception;
   }

   # 日付
   $date_format1 = $date1->format('%Y-%m-%d');
   $date_format2 = $date2->format('%Y-%m-%d');
   $log->debug("date1 = " . $date_format1 . " date2 = " . $date_format2);

   # 日付パラメータでデータを取得
   my $model = new WeblioSearch::Model::Rank();
   $list = $model->find_date_period($date_format1, $date_format2);
   $log->debug(Dumper($list));

   # json指定
   $self->render(json => {
       list => $list,
       date1 => $date_format1,
       date2 => $date_format2
      });

 }

 # 日付の順位を取得
  sub rankTop {
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

1;
