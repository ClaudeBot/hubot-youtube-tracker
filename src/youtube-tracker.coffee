# Description
#   A Hubot script for tracking YouTube
#
# Configuration:
#   GOOGLE_API_KEY is required to make use of this script.
#
# Commands:
#   <none>
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   Karl Birch <mbwkarl@gmail.com>

GOOGLE_API_KEY = process.env.GOOGLE_API_KEY

querystring = require 'querystring'
url = require 'url'

module.exports = (robot) ->
  if not GOOGLE_API_KEY?
    return robot.logger.error "hubot-youtube-tracker: Missing GOOGLE_API_KEY in environment.  Please set and try again."

  robot.respond /(?:tracker|ytt) recent (.*)/i, (res) ->
    query = res.match[1]
    # get channel
    QueryYoutube res, '/channels', { part: 'contentDetails,snippet', forUsername: query }, (channelObject) ->
      channelUrl = 'https://youtube.com/channel/' + channelObject.items[0].id + '/videos'
      username = channelObject.items[0].snippet.title
      uploadsId = channelObject.items[0].contentDetails.relatedPlaylists.uploads
      # get playlist
      QueryYoutube res, '/playlistItems', { part: 'snippet', playlistId: uploadsId, maxResults: 5 }, (playlistObject) ->
        videos = []
        for item in playlistObject.items
          videos.push( { title: item.snippet.title, id: item.snippet.resourceId.videoId } )
        resstr = "#{username}: #{channelUrl}"
        for v in videos
          resstr += '\n' + v.title + " | https://youtu.be/" + v.id
        res.send resstr

QueryYoutube = (res, api, params = {}, handler) ->
  params.part = 'contentDetails,snippet'
  params.key = GOOGLE_API_KEY
  res.http("https://www.googleapis.com/youtube/v3#{api}")
    .query(params)
    .get() (err, httpRes, body) ->
      if err or httpRes.statusCode isnt 200
        err = "503 Service Unavailable" if httpRes.statusCode is 503
        res.reply "An error occurred while attemping to process this request."
        return res.robot.logger.error "hubot-youtube-tracker: #{err}"

      handler JSON.parse(body)

