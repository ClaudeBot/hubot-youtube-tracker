chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'youtube-tracker', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()

    require('../src/youtube-tracker')(@robot)

  it 'registers listener for recent', ->
    expect(@robot.respond).to.have.been.calledWith(/ytt recent (.+)/i)
