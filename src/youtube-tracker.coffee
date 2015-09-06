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

  robot.respond /(?:tracker|ytt)(?: chan)? (.*)/i, (msg) ->
    query = msg.match[1]

QueryYoutube = (res, api, params = {}, handler) ->
  params.key = GOOGLE_API_KEY
  res.http("https://www.googleapis.com/youtube/v3#{api}")
    .query(params)
    .get() (err, httpRes, body) ->
      if err or httpRes.statusCode isnt 200
        err = "503 Service Unavailable" if httpStatus is 503
        res.reply "An error occurred while attemping to process this request."
        return res.robot.logger.error "hubot-youtube-tracker: #{err}"

      handler JSON.parse(body)

