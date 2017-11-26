ArrayList strands;

void setup()
{
  size(400, 600);
  smooth();
  
  reset();
}



// resets the stage so that you can make a new one
void reset()
{
  background(255);
  strands = new ArrayList();
}



void draw()
{
  if (mouseX < -100 || mouseX > width+100 || mouseY < -100 || mouseY > height+100) return;
  
  for (int i=strands.size()-1; i>=0; i--)
  {
    Strand s = (Strand)strands.get(i);
    s.update();
    if (s.done) strands.remove(i);
  }
}



void makeLines()
{
  int amt = 1;
  int amp = (int)random(50, 200);
  float freq = random(.01, .08);

  println(amt);
  for (int i = 0; i<amt; i++)
  {
    println("make");
    makeLine(0, amp, freq);
  }
}



void makeLine(float angle, int amp, float freq)
{
  Strand s;
  int lineColor = (int)random(0, 18);
  float lineW = random(15);
  int life = (int)random(200, 700);
  int linealpha = (int)(180 - random(0, 100));
  s = new Strand(width/2 + random(-20, 20), -55, angle, 0, lineColor, lineW, life);
  strands.add(s);
}



void keyPressed()
{
  switch(key)
  {
    // save the sketch
    case 's':
      save("sketch_" + (System.currentTimeMillis()/1000)+".png");
      break; 
  
    //reset the sketch
    case 'c':
      reset();
      break;
  }
}



void mouseClicked()
{
  makeLines();
}