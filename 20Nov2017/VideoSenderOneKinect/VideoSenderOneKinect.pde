import processing.video.*;
import java.net.*;
import javax.imageio.*;
import java.io.*;
import java.awt.image.*; 
import org.openkinect.processing.*;
import gab.opencv.*;

OpenCV opencv;

PImage canny;
Kinect2 kinect2;
PImage depthImg;
int minDepth =  500;
int maxDepth =  2600;

PImage bgImage;

// This is the port we are sending to
int clientPort = 9100; 
// This is our object that sends UDP out
DatagramSocket ds; 
// Capture object
// Capture cam;

void setup() {
  //size(640, 480);
  //size(1280, 800);
  fullScreen();
  kinect2 = new Kinect2(this);
  kinect2.initDepth();
  kinect2.initRegistered();
  kinect2.initDevice();
  depthImg = new PImage(kinect2.depthWidth, kinect2.depthHeight);
  opencv = new OpenCV(this, depthImg);
  // Setting up the DatagramSocket, requires try/catch
  try {
    ds = new DatagramSocket();
  } 
  catch (SocketException e) {
    e.printStackTrace();
  }
  background(0);
}

void draw() {
  int[] rawDepth = kinect2.getRawDepth();

  for (int i=0; i < rawDepth.length; i++) {
    if (rawDepth[i] >= minDepth && rawDepth[i] <= maxDepth) {
      depthImg.pixels[i] = color(255);
    } else {
      depthImg.pixels[i] = color(0);
    }
  }
  depthImg.updatePixels();
  opencv.loadImage(depthImg);
  opencv.erode();
  opencv.findCannyEdges(20, 75);
  canny = opencv.getSnapshot();
  
  broadcast(canny);
  
  // Image created in this machine can be seen by uncommenting the below 2 line  
  //image(canny, width/2, height/2);
  //blend(canny, 0, 0, kinect2.depthHeight, kinect2.depthWidth, 0, 0, kinect2.depthHeight, kinect2.depthWidth, OVERLAY);
  //println(canny.width, canny.height);

  //background(loadImage("SilhoutteBanyanTree1.png"));
  bgImage = loadImage("SilhoutteBanyanTree4.jpg");
  image(bgImage, 0, 0);
  canny.resize(0, 300);
  image(canny, 180, 380);
  //bgImage = loadImage("SilhoutteBanyanTree1.png");
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
  println("Sending datagram with " + packet.length + " bytes");
  try {
    ds.send(new DatagramPacket(packet, packet.length, InetAddress.getByName("192.168.18.116"), clientPort));
    //ds.send(new DatagramPacket(packet, packet.length, InetAddress.getByName("192.168.0.2"), clientPort));
  } 
  catch (Exception e) {
    e.printStackTrace();
  }
}