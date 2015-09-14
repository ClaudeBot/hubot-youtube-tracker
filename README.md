# hubot-youtube-tracker

A Hubot script for tracking YouTube

See [`src/youtube-tracker.coffee`](src/youtube-tracker.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-youtube-tracker --save`

Then add **hubot-youtube-tracker** to your `external-scripts.json`:

```json
[
  "hubot-youtube-tracker"
]
```


## Commands

Command | Listener ID | Description
--- | --- | ---
hubot ytt recent `channel` | `youtube.tracker.recent` | Get a list of the last 3 videos uploaded to a channel

