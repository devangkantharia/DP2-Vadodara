// Daniel Shiffman
// <http://www.shiffman.net>

// A Thread using receiving UDP
import java.net.*;
import java.io.*;
class ReceiverThread extends Thread {
  // Port we are receiving.
  int port22;
  DatagramSocket ds22; 
  // A byte array to read into (max size of 65536, could be smaller)
  byte[] buffer22 = new byte[65536]; 

  boolean running22;    // Is the thread running?  Yes or no?
  boolean available22;  // Are there new tweets available?

  // Start with something 
  PImage img22;

  // InetAddress ip, ip1;
  // int sender = 0;

  ReceiverThread (int w, int h, int p) {
    port22 = p;
    img22 = createImage(w, h, RGB);

    running22 = false;
    available22 = true; // We start with "loading . . " being available

    try {
      ds22 = new DatagramSocket(port22);
    } 
    catch (SocketException e) {
      e.printStackTrace();
    }
  }

  PImage getImage22() {
    // We set available equal to false now that we've gotten the data
    available22 = false;

    /*if (ip1 == null) {
     ip1 = ip;
     sender = 1;
     } 
     else {
     if(ip.equals(ip1)){
     sender = 1;
     }
     else{
     sender = 2;
     }
     }*/

    return img22;
  }

  boolean available() {
    return available22;
  }

  // Overriding "start()"
  void start () {
    running22 = true;
    super.start();
  }

  // We must implement run, this gets triggered by start()
  void run () {
    while (running22) {
      checkForImage22();
      // New data is available!
      available22 = true;
    }
  }

  void checkForImage22() {
    DatagramPacket p22 = new DatagramPacket(buffer22, buffer22.length); 
    try {
      ds22.receive(p22);
    } 
    catch (IOException e) {
      e.printStackTrace();
    } 
    byte[] data22 = p22.getData();

    // ip = p.getAddress();
    //println("datagram address " +  ip);

    /*if (ip1 == null) {
     ip1 = ip;
     sender = 1;
     } 
     else {
     if(ip.equals(ip1)){
     sender = 1;
     }
     else{
     sender = 2;
     }
     }*/

    // println("sender :  " +  sender + " : " + ip);

    //println("Received datagram with " + data.length + " bytes." );

    // Read incoming data into a ByteArrayInputStream
    ByteArrayInputStream bais = new ByteArrayInputStream( data22 );

    // We need to unpack JPG and put it in the PImage img
    img22.loadPixels();
    try {
      // Make a BufferedImage out of the incoming bytes
      BufferedImage bimg = ImageIO.read(bais);
      // Put the pixels into the PImage
      bimg.getRGB(0, 0, img22.width, img22.height, img22.pixels, 0, img22.width);
    } 
    catch (Exception e) {
      e.printStackTrace();
    }
    // Update the PImage pixels
    img22.updatePixels();
  }


  // Our method that quits the thread
  void quit() {
    System.out.println("Quitting."); 
    running22 = false;  // Setting running to false ends the loop in run()
    // In case the thread is waiting. . .
    interrupt();
  }
}