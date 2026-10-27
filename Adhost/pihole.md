# **Pi-hole で Adhost を使う**

[Pi-hole](https://pi-hole.net/) のブロックリスト（Adlist）に Adhost を登録する手順です。\
登録しておくと、Pi-hole の定期更新で最新のリストが自動的に取り込まれます。

## 登録する URL

どれか **1 つ** を登録してください（中身のホストはすべて同じです）。

| ファイル | URL | 備考 |
|---|---|---|
| hostlist.txt | `https://raw.githubusercontent.com/flarebrow/public/master/Adhost/hostlist.txt` | ホスト名のみ。いちばん軽いのでおすすめ |
| hosts2 | `https://raw.githubusercontent.com/flarebrow/public/master/Adhost/hosts2` | `0.0.0.0 ホスト名` 形式 |
| hosts | `https://raw.githubusercontent.com/flarebrow/public/master/Adhost/hosts` | `127.0.0.1 ホスト名` 形式 |

## Web 画面から登録する

### Pi-hole v6

1. 管理画面（`http://pi.hole/admin` など）にログイン
2. 左メニューの **Lists** を開く
3. **Address** に上の URL を貼り付け、**Comment** に `Adhost` などと入力
4. **Add blocklist** をクリック
5. 左メニューの **Tools** → **Update Gravity** を開き、**Update** をクリック

### Pi-hole v5

1. 管理画面にログイン
2. 左メニューの **Group Management** → **Adlists** を開く
3. **Address** に上の URL を貼り付け、**Comment** に `Adhost` などと入力
4. **Add** をクリック
5. 左メニューの **Tools** → **Update Gravity** を開き、**Update** をクリック

## コマンドで登録する

v5 / v6 どちらでも使えます。

```sh
sudo sqlite3 /etc/pihole/gravity.db \
  "INSERT INTO adlist (address, enabled, comment) VALUES ('https://raw.githubusercontent.com/flarebrow/public/master/Adhost/hostlist.txt', 1, 'Adhost');"
pihole -g
```

## 登録できたか確認する

```sh
pihole -q example.com
```

リストに含まれるホスト名を指定すると、登録した URL が結果に表示されます。

## 更新について

Adhost のリストは毎日自動で更新しています。\
Pi-hole 側は標準で週 1 回 Gravity を更新するので、特に設定しなくても最新のリストが反映されます。\
すぐに反映したいときは `pihole -g` を実行してください。

<strong>＜注意＞</strong>\
約 200 万件のホストが登録されているため、Gravity の更新に時間がかかったり、メモリの少ない機器（Raspberry Pi Zero など）では動作が重くなる場合があります。\
必要なサイトやアプリが使えなくなった場合は、そのホストを Pi-hole の許可リスト（Allowlist / Whitelist）に追加してください。\
アプリ内広告（AdMob など）のホストも含まれているため、一部のアプリで動作に影響が出る場合があります。
