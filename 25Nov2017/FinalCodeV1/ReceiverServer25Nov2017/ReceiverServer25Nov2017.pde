// Daniel Shiffman
// <http://www.shiffman.net>

// A Thread using receiving UDP to receive images

import java.awt.image.*; 
import javax.imageio.*;

PImage video1, video2;
ReceiverThread thread1, thread2;


void setup() {
  size(1400, 500);
  //fullScreen(2);
  video1 = createImage(512, 424, RGB);
  video2 = createImage(512, 424, RGB);
  thread1 = new ReceiverThread(video1.width, video1.height, 9100);
  thread2 = new ReceiverThread(video2.width, video2.height, 9101);
  thread1.start();
  thread2.start();
  
  background(0);
}

void draw() {
  if (thread1.available()) {
    video1 = thread1.getImage();
    image(video1, 100, 100);
    //image(video, 800, 100);
  }
  if (thread2.available()) {
    video2 = thread2.getImage();
    //image(video, 100, 100);
    image(video2, 800, 100);
  }
  
  //imageMode(CENTER);
  //image(video1, width/2, height/2);
  //image(video, 512, 424);
  
  /*
  rect(0, 0, 10, 10);
  rect(512, 424, 10, 10);
  rect(1920-512, 1080-424, 10, 10);
  */
}