チュートリアル
==============

Git Challenge へようこそ！

このチュートリアルでは、merge と CONFLICT 解決を学びます。

Git Challenge の問題で扱うファイルは CSV (Comma-Separated Values) です。
このリポジトリにも、`users.csv` という CSV ファイルが含まれています。

では、`master` ブランチにチェックアウトし、この `users.csv` の先頭の3行をみてみましょう。

```sh-session
$ git checkout master
$ cat users.csv
103,419e0896-52f1-4913-a43c-ec3ae62b66b6,渡辺 心愛,Nelda.Price69@hotmail.com,ytEMIatIxHF7r3D,026-292-3312
48,f6fc18cb-b7d3-4e6c-b4f2-2c9422933b9b,田中 美羽,Catalina0@yahoo.com,hf8T7uwgoGJ9CEt,02264-0-2048
6,64157d6b-d84d-417f-b44d-31775d6a134f,斎藤 蓮,Gladyce0@yahoo.com,IgZwbeINDXUV_i3,0059-96-2954
...
```

この CSV には、全 100 人のユーザーの情報が記録されています（ユーザーの情報は架空のものです）。

このユーザーの情報で特に重要なのは、先頭の列です。
先頭の列は、ユーザーの持つチップの数を示しています。

たとえば、以下の行は「渡辺 心愛」さんが 103 枚のチップを持っていることを意味しています。

```csv
103,419e0896-52f1-4913-a43c-ec3ae62b66b6,渡辺 心愛,Nelda.Price69@hotmail.com,ytEMIatIxHF7r3D,026-292-3312
```

ユーザーは、他のユーザーにチップをあげたり、もらったりすることができます。
たとえば、「田中 美羽」さんから「渡辺 心愛」さんへ 10 枚のチップが贈与されたとしましょう。
すると、次のような diff が発生します。

```diff
diff --git a/users.csv b/users.csv
index 9d6ba74..2320034 100644
--- a/users.csv
+++ b/users.csv
@@ -1,5 +1,5 @@
-103,419e0896-52f1-4913-a43c-ec3ae62b66b6,渡辺 心愛,Nelda.Price69@hotmail.com,ytEMIatIxHF7r3D,026-292-3312
-48,f6fc18cb-b7d3-4e6c-b4f2-2c9422933b9b,田中 美羽,Catalina0@yahoo.com,hf8T7uwgoGJ9CEt,02264-0-2048
+113,419e0896-52f1-4913-a43c-ec3ae62b66b6,渡辺 心愛,Nelda.Price69@hotmail.com,ytEMIatIxHF7r3D,026-292-3312
+38,f6fc18cb-b7d3-4e6c-b4f2-2c9422933b9b,田中 美羽,Catalina0@yahoo.com,hf8T7uwgoGJ9CEt,02264-0-2048
 6,64157d6b-d84d-417f-b44d-31775d6a134f,斎藤 蓮,Gladyce0@yahoo.com,IgZwbeINDXUV_i3,0059-96-2954
 134,4048db0f-2454-477a-870b-a007ea21df2b,松本 心愛,Ephraim.Weber@yahoo.com,6f1SkLgu2dy58sE,07614-8-7370
 275,9f2fe7d1-a5b0-41b7-802c-8a7ed93baf48,斎藤 結愛,Alene88@gmail.com,NKe7ZYrTgzd0MF5,00271-1-8209
```

Git Challenge では、このようなユーザーの取引履歴を 1 commit として管理しています。

では、このような commit の merge を体験してみましょう。
merge 対象の commit は、`task-1` に用意してあります。

これを `master` に merge してみましょう。

```sh-session
$ git checkout task-1
$ git checkout master
$ git merge task-1
```

うまく merge できましたね！

では、もう一回 merge を体験してみましょう。
`task-2` に、もうひとつ作業履歴を用意してあります。

```sh-session
$ git checkout task-2
$ git checkout master
$ git merge task-2
Auto-merging users.csv
CONFLICT (content): Merge conflict in users.csv
Automatic merge failed; fix conflicts and then commit the result.
```

おや？エラーメッセージが表示されますね。

このエラーは、`task-1` と `task-2` に、重複した変更がおこなわれたことを示しています（CONFLICT と呼びます）。
まず、`task-2` の変更内容を確認してみましょう。

```sh-session
$ git show task-2
```

`task-2` では、次のように取引されていたようです。

```diff
diff --git a/users.csv b/users.csv
index 9d6ba74..118f601 100644
--- a/users.csv
+++ b/users.csv
@@ -1,6 +1,6 @@
-103,419e0896-52f1-4913-a43c-ec3ae62b66b6,渡辺 心愛,Nelda.Price69@hotmail.com,ytEMIatIxHF7r3D,026-292-3312
+93,419e0896-52f1-4913-a43c-ec3ae62b66b6,渡辺 心愛,Nelda.Price69@hotmail.com,ytEMIatIxHF7r3D,026-292-3312
 48,f6fc18cb-b7d3-4e6c-b4f2-2c9422933b9b,田中 美羽,Catalina0@yahoo.com,hf8T7uwgoGJ9CEt,02264-0-2048
-6,64157d6b-d84d-417f-b44d-31775d6a134f,斎藤 蓮,Gladyce0@yahoo.com,IgZwbeINDXUV_i3,0059-96-2954
+16,64157d6b-d84d-417f-b44d-31775d6a134f,斎藤 蓮,Gladyce0@yahoo.com,IgZwbeINDXUV_i3,0059-96-2954
 134,4048db0f-2454-477a-870b-a007ea21df2b,松本 心愛,Ephraim.Weber@yahoo.com,6f1SkLgu2dy58sE,07614-8-7370
 275,9f2fe7d1-a5b0-41b7-802c-8a7ed93baf48,斎藤 結愛,Alene88@gmail.com,NKe7ZYrTgzd0MF5,00271-1-8209
 51,64e200ea-710f-45c4-a9ff-7e6f8f8b077b,山口 結菜,Tod49@gmail.com,REOGU4yZdPhBIg7,097-523-9207
```

先頭行の「渡辺 心愛」さんのチップに注目すると、`task-1` と `task-2` の両方で変更がされていることが確認できます。

それでは、`task-1` と `task-2` の2つの取引をうまく解決してあげましょう。
それぞれの取引の意図は次のとおりです。

- `task-1`: 「田中 美羽」さんから「渡辺 心愛」さんへ 10 枚のチップを贈与
- `task-2`: 「渡辺 心愛」さんから「斎藤 蓮」さんへ 10 枚のチップを贈与

つまり、最終的な取引結果は、次のようになるはずですね。

- 「渡辺 心愛」さんのチップ: `103 + 10 - 10 = 103`
- 「田中 美羽」さんのチップ: `48 - 10 = 38`
- 「斎藤 蓮」さんのチップ: `6 + 10 = 16`

では、この CONFLICT の解決に移りましょう。

`users.csv` をエディタで開くと、次のように CONFLICT した箇所に印がついています。

```csv
<<<<<<< HEAD
113,419e0896-52f1-4913-a43c-ec3ae62b66b6,渡辺 心愛,Nelda.Price69@hotmail.com,ytEMIatIxHF7r3D,026-292-3312
38,f6fc18cb-b7d3-4e6c-b4f2-2c9422933b9b,田中 美羽,Catalina0@yahoo.com,hf8T7uwgoGJ9CEt,02264-0-2048
6,64157d6b-d84d-417f-b44d-31775d6a134f,斎藤 蓮,Gladyce0@yahoo.com,IgZwbeINDXUV_i3,0059-96-2954
=======
93,419e0896-52f1-4913-a43c-ec3ae62b66b6,渡辺 心愛,Nelda.Price69@hotmail.com,ytEMIatIxHF7r3D,026-292-3312
48,f6fc18cb-b7d3-4e6c-b4f2-2c9422933b9b,田中 美羽,Catalina0@yahoo.com,hf8T7uwgoGJ9CEt,02264-0-2048
16,64157d6b-d84d-417f-b44d-31775d6a134f,斎藤 蓮,Gladyce0@yahoo.com,IgZwbeINDXUV_i3,0059-96-2954
>>>>>>> task-2
```

この部分を、下のように書きかえます。

```
103,419e0896-52f1-4913-a43c-ec3ae62b66b6,渡辺 心愛,Nelda.Price69@hotmail.com,ytEMIatIxHF7r3D,026-292-3312
38,f6fc18cb-b7d3-4e6c-b4f2-2c9422933b9b,田中 美羽,Catalina0@yahoo.com,hf8T7uwgoGJ9CEt,02264-0-2048
16,64157d6b-d84d-417f-b44d-31775d6a134f,斎藤 蓮,Gladyce0@yahoo.com,IgZwbeINDXUV_i3,0059-96-2954
```

ファイルを保存したら、git に CONFLICT の解決を教えてあげます。

```sh-session
$ git add users.csv
$ git commit
```

無事 CONFLICT を解決し、merge することができました！
では、他の人がこの取引履歴を使えるように `master` を push しておきましょう。

```sh-session
$ git push origin master
``` 

正しく merge できていれば、[スコアボード](http://git-challenge-scoreboard.herokuapp.com)のバッジが passed に変化します。
スコアボードを確認してみてください。


問題形式について
----------------

問題形式についても確認しておきましょう。
このチュートリアルに相当する問題は、次のように提示されます。

---

### 問題: チュートリアル

`task-1` と `task-2` を `master` に merge してください。

| 主要なブランチ       | ブランチ名        |
|:---------------------|:------------------|
| リリースブランチ     | `master`          |
| merge 対象のブランチ | `task-1` `task-2` |


### 正答条件

- 解答は、`origin` の `master` に push してください
- `task-1` と `task-2` のすべての差分が適用されている必要があります
- push された新しい `master` の祖先に、問題開始時点の `master` が含まれる必要があります

---

なお、解答の方法は、問題ごとに異なります。
そのため、問題に書かれている正答条件をよく確認し、解答してください。

解答の正誤判定は、CIサーバー上のテストスクリプトによっておこなわれます。
このテストスクリプトの判定結果は、スコアボードのバッジによって確認することができます。
正解の場合は、バッジは passed になります。
正解でない場合は、failed になります。

また、いずれの問題も、複数回解答することが可能です。

チュートリアルは以上になります。
