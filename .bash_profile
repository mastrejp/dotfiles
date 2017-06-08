# .bash_profile はログイン時にのみ実行されます。
# 具体的な用途は:
#   環境変数を設定する (export する変数)
#   環境変数はプロセス間で勝手に受け継がれるのでログイン時のみ設定すれば十分です。
# http://qiita.com/magicant/items/d3bb7ea1192e63fba850

# 環境変数
eval "$(rbenv init -)"
export EDITOR="vim"
eval "$(direnv hook bash)"

# .node.js用
#export PATH=/usr/local/git/bin/:$HOME/.nodebrew/current/bin:$PATH
export PATH=$HOME/.nodebrew/current/bin:$PATH:/usr/local/git/bin/

# .bashrc読込(必ず最後に実行)
test -r ~/.bashrc && . ~/.bashrc
