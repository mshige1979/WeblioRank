package WeblioSearch::Web::Controller::Root;
use Mojo::Base 'Mojolicious::Controller';

# 初期ページ
sub index {
  my $self = shift;

  # stash
  $self->stash->{msg} = "初期データ";

  # view
  $self->render();
}

1;
