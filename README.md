Round trip test
===============

Testing round-trip communications with the Spark Core and Spark Cloud.

Instructions
---

Requires Node.js, npm, and coffeescript. Your computer and your Spark Core must be running on the same network.

1. Copy the contents of `pong.cpp` into the [Spark Build](https://www.spark.io/build) web IDE 
2. Flash the code to your Spark Core
3. `npm install`
4. Prep `ping.coffee` by adding your `Device ID`, `Access Token`, and `Local IP address` at the top of the file.
5. Run `coffee ping.coffee`. If your Core is working as expected, it should connect to your computer almost immediately.
