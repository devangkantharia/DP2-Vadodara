// Daniel Shiffman
// <http://www.shiffman.net>

// A Thread using receiving UDP to receive images

import java.awt.image.*; 
import javax.imageio.*;

PImage video1;
PImage video2;

ReceiverThread thread1;
//ReceiverThread thread2;

HashMap<String, PImage> videoObject = new HashMap<String, PImage>(); // Gets you IP Address of the sender and the PImage. 

void setup() {
  size(800, 800);
  //fullScreen(2);
  video1 = createImage(512, 424, RGB);
  thread1 = new ReceiverThread(video1.width, video1.height);
  thread1.start();
  
  //video2 = createImage(512, 512, RGB);
  //thread2 = new ReceiverThread(video2.width, video2.height);
  //thread2.start();
}

void draw() {
  if (thread1.available()) {
    video1 = thread1.getImage();
  }

  // Draw the image
  background(0);
  //imageMode(CENTER);
  //image(video1, width/2, height/2);
  image(video1, 0, 0);
}