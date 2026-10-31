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
image: images/hop.webp
```

- `name`, `link` and `image` are required; everything else is optional.
- `image` can be a full web address or a file you put in `images/`. Any shape works. Small WebP files load fastest (squoosh.app converts a picture in a few clicks).
- `type`: えいご, せかい or タイピング. Write a new word and a new category button appears.
- `created:` and `updated:` (year-month-day, like 2026-10-31) put the game in order automatically. Games made in the last 14 days come first with NEW!, then the rest by latest update, with UPDATE! for 14 days after an update. Just change `updated:` when you improve a game.
- `new: yes` forces a NEW! badge.
- The card colour is taken from the picture. Add `color: #RRGGBB` to choose it yourself.

Games with dates are ordered automatically; games without dates stay in file order after them. The banner, the category buttons and their counts all update on their own.

## Syncing (home and work)

Double-click **`sync-site.bat`** whenever you start or finish editing `games.js`.

- GitHub is newer: it downloads the update.
- You changed something: it uploads it, and the site updates in about a minute.
- Both changed: it warns you and lets you choose to merge, keep GitHub's version, or keep yours. Whatever you don't keep is saved in a backup branch first.


## Adding a game
Copy the block at the top of `games.js`, fill it in, add a 760x400 `.webp` to `images/`, run `sync-site.bat`. The ALT homepage picks it up automatically. NEW/UPDATE badges expire after 14 days on their own.
