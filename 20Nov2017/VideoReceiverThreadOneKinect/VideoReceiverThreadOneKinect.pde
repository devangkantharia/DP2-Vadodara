// Daniel Shiffman
// <http://www.shiffman.net>

// A Thread using receiving UDP to receive images

import java.awt.image.*; 
import javax.imageio.*;

PImage video1;
ReceiverThread thread1;

void setup() {
  size(800, 800);
  video1 = createImage(512, 424, RGB);
  thread1 = new ReceiverThread(video1.width, video1.height);
  thread1.start();
}

void draw() {
  if (thread1.available()) {
    video1 = thread1.getImage();
  }

  // Draw the image
  background(0);
  imageMode(CENTER);
  image(video1, width/2, height/2);
}