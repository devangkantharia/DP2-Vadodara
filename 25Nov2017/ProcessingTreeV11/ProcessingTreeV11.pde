// L-system 
// goals for L system

/*
  Flow with song
 
 
 */

Lsystem[] tree;
float count;
float wind;
int max_trees, cur_tree;
int breed_track;

void setup() {
  size(1700, 500);
  smooth();
  frameRate(30);
  max_trees = 64;
  cur_tree = 0;
  tree = new Lsystem[max_trees];
  breed_track = 1;
  tree[0] = new Lsystem(width/5, height, height/2.1, 3, 0);
  count = 0;
  wind = 0.3;
}

void draw() {

  background(blend_color(color(225), color(137, 209, 234), ((float)count-800)/100));

  for (int i = 0; i < cur_tree+1; ++i) {
    tree[i].draw((int)count);
  }
  count++;
}

void mousePressed() {
  if (cur_tree < max_trees-1)
  {
    cur_tree++;
    int breed = floor(random(1, 7.999));
    ++breed_track;
    if (breed_track > 5)
    {
      breed_track = 1;
    }
    //breed = 3;

    tree[cur_tree] = new Lsystem(mouseX, height, height-mouseY, breed, (int)count);
  }
}



color blend_color(color x, color y, float factor)
{
  color output;
  if (factor < 0) 
  {
    output = x;
    return output;
  } else if (factor > 1)
  {
    output = y;
    return output;
  }

  output = color((1-factor)*red(x)+factor*red(y), (1-factor)*green(x)+factor*green(y), (1-factor)*blue(x)+factor*blue(y), (1-factor)*alpha(x)+factor*alpha(y));
  return output;
}