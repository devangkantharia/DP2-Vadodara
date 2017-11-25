// Daniel Shiffman
// <http://www.shiffman.net>

// A Thread using receiving UDP to receive images

import java.awt.image.*; 
import javax.imageio.*;

PImage video;
ReceiverThread[] thread;


void setup() {
  size(1400, 500);
  //fullScreen(2);
  video = createImage(512, 424, RGB);
  thread[0] = new ReceiverThread(video.width, video.height, 9100);
  thread[1] = new ReceiverThread(video.width, video.height, 9101);
  thread[0].start();
  thread[1].start();
  
  background(0);
}

void draw() {
  if (thread[0].available()) {
    video = thread[0].getImage();
    image(video, 100, 100);
    image(video, 800, 100);
  }
  if (thread[1].available()) {
    video = thread[1].getImage();
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