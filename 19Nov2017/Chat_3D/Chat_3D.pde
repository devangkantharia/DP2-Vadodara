import processing.opengl.*;
import hypermedia.net.*;

UDP udp;

//VARIABLES
ArrayList rotationChaineArray; 
String pseudonyme = "";
color couleurTexte; //couleur qui sera utilise dans l'application, si aucune couleur est definie, une couleur aleatoire sera pigee
float tempsAffichage = 20.0; //temps que le texte restera affiche e l'ecran (en secondes)

PFont typographie;
String motTape = "";
int zoom; //le "z" de l'application
int deltaX, deltaY; //decalage pour tout centrer

String chaineRecu; //chaine qui sera recu par les autres clients
String donnees[]; //liste qui contiendra le texte et la couleur de l'usager qui a ete envoye

void setup() {
  size(600, 600, OPENGL); //widescreen
  background(0);
  frameRate(60);

  udp = new UDP( this, 6000, "224.0.0.1" ); //connexion
  udp.listen( true ); //indique e l'application pour ecouter la reception de donnees
  
  deltaX = width/2; //position initiale
  deltaY = height/2; //position initiale

  ellipseMode(CENTER); //centre les ellipses

  typographie = loadFont("SynchroLET-20.vlw"); //charge la typo

  rotationChaineArray = new ArrayList(); //declare une nouvelle liste ArrayListe
  
  //si aucune couleur a ete entree, pige une couleur au hasard
  if (couleurTexte == 0) {
   couleurTexte = color(int(random(255)),int(random(255)),int(random(255))); 
  }
}

void draw() {
  background(0); //efface l'arri?re-plan
 
  //appelle le rafraechissement de chaque objet (mots re?us) 
  for ( int i = 0; i<rotationChaineArray.size(); i++ ) {
    ((rotationChaine)rotationChaineArray.get(i)).draw();  //appelle la fonction draw pour chacun des objets
  }


  //dessine la zone pour entrer le texte
  stroke(255);
  line(0, height-15, width, height-15);
  
  noStroke();
  fill(255);
  textFont(typographie,10);
  textAlign(LEFT);
  
  //si aucun pseudonyme a ete entre, demande e l'usager d'en entrer un
  if (pseudonyme == "") {
    text("ENTRER VOTRE PSEUDONYME : " + motTape, 5, height-3);
  }
  else {
    //sinon, rafraechit le mot tappe
    text(pseudonyme + ": " + motTape, 5, height-3);
  }
}


//sur la reception de donnees
void receive( byte[] data ) {
   chaineRecu = bytes2string(data); //convertit les bytes en chaene de caract?res
   
   donnees = split(chaineRecu, "&"); //separe le mot de la couleur
   String motEnvoyer = donnees[0]; //indique le mot qui a ete envoye ainsi que son pseudonyme
   int couleurEnvoyer = int(donnees[1]); //indique la couleur qui a ete envoyee

    rotationChaineArray.add( new rotationChaine(motEnvoyer, couleurEnvoyer)); //ajoute l'objet
}