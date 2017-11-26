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

//New Server Data Receiving Initialization - Start
  PImage NewServerData;
  ReceiverThread NewServerThread;
//New Server Data Receiving Initialization - End


// This is the port we are sending to
int clientPort = 9100; 
// This is our object that sends UDP out
DatagramSocket ds; 
// Capture object
// Capture cam;

void setup() {
  //size(320,240);
  //size(1400, 500);
  //size(1400, 500);
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
  } catch (SocketException e) {
    e.printStackTrace();
  }
  
  //New Server Data Setup - Start
    //NewServerData = createImage(512, 424, RGB);
   
    NewServerData = createImage(1400, 500, RGB);
    NewServerThread = new ReceiverThread(NewServerData.width, NewServerData.height, 9999);
    NewServerThread.start();

  //New Server Data Setup - End
}




void draw() {
  int[] rawDepth = kinect2.getRawDepth();
  for (int i=0; i < rawDepth.length; i++) {
    if (rawDepth[i] >= minDepth && rawDepth[i] <= maxDepth) {
      depthImg.pixels[i] = color(0);
    } else {
      depthImg.pixels[i] = color(255);
    }
  }
  depthImg.updatePixels();
  opencv.loadImage(depthImg);
  opencv.erode();
  opencv.findCannyEdges(20, 75);
  canny = opencv.getSnapshot();
  broadcast(canny);
  
  /* This System Display Code - Start */
  //bgImage = loadImage("SilhoutteBanyanTree4.jpg");
  //image(bgImage, 0, 0);
  canny.resize(0, 300);
  image(canny, 180, 380);
  /* This System Display Code - Start */
  
  /* New Server Data Receiving Pattern - Start */
  if (NewServerThread.available()) {
    println("Received other's data from server");
    NewServerData = NewServerThread.getImage22();
    image(NewServerData, 0, 0);
  //  //image(video, 800, 100);
  }
  /* New Server Data Receiving Pattern - End */
  
  
}


// Function to broadcast a PImage over UDP
// Special thanks to: http://ubaa.net/shared/processing/udp/
// (This example doesn't use the library, but you can!)
void broadcast(PImage img) {

  // We need a buffered image to do the JPG encoding
  BufferedImage bimg = new BufferedImage( img.width,img.height, BufferedImage.TYPE_INT_RGB );

  // Transfer pixels from localFrame to the BufferedImage
  img.loadPixels();
  bimg.setRGB( 0, 0, img.width, img.height, img.pixels, 0, img.width);

  // Need these output streams to get image as bytes for UDP communication
  ByteArrayOutputStream baStream	= new ByteArrayOutputStream();
  BufferedOutputStream bos		= new BufferedOutputStream(baStream);

  // Turn the BufferedImage into a JPG and put it in the BufferedOutputStream
  // Requires try/catch
  try {
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
    //ds.send(new DatagramPacket(packet,packet.length, InetAddress.getByName("192.168.18.116"),clientPort));
    ds.send(new DatagramPacket(packet,packet.length, InetAddress.getByName("192.168.14.64"),clientPort));
  } 
  catch (Exception e) {
    e.printStackTrace();
  }
}