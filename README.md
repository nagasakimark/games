# えいごゲームひろば

Mark Sensei's games hub for elementary students. Live at https://nagasakimark.github.io/games/

## Adding a game

Open **`games.js`** and add a block like this (one empty line between games):

```
name: メガネホップ
english: Megane Hop
type: えいご
about: 音を きいて、いしを ぴょんぴょん！
learn: フォニックス
link: https://nagasakimark.github.io/hop/
image: images/hop.jpg
```

- `name`, `link` and `image` are required; everything else is optional.
- `image` can be a full web address or a file you put in `images/`. Any shape works.
- `type`: えいご, せかい or タイピング. Write a new word and a new category button appears.
- `new: yes` puts a NEW! badge on the game.
- The card colour is taken from the picture. Add `color: #RRGGBB` to choose it yourself.

Games appear in the same order as the file. The banner, the category buttons and their counts all update on their own.

## Syncing (home and work)

Double-click **`sync-site.bat`** whenever you start or finish editing `games.js`.

- GitHub is newer: it downloads the update.
- You changed something: it uploads it, and the site updates in about a minute.
- Both changed: it warns you and lets you choose to merge, keep GitHub's version, or keep yours. Whatever you don't keep is saved in a backup branch first.
