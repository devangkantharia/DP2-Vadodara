// Daniel Shiffman
// <http://www.shiffman.net>

// A Thread using receiving UDP to receive images

import java.awt.image.*; 
import javax.imageio.*;

PImage video;
ReceiverThread thread;


void setup() {
  size(1920, 1080);
  //fullScreen(2);
  video = createImage(512, 424, RGB);
  thread = new ReceiverThread(video.width, video.height);
  thread.start();
  
  background(0);
}

void draw() {
  //background(0);
  
  if (thread.available()) {
    video = thread.getImage();
    
    if(thread.counter == 0)
      image(video, 0, 0);
    else
      image(video, 512, 424);
  }
  
  //imageMode(CENTER);
  //image(video1, width/2, height/2);
  //image(video, 512, 424);
  
  rect(0, 0, 10, 10);
  rect(512, 424, 10, 10);
  rect(1920-512, 1080-424, 10, 10);
}