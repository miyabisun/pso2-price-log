# Overview: 概要

PSO2のアイテムの相場をGoogleスプレッドシートで管理する為のツールです。  
クライアント改ざんやパケット解析は行っていないので、禁止事項に抵触することは無いとは思いますが、  
もし運営側がNGを出したら利用を中止してください。

対象: Windows 10 (多分Windows 7でも動作する)  
非対象: PS4, PS Vita

# Installation: インストール方法

## Google Spreadsheet Setting

1. [Googleアカウント](https://accounts.google.com/)にログイン
2. [Google スプレッドシート](https://docs.google.com/spreadsheets/u/0/)にアクセス
3. ページ右下の(＋)ボタンをクリックして新しいシートを作成
4. [雛形の相場シート](https://docs.google.com/spreadsheets/d/176trro5zJ8kMnhVLnKPg90OCR_UtixrFGF-w96tqkQw/edit#gid=1171069716)にアクセス
5. 相場シートを右クリック > 別のワークブックにコピー... を選択して2で作成したブックにコピーする

## Google Development Setting

難易度が高いので別の方法を検討中...  
もしVersion2がリリースされればこの項目はなくなるか簡略化される予定です。

1. [Google developers サイト](https://console.developers.google.com/)にアクセスしてプロジェクトを作成する  
    プロジェクト名は何でもOK (例: pso2)
2. 画面左のメニューから「認証情報」を選択
3. 「認証情報を作成」→「サービス アカウント キー」の順に選択
4. 以下のように設定し、「作成」ボタンをクリック
    - サービス アカウント: 新しいサービス アカウント
    - サービス アカウント名: pso2
    - 役割: ストレージ > ストレージオブジェクト閲覧者
    - キーのタイプ: JSON
5. 登録情報のJSONファイルがダウンロードされる
6. ダウンロードしたJSONファイルを「pso2.json」に名称変更
7. ユーザーのホームディレクトリに「pso2.json」を移動

## Application

1. [pso2-price-log.zip](https://github.com/miyabisun/pso2-price-log/raw/master/dist/pso2-price-log.zip)をDL
2. DLしたZIPファイルを解凍してpso2-price-log.exeを取り出す

# Uninstall: アンインストール

レジストリ等は特に使用していないので、そのままゴミ箱に放り込んでください。  
ただし、Google Develoment関連の設定がアカウントに紐付いてしまっているので削除しておきます。

1. [Google Cloud Platformのダッシュボード](https://console.cloud.google.com/)にアクセス
2. ダッシュボードの左上に`プロジェクト情報`があるので、`プロジェクト設定を管理`をクリック
3. 設定画面に遷移するので、`削除`ボタンをクリック

# Usage: 使い方

## CommandList

pso2-price-log.exe(以下アプリ)を起動すると、SEGAフォルダ内のChatLogYYYYMMDD_00.txtを監視し始めます。  
そうしてPSO2内のパーティーチャットに擬似的に下記のコマンドを追加します。  
また、`/p /prev`等のようにパーティーチャット指定でも動作するので、ショートカットに登録する場合は先頭に`/p`を指定しておくと誤爆がなくなります。

- `/init <sheet_id> <sheet_name>`  
    Googleスプレッドシートを読み込む。  
    読み込み完了後は更新モードになり、最初のアイテムがクリップボードに登録される。
- `/refresh`  
    Googleスプレッドシートを読み直して`/init`直後の状態に戻す。
- `/all`  
    「更新」の値に関わらず、全てのアイテムを取得する。
- `/select`  
    「更新」が1のアイテムだけ取得してくる。  
    初期状態ではこの状態になっている。
- `/exit`  
    ロードしたGoogleスプレッドシートの情報を破棄する。  
    利用を再開する場合`/init`を実行する。
- `/regist`  
    登録モードに変更する。  
    パーティーチャットで`アイテム名,価格`を発言するとシートの末尾に登録される。  
    価格は省略可能で`アイテム名`のみを発言すると、自動的に`10,000`メセタで仮登録される。
- `/end`  
    登録モードを終了して更新モードに変更する。
- `/add <item_name>[,item_price]`  
    更新モードからでもアイテムを登録する。
- `/prev`  
    1つ前のアイテムを指定し、クリップボードに格納する。  
    タイプミスや相場を更新したアイテムの価格が思ったより安くて買い足す等の用途に使われる。
- `/skip`  
    アイテムの相場は更新せず、更新日時だけを最新に変更する。

## Regist: 登録

1. pso2-price-log.exe(以下アプリ)を起動
2. PSO2内のパーティーチャットで`/init [シートID] [シート名]`と発言
3. PSO2内のパーティーチャットで`/regist`と発言
4. アプリが更新モードに置き換わる
5. PSO2内のパーティーチャットで`アイテム名,価格`を発言
6. アプリがGoogleスプレッドシートの「名称」「仕入れ値」「登録日時」に反映  
    ※名称欄はユニークであるとみなすので、すでに同じアイテムが登録されている場合は登録されない
7. 全てのアイテムが登録し終わったらパーティーチャットで`/end`と発言

## Update: 更新

1. pso2-price-log.exe(以下アプリ)を起動
2. PSO2内のパーティーチャットで`/init [シートID] [シート名]`と発言
3. アプリがGoogleスプレッドシートにアクセス
4. アプリが対象アイテムを検索し、クリップボードを更新する  
    ※対象アイテム: 更新日時が空欄・もしくは最も古いアイテム
5. PSO2内のパーティーチャットで金額を発言 `例: 150k`
6. アプリがGoogleスプレッドシートの「相場」「更新日時」を更新
7. 次のアイテムがクリップボードに設定される (5に戻る)
8. 中断する時はアプリを終了するか、パーティーチャットで`/exit`と発言

# Dependences

- [Node.js](https://nodejs.org/ja/)
- [Enclose](http://enclosejs.com/): Node.js => Native Windows APP
- [7ZIP](https://sevenzip.osdn.jp/): Native Windows APP => ZIP

# Links

- [相場チェックシート](https://docs.google.com/spreadsheets/d/176trro5zJ8kMnhVLnKPg90OCR_UtixrFGF-w96tqkQw/edit?usp=sharing)
- [AC・SG・FUNスクラッチ - PSO2 Player's Site](http://pso2.jp/players/catalog/scratch/)
- [Configuring your Windows development environment](https://github.com/Microsoft/nodejs-guidelines/blob/master/windows-environment.md)
- [インストールしないでzipや7z圧縮ファイルを作る方法 - 7ZIP](https://sevenzip.osdn.jp/howto/non-install-compress.html)

