// Daniel Shiffman
// <http://www.shiffman.net>

// A Thread using receiving UDP to receive images

import java.awt.image.*; 
import javax.imageio.*;

PImage video1, video2;
Boolean gotVideo1, gotVideo2 = false;


String ip1 = "/192.168.18.229";
String ip2 = "/192.168.18.230";


ReceiverThread thread;

void setup() {
  size(800, 800);
  //fullScreen(2);

  video1 = createImage(512, 512, RGB);
  video2 = createImage(512, 512, RGB);

  thread = new ReceiverThread(512, 512);
  thread.start();
}

void draw() {

  if (thread.available()) {
   // println(thread.getIp());
    String fromIp = thread.getIp();
    if (fromIp.equals(ip1)) {
      video1 = thread.getImage();
      gotVideo1 = true;
    } else if (fromIp.equals(ip2)) {
      video2 = thread.getImage();
      gotVideo2 = true;
    }
  }

  //PImage[] videos;

  // Draw the image
  background(0);

  //if (gotVideo1 && gotVideo2) {
  //  image(video2, 0, 0);
  //  blend(video1, 0, 0, 33, 100, 67, 0, 33, 100, SCREEN);
  //} else if (gotVideo1 && !gotVideo2) {
  //  image(video1, 0, 0);
  //} else if (!gotVideo1 && gotVideo2) {
  //  image(video2, 0, 0);
  //}
}