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


## Sample Interaction
```
user1>>   Claudebot ytt recent Shouhei6015  
hubot>> 【Mad Max 実況 Part㉔】もはや気分はケンシロウ！【日本語字幕付き】 | https://youtu.be/wCfL5YTAW9c  
hubot>> 【Mad Max 実況 Part㉓】もはや気分はケンシロウ！【日本語字幕付き】 | https://youtu.be/UCBAZ7M0glc  
hubot>> 【Mad Max 実況 Part㉒】もはや気分はケンシロウ！【日本語字幕付き】 | https://youtu.be/PKijI-zpsXA  
```
