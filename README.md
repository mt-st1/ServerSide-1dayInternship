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
serverside-1dayinternship_elastic_search_1   /docker-entrypoint.sh elas ...   Up      0.0.0.0:9200->9200/tcp, 0.0.0.0:9300->9300/tcp
serverside-1dayinternship_minio_1            /usr/bin/docker-entrypoint ...   Up      0.0.0.0:9000->9000/tcp
```


確認できたらdb:createコマンドでデータベースの作成を行います。
```
$ docker-compose exec app rails db:create
```

ここまでコマンドを打ち終えたら[http://localhost:3000](http://localhost:3000)を開いて
サーバーが立ち上がっているか確認しましょう！

<img src="https://user-images.githubusercontent.com/38460337/87537763-21c3c300-c6d6-11ea-91db-734c810abd47.png" alt="Ruby on Rails">
