class Tree
{
  float treeSize;
  float maxLevel; 
  float rotationX, rotationZ;
  PVector initPos;
  Cylinder c;
  ArrayList rotX = new ArrayList();
  ArrayList rotZ = new ArrayList();

  Tree(float _treeSize, float _maxLevel, PVector _initPos)
  {
    treeSize = _treeSize;
    maxLevel = _maxLevel;
    initPos = _initPos;
    for (int i = 0; i < maxLevel; i++) {
      float rX = random(-50, 50);
      float rZ = random(-50, 50);

      rotX.add(rX);
      rotZ.add(rZ);
    }
  }

  void drawTree() 
  { 
    pushMatrix(); 
    translate(initPos.x, initPos.y, initPos.z);
    drawBranch(1);   
    popMatrix();
  } 

  void drawBranch(int level) 
  { 
    if (level > maxLevel) return; 
    fill(lerpColor(#8b4513, #009C22, level/maxLevel));
    float branchSize = -treeSize * pow(0.80, level); 
    c = new Cylinder(treeSize/4.10 * pow(0.4, level), treeSize/1.60 * pow(0.4, level), branchSize);
    c.render();    
    translate(0, branchSize, 0);
    for (int i = 0; i < maxLevel; i++) {
      rotationX = (Float) rotX.get(i);
      rotationZ = (Float) rotZ.get(i);
      pushMatrix();
      rotateX(radians(rotationX)); 
      rotateZ(radians(rotationZ)); 
      drawBranch(level + 1); 
      popMatrix();
    }
  }
}