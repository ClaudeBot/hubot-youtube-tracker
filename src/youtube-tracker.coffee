# Description
#   A Hubot script for tracking YouTube
#
# Configuration:
#   GOOGLE_API_KEY is required to make use of this script.
#
# Commands:
#   hubot ytt recent <channel> - Get the last 3 videos uploaded to <channel>
#
# Notes:
#   This script is a work in progress...
#
# Author:
#   Karl Birch <mbwkarl@gmail.com>

GOOGLE_API_KEY = process.env.GOOGLE_API_KEY

module.exports = (robot) ->
  if not GOOGLE_API_KEY?
    return robot.logger.error "hubot-youtube-tracker: Missing GOOGLE_API_KEY in environment.  Please set and try again."

  robot.respond /ytt recent (.+)/i, id: "youtube.tracker.recent", (res) ->
    query = res.match[1]
    # get channel
    QueryYoutube res, '/channels', { part: 'contentDetails', forUsername: query }, (channelObject) ->
      if not channelObject.items[0]
        res.send "No channel found"
        return
      uploadsId = channelObject.items[0].contentDetails.relatedPlaylists.uploads
      # get playlist
      QueryYoutube res, '/playlistItems', { part: 'snippet', playlistId: uploadsId, maxResults: 3 }, (playlistObject) ->
        if playlistObject.items.length == 0
          res.send "No videos in the channel"
          return
        resstr = ""
        for item in playlistObject.items
          resstr += "#{item.snippet.title} | https://youtu.be/#{item.snippet.resourceId.videoId}\n"
        res.send resstr

QueryYoutube = (res, api, params = {}, handler) ->
  params.key = GOOGLE_API_KEY
  res.http("https://www.googleapis.com/youtube/v3#{api}")
    .query(params)
    .get() (err, httpRes, body) ->
      if err or httpRes.statusCode isnt 200
        err = "503 Service Unavailable" if httpRes.statusCode is 503
        res.reply "An error occurred while attemping to process this request."
        return res.robot.logger.error "hubot-youtube-tracker: #{err}"

      handler JSON.parse(body)

