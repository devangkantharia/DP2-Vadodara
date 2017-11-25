// Daniel Shiffman
// <http://www.shiffman.net>

// A Thread using receiving UDP to receive images

import java.awt.image.*; 
import javax.imageio.*;

PImage video;
ReceiverThread thread1, thread2;


void setup() {
  size(1400, 500);
  //fullScreen(2);
  video = createImage(512, 424, RGB);
  thread1 = new ReceiverThread(video.width, video.height, 9100);
  thread2 = new ReceiverThread(video.width, video.height, 9101);
  thread1.start();
  thread2.start();
  
  background(0);
}

void draw() {
  if (thread1.available()) {
    video = thread1.getImage();
    image(video, 100, 100);
    image(video, 800, 100);
  }
  if (thread2.available()) {
    video = thread2.getImage();
    image(video, 100, 100);
    image(video, 800, 100);
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