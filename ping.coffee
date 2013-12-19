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
  console.log "Server is bound"

# Set up Sparky
Sparky = require 'sparky'

sparky = new Sparky
  deviceId: '55ff67064989495333582587',
  token: '40bbf433bec0decdaf6f1c62226128aec5a11134'

console.log server.address()

sparky.run 'connect', '10.0.1.30', ->
  setTimeout count, 5000

outgoing = 0;
incoming = 0;

report = ->
  console.log "Outgoing: #{outgoing}"
  console.log "Incoming: #{incoming}"
  console.log "-----"

count = ->
  sparky.run('ping')
  outgoing++
  report()
  setTimeout count, 5000