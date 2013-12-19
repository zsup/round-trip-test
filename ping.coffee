# A few environment variables to set
deviceId = '55ff67064989495333582587'
token = '40bbf433bec0decdaf6f1c62226128aec5a11134'
ipAddress = '10.0.1.30'

# Requirements.
net = require 'net'
Sparky = require 'sparky'
moment = require 'moment'
winston = require 'winston'

# Global variables, for counting stuff.
outgoing = 0;
incoming = 0;

# Set up logging.
winston.add winston.transports.File,
  filename: 'roundtrip.log'

# Create the basic TCP server.
server = net.createServer (c) ->
  winston.log 'info', "Something connected!"
  c.on 'end', ->
    winston.log 'info', "Goodbye, something."
  c.on 'data', (data) ->
    incoming++
    report()

server.listen 9000, ->
  winston.log 'info', "Server is live"

# Set up Sparky
sparky = new Sparky
  deviceId: deviceId,
  token: token

sparky.run 'connect', ipAddress, ->
  setTimeout count, 5000

# Our functions for reporting and 
report = ->
  winston.log 'info', moment().format 'h:mm:ss a'
  winston.log 'info', "Outgoing: #{outgoing}"
  winston.log 'info', "Incoming: #{incoming}"
  winston.log 'info', "-----"

count = ->
  sparky.run('ping')
  outgoing++
  report()
  setTimeout count, 5000