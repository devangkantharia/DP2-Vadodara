class rotationChaine {
  //VARIABLES
  int temps;
  int rotX, rotY;
  int angle, deltaAngle, tailleTexte;
  float posX, posY;
  int rayonSphere;
  int coulTexte;
  float alphaTexte;
  String word;
  int numeroCouleur;

  rotationChaine(String string, color couleurTexte) {
    temps = millis();
    word = string;
    coulTexte = couleurTexte;
    angle = int(random(360));
    deltaAngle = int(random(1,2));
    tailleTexte = int(random(15,40));
    rayonSphere = int(random(100,250));
  }

  void draw() {
    
    alphaTexte = ((tempsAffichage - ((millis() - temps)/1000))/tempsAffichage) * 255;
    
    if (alphaTexte > 0) {
      pushMatrix();
        translate(deltaX, deltaY, zoom);
        rotateX(radians(angle)); //applique une rotation
        rotateY(radians(angle)); //applique une rotation
        rotateZ(radians(angle)); //applique une rotation

        //dessine l'ellipse
        noFill();
        stroke(coulTexte,alphaTexte*0.25);
        ellipse(0, 0, rayonSphere*2, rayonSphere*2);

        posX = rayonSphere * cos(radians(angle)); //determine la position X
        posY = rayonSphere * sin(radians(angle)); //determine la position Y
  
        textFont(typographie,tailleTexte); 
        textAlign(CENTER); //aligne le texte au centre

        fill(coulTexte,alphaTexte); //applique la couleur 
        text(word, posX, posY); //ecrit le mot

        angle += deltaAngle; //incremente l'angle
      popMatrix();
    }
    else {
      rotationChaineArray.remove(0);
    }
  }
}
