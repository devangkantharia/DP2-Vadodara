Branch root;
float ang;
color col;

void setup() {
  noLoop(); 
  noStroke();
  smooth();  
  size(800,600); 
  background(240);
  ang = random(HALF_PI - PI/30,HALF_PI + PI/30);  
  col = color(140,80,20);
  root = new Branch(new PVector(0.5*width,0.92*height,0),70,20,ang,col);
}

void draw(){
  background(240);
  root.paint();
}

void mousePressed() {
  //save("pic.jpg");
  ang = random(HALF_PI - PI/30,HALF_PI + PI/30);  
  root = new Branch(new PVector(0.5*width,0.92*height,0),70,20,ang,col);
  redraw();
}