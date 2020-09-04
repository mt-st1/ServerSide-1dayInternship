# Eight

[22卒対象 Railsサーバサイド開発 1dayインターン](https://www.wantedly.com/projects/464141)
のレポジトリです。

## 前提条件

- docker,docker-composeがインストールされていること
- gitがインストールされていること


[Dockerの公式サイト](https://docs.docker.com/get-docker/)からインストールしてください。



## 環境構築
まずはリポジトリをcloneします.

```zsh
$ git clone git@github.com:eightcard/ServerSide-1dayInternship.git
```

ディレクトリに移動して、imageのビルド・コンテナの立ち上げを行います。

```zsh
$ cd ServerSide-1dayInternship
$ docker-compose up -d --build
```

ここで全てのコンテナが立ち上がってることを確認しましょう。
```zsh
$ docker-compose ps
                        Name                                       Command               State                       Ports
-----------------------------------------------------------------------------------------------------------------------------------------------
serverside-1dayinternship_app_1              bash -c rm -f tmp/pids/ser ...   Up      0.0.0.0:3000->3000/tcp
serverside-1dayinternship_db_1               docker-entrypoint.sh mysqld      Up      0.0.0.0:3306->3306/tcp, 33060/tcp
serverside-1dayinternship_minio_1            /usr/bin/docker-entrypoint ...   Up      0.0.0.0:9000->9000/tcp
```


確認ができたらデータベースの作成、マイグレーション、仮データの作成を行います。
```
$ docker-compose exec app rails db:create db:migrate db:seed
```

ここまでコマンドを打ち終えたら[http://localhost:3000](http://localhost:3000)を開いて
サーバーが立ち上がっているか確認しましょう！

<img width="1593" alt="スクリーンショット 2020-08-20 15 24 08" src="https://user-images.githubusercontent.com/38460337/90724292-49233680-e2f9-11ea-9aa6-0f23a8513d16.png">
