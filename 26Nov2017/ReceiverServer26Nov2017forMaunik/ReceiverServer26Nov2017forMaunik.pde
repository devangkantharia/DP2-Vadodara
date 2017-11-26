// Daniel Shiffman
// <http://www.shiffman.net>

//My IP : 192.168.14.64
//My Port : 9999

// A Thread using receiving UDP to receive images

import java.awt.image.*; 
import javax.imageio.*;
import java.net.*;

import java.net.*;
import java.io.*; 
import gab.opencv.*;



PImage video;
ReceiverThread thread1, thread2;


// Server Sender Data to PC1
// This is the port we are sending to
int ServerPort = 9999; 
// This is our object that sends UDP out
DatagramSocket NewServerDataSocket1;
DatagramSocket NewServerDataSocket2; 
OpenCV opencv;
PImage canny;
PImage ServerImage;



PGraphics output;

void setup() {
  size(1400, 500);
  //fullScreen(2);
  video = createImage(512, 424, RGB);
  thread1 = new ReceiverThread(video.width, video.height, 9100);
  thread2 = new ReceiverThread(video.width, video.height, 9101);
  thread1.start();
  thread2.start();

  // Setting up the DatagramSocket, requires try/catch
  try {
    NewServerDataSocket1 = new DatagramSocket();
    NewServerDataSocket2 = new DatagramSocket();
  } 
  catch (SocketException e) {
    e.printStackTrace();
  }
  output = createGraphics(1400, 500, JAVA2D);
  background(0);
}

void draw() {
  
  
  
  if (thread1.available()) {
    video = thread1.getImage();
    image(video, 100, 100);
    //image(video, 800, 100);
    //println("thread1 : " + video.height, video.width);
    //broadcast(video);
    
  }
  if (thread2.available()) {
    video = thread2.getImage();
    //image(video, 100, 100);
    image(video, 800, 100);
    //println("thread2 : " + video.height, video.width);
    //broadcast(video);  
  }
  
  ServerImage = get();

  ServerImage.updatePixels();
  ServerImage.save("#####.png");
  
  broadcast(ServerImage);
  

  //println("thread : " + video.height, video.width);

  //imageMode(CENTER);
  //image(video1, width/2, height/2);
  //image(video, 512, 424);

  /*
  rect(0, 0, 10, 10);
   rect(512, 424, 10, 10);
   rect(1920-512, 1080-424, 10, 10);
   */
}









// Function to broadcast a PImage over UDP
// Special thanks to: http://ubaa.net/shared/processing/udp/
// (This example doesn't use the library, but you can!)
void broadcast(PImage img) {

  // We need a buffered image to do the JPG encoding
  BufferedImage bimg = new BufferedImage( img.width, img.height, BufferedImage.TYPE_INT_RGB );

  // Transfer pixels from localFrame to the BufferedImage
  img.loadPixels();
  bimg.setRGB( 0, 0, img.width, img.height, img.pixels, 0, img.width);

  // Need these output streams to get image as bytes for UDP communication
  ByteArrayOutputStream baStream  = new ByteArrayOutputStream();
  BufferedOutputStream bos    = new BufferedOutputStream(baStream);

  // Turn the BufferedImage into a JPG and put it in the BufferedOutputStream
  // Requires try/catch
  try {
    //ImageIO.write(bimg, "jpg", bos);
    ImageIO.write(bimg, "png", bos);
  } 
  catch (IOException e) {
    e.printStackTrace();
  }

  // Get the byte array, which we will send out via UDP!
  byte[] packet = baStream.toByteArray();

  // Send JPEG data as a datagram
  //println("Sending datagram with " + packet.length + " bytes");
  try {

    // Devang's Dell IP
    NewServerDataSocket1.send(new DatagramPacket(packet, packet.length, InetAddress.getByName("192.168.18.229"), ServerPort));

    // Ashish's Machine IP
    NewServerDataSocket2.send(new DatagramPacket(packet, packet.length, InetAddress.getByName("192.168.18.168"), ServerPort));
    //ds.send(new DatagramPacket(packet, packet.length, InetAddress.getByName("192.168.0.2"), clientPort));
  } 
  catch (Exception e) {
    e.printStackTrace();
  }
}