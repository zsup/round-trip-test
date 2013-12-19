TCPClient client;

void setup() {
    Serial.begin(9600);
    
    Spark.function("connect", connect_to_my_server);
    Spark.function("ping", pong);
}

void loop() {
  if (client.connected()) {
    if (client.available()) {
      char pin = client.read();
      char level = client.read();
      digitalWrite(pin - '0' + D0, 'h' == level ? HIGH : LOW);
    }
  }
}

int connect_to_my_server(String ip) {
    byte server_address[4];
    ip_array_from_string(server_address, ip);
    
    if (client.connect(server_address, 9000)) {
        return 1; // successfully connected
    } else {
        return -1; // failed to connect
    }
}

int pong(String args) {
    if (client.connected()) {
        client.write(1);
        return 1;
    }
    else {
        return -1;
    }
}

void ip_array_from_string(byte ip_array[], String ip_string) {
    
    String first = ip_string.substring(0, ip_string.indexOf('.'));
    String remaining1 = ip_string.substring(ip_string.indexOf('.')+1);
    String second = remaining1.substring(0, remaining1.indexOf('.'));
    String remaining2 = remaining1.substring(remaining1.indexOf('.')+1);
    String third = remaining2.substring(0, remaining2.indexOf('.'));
    String fourth = remaining2.substring(remaining2.lastIndexOf('.')+1);
    
    ip_array[0] = first.toInt();
    ip_array[1] = second.toInt();
    ip_array[2] = third.toInt();
    ip_array[3] = fourth.toInt();
}