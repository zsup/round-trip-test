# A few environment variables to set
deviceId = 'INSERT_DEVICE_ID'
token = 'INSERT_ACCESS_TOKEN'
ipAddress = 'INSERT_LOCAL_IP_ADDRESS'

# Create the basic TCP server.
net = require 'net'
server = net.createServer (c) ->
  console.log "Something connected!"
  c.on 'end', ->
    console.log "Goodbye, something."
  c.on 'data', (data) ->
    incoming++
    report()

server.listen 9000, ->
  console.log "Server is live"

# Set up Sparky
Sparky = require 'sparky'

sparky = new Sparky
  deviceId: deviceId,
  token: token

sparky.run 'connect', ipAddress, ->
  setTimeout count, 5000

# Other helper stuff

moment = require 'moment'

outgoing = 0;
incoming = 0;

report = ->
  console.log moment().format 'h:mm:ss a'
  console.log "Outgoing: #{outgoing}"
  console.log "Incoming: #{incoming}"
  console.log "-----"

count = ->
  sparky.run('ping')
  outgoing++
  report()
  setTimeout count, 5000