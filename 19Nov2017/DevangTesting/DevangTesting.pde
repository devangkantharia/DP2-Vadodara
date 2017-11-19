import org.openkinect.processing.*;

Kinect2 kinect2;

void setup() {
  size(512, 424);
  kinect2 = new Kinect2(this);
  kinect2.initDepth();
  kinect2.initDevice();
}

void draw() {
  background(0);
}