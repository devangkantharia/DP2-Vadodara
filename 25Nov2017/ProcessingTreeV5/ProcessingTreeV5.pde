int L;

void setup(){
  size(700,700);
  L=(int)(height*.25);
  strokeJoin(ROUND);
  Draw();
}

void draw(){

}

void mousePressed(){
 if(mouseButton==RIGHT){
   Draw();
 }
}

void Draw(){
  backG();
  pushMatrix();
  translate(width/2, height*.825);
  tree1(0, 0, L, -90);
  roots(0,0,L);
  popMatrix();
}

void backG(){
  L=(int)(height*.25);
  color c1=color(215, 245, 255);
  color c2=color(90,175,255);
  for(int i=height;i>=0;i--){
    float l=map(i,(height),0,0,1);
    color c= lerpColor(c1,c2,l);
    stroke(c);
    line(0,i,width,i);
  }
  noStroke();
  fill(0, 200, 0);
  beginShape();
  vertex(0, height);
  vertex(0, height*.9);
  bezierVertex(0, height*.9, width*.25, height*.8, width/2, height*.8);
  bezierVertex((width/2), height*.8, width*.75, height*.8, width, height*.9);
  vertex(width, height);
  endShape(CLOSE);
}

void tree1(float x, float y, float l, float ang) {
  float ex=x+(l*cos(radians(ang)));
  float ey=y+(l*sin(radians(ang)));
  strokeWeight(1);
  stroke(50, 10, 0);
  fill(75, 35, 0);
  pushMatrix();
  translate(x,y);
  rotate(radians(ang));
  rect(-(l/10),-(l/10),l*1.2,l/5,l/10);
  popMatrix();
  float a=random(20, 50);
  float a1=random(-50, -20);
  if(l==L){
    tree1(ex, ey, l/1.5, ang);
   
  }
  if ((l/1.5)>8) {
    tree1(ex, ey, l/1.5, a+ang);
    tree1(ex, ey, l/1.5, a1+ang);  
    a=random(20, 50)+ang;
    a1=random(-50, -20)+ang;
    tree1(ex, ey, l/2, (a));
    tree1(ex, ey, l/2, (a1));
    
  }
  if (((l/1.5)>=66)) {
    a=random(20, 50)+ang;
    a1=random(-50, -20)+ang;
    tree1(ex, ey, l/3, (a));
    tree1(ex, ey, l/3, (a1));
    
  }
  if (l==L) {
    a=random(10, 30)+ang;
    a1=random(-30, -10)+ang;
    tree1(ex, ey, l/4.5, (a));
    tree1(ex, ey, l/4.5, (a1));
    
  }
  
  if ((l/1.5)<=12) {
    leaf(ex, ey, ang);
  }
}

void leaf(float x, float y, float ang){
  for(int i= -1;i<2;i++){
    float l=random(10,19);
    float a=random(30,61);
    pushMatrix();
    translate(x,y);
    rotate(radians(ang+(i*a)));
    //rotate(radians(ang));
    fill(0,155,0);
    stroke(0,125,0);
    beginShape();
    vertex(0,0);
    bezierVertex(0,0,(l/4),(l/2),l,0);
    bezierVertex(l,0,(l/4),-(l/2),0,0);
    vertex(0,0);
    endShape();
    stroke(0,125,0);
    line(0,0,12,0);
    popMatrix();
  }
}

void roots(float x, float y, float l){
  stroke(75, 35, 0);
  for(int i=0;i<4;i++){
    int a=(int)random(5,9);
    float ang=-(random(0,30))-(45*i);
    float x1=0;
    float y1=0;
    float ex=x1+(-l/10)*cos(radians(ang));
    float ey=y1+(-l/10)*sin(radians(ang));
    for(int j=0;j<a;j++){
      float w=(l/2)/(j+3);
      strokeWeight(w);
      line(x1,y1,ex,ey);
      x1=ex;
      y1=ey;
      ang+=(random(-25,25));  
      ex=x1+(-l/10)*cos(radians(ang));
      ey=y1+(-l/10)*sin(radians(ang));
    }
  }
}