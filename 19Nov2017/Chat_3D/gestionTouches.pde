void keyPressed() {
  //println(key);
  if (key != 65535) {
    if (keyCode == BACKSPACE) {
      if (motTape.length() > 0) {
        motTape = motTape.substring(0, motTape.length()-1); //efface le dernier caractere
      }
    }
    else if (keyCode == ENTER) {
      //si aucun pseudonyme a ete declare, le premier mot tape sera le pesudonyme
      if (pseudonyme == "") {
        pseudonyme = motTape;
      }
      else {
        udp.send( string2bytes(pseudonyme + ": " + motTape + "&" + couleurTexte) ); //envoie les donnees
      }
      motTape = ""; //reinitialise la variable
    }
    else if (keyCode == UP) {
      zoom+=5; //incremente le zoom
    }
    else if (keyCode == DOWN) {
      zoom-=5; //decremente le zoom
    }
    else {
      motTape += key; //ajoute le caractere tape e la variable
    }
  }
  else if (keyCode == ALT) {
    //si la touche "s" a ete enfoncee, sauvegarde l'image
    saveFrame("typo_####.jpg");
  }
}
