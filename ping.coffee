# A few environment variables to set
deviceId = 'INSERT_DEVICE_ID'
token = 'INSERT_ACCESS_TOKEN'
ipAddress = 'INSERT_LOCAL_IP'

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
  setTimeout ping, 5000

# Report the counts whenever they change
report = ->
  winston.log 'info', moment().format 'h:mm:ss a'
  winston.log 'info', "Outgoing: #{outgoing}"
  winston.log 'info', "Incoming: #{incoming}"
  winston.log 'info', "-----"

# Ping the Spark Core every 5s
ping = ->
  sparky.run('ping')
  outgoing++
  report()
  setTimeout ping, 5000