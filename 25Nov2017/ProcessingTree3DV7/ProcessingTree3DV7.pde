float rotationX, rotationY, velocityX, velocityY = 0;
ArrayList trees = new ArrayList();
void setup()
{
  size(800, 600, P3D);
  for (int i = 0; i < 1; i++)
  {
    trees.add( new Tree(random(130, 190), int( random(3, 7)), new PVector()) );
  }
}

void draw()
{
  background(242);
  lights();
  rotationX += velocityX;
  rotationY += velocityY;
  velocityX *= 0.95;
  velocityY *= 0.95;  
  //smooth();
  pushMatrix();
  translate(width/2, 500, -260);
  rotateX(radians(-TWO_PI-rotationX));
  rotateY(radians(-rotationY));  
  for (int i = 0; i < trees.size(); i++) {
    Tree tree = (Tree) trees.get(i);
    tree.drawTree();
  }
  popMatrix();


  if (mousePressed) {
    velocityX += (mouseY-pmouseY) * 0.05;
    velocityY -= (mouseX-pmouseX) * 0.05;
  }
}

void keyPressed()
{
  switch(key) {
    //    case 's': 
    //    saveFrame(); 
    //        break;

  case 'r': 
    trees.clear();
    trees.add( new Tree(random(130, 190), int( random(3, 7)), new PVector()) );
    break;
  }
}