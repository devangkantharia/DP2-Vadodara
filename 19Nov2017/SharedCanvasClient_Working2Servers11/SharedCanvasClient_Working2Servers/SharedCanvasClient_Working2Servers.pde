/**
 * Shared Drawing Canvas (Client) 
 * by Alexander R. Galloway. 
 * 
 * The Processing Client class is instantiated by specifying a remote 
 * address and port number to which the socket connection should be made. 
 * Once the connection is made, the client may read (or write) data to the server.
 * Before running this program, start the Shared Drawing Canvas (Server) program.
 */


import processing.net.*;

Client c1, c2;
String input;
int data[];

void setup() 
{
  size(800, 600);
  background(204);


  frameRate(5); // Slow it down a little
  // Connect to the server's IP address and port
  c1 = new Client(this, "192.168.0.4", 6000); // Replace with your server's IP and port
  c2 = new Client(this, "192.168.0.5", 6000); // Replace with your server's IP and port
}

void draw() 
{
  if (mousePressed == true) {
    // Draw our line
    stroke(127, 196, 0);
    strokeWeight(10);
    line(pmouseX, pmouseY, mouseX, mouseY);
    // Send mouse coords to other person
    c1.write(pmouseX + " " + pmouseY + " " + mouseX + " " + mouseY + "\n");

    c2.write(pmouseX + " " + pmouseY + " " + mouseX + " " + mouseY + "\n");
  }
  // Receive data from server
  if (c1.available() > 0) {
    input = c1.readString();
    input = input.substring(0, input.indexOf("\n")); // Only up to the newline
    data = int(split(input, ' ')); // Split values into an array
    // Draw line using received coords
    stroke(125, 20, 152);
    strokeWeight(10);
    line(data[0], data[1], data[2], data[3]);
  }

  if (c2.available() > 0) {
    input = c2.readString();
    input = input.substring(0, input.indexOf("\n")); // Only up to the newline
    data = int(split(input, ' ')); // Split values into an array
    // Draw line using received coords
    stroke(204, 102, 0);
    strokeWeight(10);
    line(data[0], data[1], data[2], data[3]);
  }
}