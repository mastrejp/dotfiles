# .bashrc は対話モードの bash を起動する時に毎回実行されます。
# 具体的な用途は:
#   環境変数でない変数を設定する (export しない変数)
#   エイリアスを定義する
#   シェル関数を定義する
#   コマンドライン補完の設定をする
# これらは bash を起動する度に毎回設定する必要があるものです。

# source shells
source /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-completion.bash
source /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-prompt.sh

# alias
alias la='ls -aF'
alias ll='ls -Alh'
alias sc='screen -R'
alias tree='~/tree'
alias ctags='/usr/local/Cellar/ctags/5.8/bin/ctags'
alias rpa='RAILS_ENV=development bundle exec rake ridgepole:apply; RAILS_ENV=test bundle exec rake ridgepole:apply'

### Added by the Heroku Toolbelt
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/heroku/bin:$PATH"

# functions
function check_merge_test()
{
  base_branch=$1
  target_branch=$(git branch --color=never --contains | cut -d ' ' -f2)
  test_target=$(mktemp -t 'test_target')
  uniq_list=$(mktemp -t 'uniq_list')
  echo "Test target"
  echo "=================================="
  # show differences
  # 1. 実行branchで変更したspecファイルのリストを抽出し$test_targetに追加
  git diff --name-only ${base_branch}..HEAD | grep --colour=never '_spec.rb' | tee -a $test_target
  # 2. 実行branchで変更したspec,rubyファイル以外のファイル(主にviewか)に対応するspecリストを生成し$test_targetに追加
  git diff --name-only ${base_branch}..HEAD | grep -v '^spec/' | grep --colour=never 'app' | egrep -v '(app\/assets|config/)' | sed -e 's/app\//spec\//' | grep -v '\.rb$' | xargs -n1 -I% echo "%_spec.rb" | tee -a $test_target
  # 3. 実行branchで変更したrubyファイルに対応するspecリストを生成し$test_targetに追加(1で作ったリストと重複する可能性あり)
  git diff --name-only ${base_branch}..HEAD | grep -v '^spec/' | grep --colour=never 'app' | sed -e 's/app\//spec\//' | grep --colour=never '\.rb$' | sed -e 's/\.rb/_spec\.rb/' | tee -a $test_target
  echo "=================================="
  # 重複するspecファイルを削除
  echo ""
  echo "Make test list (sort and uniq)"
  echo "=================================="
  #sort $test_target | uniq > $uniq_list
  sort $test_target | uniq | tee -a $uniq_list
  echo "=================================="
  # execute spec
  echo ""
  echo "Not found test case..."
  echo "=================================="
  find $(cat $uniq_list) -and -type f -print 1>/dev/null
  echo "=================================="
  # リダイレクトにより$test_targetが先に新規ファイル生成されるようなので別に作っておいた$uniq_listから生成
  # find $(cat $test_target) -and -type f -print 2>/dev/null | xargs echo > $test_target
  find $(cat $uniq_list) -and -type f -print 2>/dev/null | xargs echo > $test_target
  echo ""
  echo "bundle exec rspec $(cat $test_target)"
  bundle exec rspec $(cat $test_target)
  rm -v $test_target
  rm -v $uniq_list
}
