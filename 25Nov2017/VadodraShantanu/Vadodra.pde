// Daniel Shiffman
// <http://www.shiffman.net>

// A Thread using receiving UDP to receive images

import java.awt.image.*; 
import javax.imageio.*;

PImage video;
ReceiverThread thread;


void setup() {  
  size(1400, 500);
  //fullScreen(2);
  video = createImage(512, 424, RGB);
  thread = new ReceiverThread(video.width, video.height);
  thread.start();
  frameRate(10);
  background(0);
}

void draw() {
  
  if (thread.available()) {
    video = thread.getImage();
    
    if(thread.sender == 1)
      image(video, 100, 100);
    if(thread.sender == 2)
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