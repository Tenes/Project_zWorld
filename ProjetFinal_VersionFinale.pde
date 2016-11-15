int Compteur = 0;
PImage[] Menu;
boolean Jeu;
boolean[] AnimationMenu; //On initialise un tableau de bouléen qui premettra l'animation des 3 boutons du menu
boolean HowToPlay;
boolean[] Touches; //On initialise un tableau de bouléen qui enregistrera les pressions des flèches afin d'affiner les déplacements.
ClasseCamera camera; //On initialise ici la caméra qui suivra le personnage.
Texture Ville; //On initialise l'objet "Ville" (bien que cela n'était pas nécessaire).
Texture HitBoxSafezone;
Texture[] MurVerticaux;
Texture[] MurHorizontaux;
Texture[] Barrieres;
Texture Bouton;
Texture CabineTelephonique;
Texture[] TanksAbandonnes;
Texture[] BarbelesVerticaux;
Texture[] BarbelesHorizontaux;
Texture HUD;
Texture M4;
Humanoide Hero; //On initialise l'objet "Hero".
Humanoide[] PNJ;
Humanoide[] Zombies;
ObjVoitures[] Voitures; //On initialise les différentes Voitures disponibles.
Arme[] Armes;
Mission Missions;
GameInstance GAME; //Ici GAME sera tout ce qui a un rapport avec le jeu, regroupant les Textures ET les GameInstances.
GameInstance BatimentListe; //Une liste de tous les batiments incorporé au jeu afin de les générer en seulement une ligne.
GameInstance ZombieListe;
GameInstance PNJListe;
GameInstance BalleListe;

void setup(){ //On affecte aux variables initialisés ci-dessus leurs valeurs.
  size(1000,500,FX2D); //Taille de la fenêtre.
  frameRate(60); //On définit ici le nombre exact de rafraichissement par seconde qu'utilisera le void draw.
  smooth(); //Petite fonction pour affiner les traits du jeu.
  ellipseMode(CENTER); //On définit le point où la rotation aura lieu, donc ici ça sera au centre de l'image.
  Menu = new PImage[4];
  Menu[0] = loadImage("Images/Elements/Menu.jpg");
  Menu[1] = loadImage("Images/Elements/Boutons.png");
  Menu[2] = Menu[1].get(742,61,175,59);
  Menu[3] = loadImage("Images/Elements/HowToPlay.jpg");
  Jeu = false;
  AnimationMenu = new boolean[3];
  AnimationMenu[0] = false;           //Animation de pression du bouton Play
  AnimationMenu[1] = false;           //Animation de pression du bouton How to Play
  AnimationMenu[2] =false;            //Animation de pression du bouton Exit
  HowToPlay = false;
 }


void draw(){ //Le void qui tournera en boucle, à hauteur de 60 fois par seconde.
  if (Jeu == false)
  {
    background(Menu[0]);
    MenuAffichage(); 
  }
  if (Jeu == true){
    background(0,0,0); //On définit un fond noir (on ne peut définir le background comme étant la ville car l'image de cette dernière est plus grosse que la fenêtre de jeu).
    Mouvement();
    GAME.AppliquerFriction();
    GAME.updatePositionVelocite(GAME.Delta);
    GAME.updatePositionCamera(camera);
    for (int i = 0; i < ZombieListe.Humanoides.size(); i++)
    {
      Zombies[i].IA(Hero, GAME.Delta);
      Zombies[i].Collision();
      for (int ii = 0; ii < BalleListe.Balles.size(); ii++)
      {
        BalleListe.Balles.get(ii).updateBalle();
        BalleListe.Balles.get(ii).Degats(ZombieListe.Humanoides.get(i));
      }
      Zombies[i].Mort();
    }
    for (int i = 0; i < PNJListe.Humanoides.size(); i++)
    {
      PNJ[i].IA(Hero, GAME.Delta);
      PNJ[i].Collision();
      for (int ii = 0; ii < BalleListe.Balles.size(); ii++)
      {
        BalleListe.Balles.get(ii).updateBalle();
        BalleListe.Balles.get(ii).Degats(PNJListe.Humanoides.get(i));
      }
      PNJ[i].Mort();
    }
    camera.Marche(camera);
    GAME.Animation();
    Hero.Collision();
    if (Hero.Voiture != null)
    {
      Hero.Voiture.EtatVoiture();
    }
    Hero.Mort();
    GAME.render();
    GAME.TickRate(GAME.Delta);
    HUDAffichage();
    Missions.FlecheIndicative();
    Missions.Verification();
  }
}

void DebutPartie(){
  GAME = new GameInstance();
  BatimentListe = new GameInstance();
  ZombieListe = new GameInstance();
  PNJListe = new GameInstance();
  BalleListe = new GameInstance();
  Touches = new boolean[4];           //On annonce que la tableau contiendra 4 bouléens distincts. False = Aucun mouvement.||True = Un mouvement en cours
  Touches[0] = false;                 //Droite
  Touches[1] = false;                 //Gauche
  Touches[2] = false;                 //Haut
  Touches[3] = false;                 //Bas
  Ville = new Texture("Images/Elements/Ville", 1, ".jpg", 9900, 9900);
  GAME.AjouterTexture(Ville); //On ajoute la texture de la ville dans la liste contenue dans GAME.
  Hero = new Humanoide("Images/Hero/Hero_",127, ".png", 49, 42, false, false, 100);
  camera = new ClasseCamera(width, height, Hero); //On définit la caméra afin qu'elle suive le Hero du jeu.
  
  TanksAbandonnes = new Texture[30];
  for ( int i = 0; i < TanksAbandonnes.length/3; i++)
  {
    TanksAbandonnes[i] = new Texture ("Images/Voitures/Tank_", 2, ".png", 132, 254);
    BatimentListe.AjouterTexture(TanksAbandonnes[i]);
    TanksAbandonnes[i].rotation = atan2(random(-1000,1000), random(-1000,1000));
    TanksAbandonnes[i].PositionHorsCamera.x = random(-4400, -1980);
    TanksAbandonnes[i].PositionHorsCamera.y = random(-4400, 4400);
  }
  for ( int i = (TanksAbandonnes.length/6)*2; i < (TanksAbandonnes.length/6)*3; i++)
  {
    TanksAbandonnes[i] = new Texture ("Images/Voitures/Tank_", 2, ".png", 132, 254);
    BatimentListe.AjouterTexture(TanksAbandonnes[i]);
    TanksAbandonnes[i].rotation = atan2(random(-1000,1000), random(-1000,1000));
    TanksAbandonnes[i].PositionHorsCamera.x = random(-1980, 1980);
    TanksAbandonnes[i].PositionHorsCamera.y = random(-4400, -2100); 
  }
  for ( int i = (TanksAbandonnes.length/6)*3; i < (TanksAbandonnes.length/6)*4; i++)
  {
    TanksAbandonnes[i] = new Texture ("Images/Voitures/Tank_", 2, ".png", 132, 254);
    BatimentListe.AjouterTexture(TanksAbandonnes[i]);
    TanksAbandonnes[i].rotation = atan2(random(-1000,1000), random(-1000,1000));
    TanksAbandonnes[i].PositionHorsCamera.x = random(-1980, 1800);
    TanksAbandonnes[i].PositionHorsCamera.y = random(2100, 4400); 
  }
  for ( int i = (TanksAbandonnes.length/3)*2; i < TanksAbandonnes.length; i++)
  {
    TanksAbandonnes[i] = new Texture ("Images/Voitures/Tank_", 2, ".png", 132, 254);
    BatimentListe.AjouterTexture(TanksAbandonnes[i]);
    TanksAbandonnes[i].rotation = atan2(random(-1000,1000), random(-1000,1000));
    TanksAbandonnes[i].PositionHorsCamera.x = random(2100, 4400);
    TanksAbandonnes[i].PositionHorsCamera.y = random(-4400, 4400); 
  }
  
  PNJ = new Humanoide[30];
  for ( int i = 0; i < PNJ.length/2; i++){
    PNJ[i] = new Humanoide("Images/PNJ/PNJ_", 24, ".png", 49, 42, false, true, 100);
    PNJListe.AjouterHumanoide(PNJ[i]);
    PNJ[i].PositionHorsCamera.x = random(-1080, -720);
    PNJ[i].PositionHorsCamera.y = random(-1110, 1590);
  }
  for ( int i = PNJ.length/2; i < PNJ.length-1; i++){
    PNJ[i] = new Humanoide("Images/PNJ/PNJ_", 24, ".png", 49, 42, false, true, 100);
    PNJListe.AjouterHumanoide(PNJ[i]);
    PNJ[i].PositionHorsCamera.x = random(780, 1650);
    PNJ[i].PositionHorsCamera.y = random(-1730, -790);
  }
  PNJ[29] = new Humanoide("Images/PNJ/PNJ_", 24, ".png", 49, 42, false, true, 100);
  PNJListe.AjouterHumanoide(PNJ[29]);
  PNJ[29].PositionHorsCamera.x = random(4000, 4200);
  PNJ[29].PositionHorsCamera.y = random(-4200, -4000);
  
  GAME.AjouterGameInstance(PNJListe);
  
  Zombies = new Humanoide[210];
  for ( int i = 0; i < Zombies.length/3; i++)
  {
    Zombies[i] = new Humanoide("Images/Zombies/Zombies_", 30, ".png", 47, 42, true, true, 100);
    ZombieListe.AjouterHumanoide(Zombies[i]);
    Zombies[i].PositionHorsCamera.x = random(-4400, -1980);
    Zombies[i].PositionHorsCamera.y = random(-4400, 4400);
  }
  for ( int i = (Zombies.length/6)*2; i < (Zombies.length/6)*3; i++)
  {
    Zombies[i] = new Humanoide("Images/Zombies/Zombies_", 30, ".png", 47, 42, true, true, 100);
    ZombieListe.AjouterHumanoide(Zombies[i]);
    Zombies[i].PositionHorsCamera.x = random(-1980, 1980);
    Zombies[i].PositionHorsCamera.y = random(-4400, -1980); 
  }
  for ( int i = (Zombies.length/6)*3; i < (Zombies.length/6)*4; i++)
  {
    Zombies[i] = new Humanoide("Images/Zombies/Zombies_", 30, ".png", 47, 42, true, true, 100);
    ZombieListe.AjouterHumanoide(Zombies[i]);
    Zombies[i].PositionHorsCamera.x = random(-1980, 1980);
    Zombies[i].PositionHorsCamera.y = random(1980, 4400); 
  }
  for ( int i = (Zombies.length/3)*2; i < Zombies.length; i++)
  {
    Zombies[i] = new Humanoide("Images/Zombies/Zombies_", 30, ".png", 47, 42, true, true, 100);
    ZombieListe.AjouterHumanoide(Zombies[i]);
    Zombies[i].PositionHorsCamera.x = random(1980, 4200);
    Zombies[i].PositionHorsCamera.y = random(-4200, 4400); 
  }
  
  GAME.AjouterGameInstance(ZombieListe);
  GAME.AjouterHumanoide(Hero);
  
  CabineTelephonique = new Texture("Images/Elements/Phone_", 1, ".png", 80, 80);
  CabineTelephonique.PositionHorsCamera.y = 100;
  
  GAME.AjouterTexture(CabineTelephonique);
  
  MurVerticaux = new Texture[2];
  for ( int i = 0; i < MurVerticaux.length; i++)
  {
    MurVerticaux[i] = new Texture("Images/Elements/MurVertical_", 1, ".png", 30, 3900);
    BatimentListe.AjouterTexture(MurVerticaux[i]);
  }
  MurVerticaux[0].PositionHorsCamera.x = -1950;
  MurVerticaux[0].PositionHorsCamera.y = 0;
  MurVerticaux[1].PositionHorsCamera.x = 1950;
  MurVerticaux[1].PositionHorsCamera.y = 0;
  
  Barrieres = new Texture[2];
  Barrieres[0] = new Texture("Images/Elements/Barriere_", 1, ".png", 330, 35);
  Barrieres[0].PositionHorsCamera.x = -600;
  Barrieres[0].PositionHorsCamera.y = 1950;
  Barrieres[1] = new Texture("Images/Elements/Barriere_", 1, ".png", 330, 35);
  Barrieres[1].PositionHorsCamera.x = -300;
  Barrieres[1].PositionHorsCamera.y = 1950;
  BatimentListe.AjouterTexture(Barrieres[0]);
  BatimentListe.AjouterTexture(Barrieres[1]);
  
  Bouton = new Texture("Images/Elements/Bouton_", 1, ".png", 10, 10);
  Bouton.PositionHorsCamera.x = -120;
  Bouton.PositionHorsCamera.y = 1940;
  BatimentListe.AjouterTexture(Bouton);  
    
  MurHorizontaux = new Texture[24];
  for ( int i = 0; i < MurHorizontaux.length; i++)
  {
    MurHorizontaux[i] = new Texture("Images/Elements/MurHorizontal_", 1, ".png", 300, 30);
    BatimentListe.AjouterTexture(MurHorizontaux[i]);
  }
  MurHorizontaux[0].PositionHorsCamera.x = -1800;
  MurHorizontaux[0].PositionHorsCamera.y = -1950;
  MurHorizontaux[1].PositionHorsCamera.x = -1500;
  MurHorizontaux[1].PositionHorsCamera.y = -1950;
  MurHorizontaux[2].PositionHorsCamera.x = -1200;
  MurHorizontaux[2].PositionHorsCamera.y = -1950;
  MurHorizontaux[3].PositionHorsCamera.x = -900;
  MurHorizontaux[3].PositionHorsCamera.y = -1950;
  MurHorizontaux[4].PositionHorsCamera.x = -600;
  MurHorizontaux[4].PositionHorsCamera.y = -1950;
  MurHorizontaux[5].PositionHorsCamera.x = -300;
  MurHorizontaux[5].PositionHorsCamera.y = -1950;
  MurHorizontaux[6].PositionHorsCamera.x = 0;
  MurHorizontaux[6].PositionHorsCamera.y = -1950;
  MurHorizontaux[7].PositionHorsCamera.x = 300;
  MurHorizontaux[7].PositionHorsCamera.y = -1950;
  MurHorizontaux[8].PositionHorsCamera.x = 600;
  MurHorizontaux[8].PositionHorsCamera.y = -1950;
  MurHorizontaux[9].PositionHorsCamera.x = 900;
  MurHorizontaux[9].PositionHorsCamera.y = -1950;
  MurHorizontaux[10].PositionHorsCamera.x = 1200;
  MurHorizontaux[10].PositionHorsCamera.y = -1950;
  MurHorizontaux[11].PositionHorsCamera.x = 1500;
  MurHorizontaux[11].PositionHorsCamera.y = -1950;
  MurHorizontaux[12].PositionHorsCamera.x = 1800;
  MurHorizontaux[12].PositionHorsCamera.y = -1950;
  MurHorizontaux[13].PositionHorsCamera.x = -1800;
  MurHorizontaux[13].PositionHorsCamera.y = 1950;
  MurHorizontaux[14].PositionHorsCamera.x = -1500;
  MurHorizontaux[14].PositionHorsCamera.y = 1950;
  MurHorizontaux[15].PositionHorsCamera.x = -1200;
  MurHorizontaux[15].PositionHorsCamera.y = 1950;
  MurHorizontaux[16].PositionHorsCamera.x = -900;
  MurHorizontaux[16].PositionHorsCamera.y = 1950;
  MurHorizontaux[17].PositionHorsCamera.x = 0;
  MurHorizontaux[17].PositionHorsCamera.y = 1950;
  MurHorizontaux[18].PositionHorsCamera.x = 300;
  MurHorizontaux[18].PositionHorsCamera.y = 1950;
  MurHorizontaux[19].PositionHorsCamera.x = 600;
  MurHorizontaux[19].PositionHorsCamera.y = 1950;
  MurHorizontaux[20].PositionHorsCamera.x = 900;
  MurHorizontaux[20].PositionHorsCamera.y = 1950;
  MurHorizontaux[21].PositionHorsCamera.x = 1200;
  MurHorizontaux[21].PositionHorsCamera.y = 1950;
  MurHorizontaux[22].PositionHorsCamera.x = 1500;
  MurHorizontaux[22].PositionHorsCamera.y = 1950;
  MurHorizontaux[23].PositionHorsCamera.x = 1800;
  MurHorizontaux[23].PositionHorsCamera.y = 1950;
  
  BarbelesVerticaux = new Texture[2];
  for ( int i = 0; i < BarbelesVerticaux.length; i++)
  {
    BarbelesVerticaux[i] = new Texture("Images/Elements/BarbelesVertical_", 1, ".png", 20, 9900);
    BatimentListe.AjouterTexture(BarbelesVerticaux[i]);
  }
  BarbelesVerticaux[0].PositionHorsCamera.x = -4440;
  BarbelesVerticaux[0].PositionHorsCamera.y = 0;
  BarbelesVerticaux[1].PositionHorsCamera.x = 4440;
  BarbelesVerticaux[1].PositionHorsCamera.y = 0;
  
  BarbelesHorizontaux = new Texture[2];
  for ( int i = 0; i < BarbelesHorizontaux.length; i++)
  {
    BarbelesHorizontaux[i] = new Texture("Images/Elements/BarbelesHorizontal_", 1, ".png", 9900, 20);
    BatimentListe.AjouterTexture(BarbelesHorizontaux[i]);
  }
  BarbelesHorizontaux[0].PositionHorsCamera.x = 0;
  BarbelesHorizontaux[0].PositionHorsCamera.y = -4640;
  BarbelesHorizontaux[1].PositionHorsCamera.x = 0;
  BarbelesHorizontaux[1].PositionHorsCamera.y = 4640;
  
  Armes = new Arme[2];
  Armes[0] = new Arme("Pistolet", 2, 100, 600, 12, 12);
  Armes[1] = new Arme("Fusil", 5, 100, 600, 30, 30);
  
  Voitures = new ObjVoitures[4];
  Voitures[0] = new ObjVoitures("Images/Voitures/VoitureBleu_", 1, ".png", 63, 136, 500);
  Voitures[1] = new ObjVoitures("Images/Voitures/VoitureRouge_", 1, ".png", 59, 133, 500);
  Voitures[2] = new ObjVoitures("Images/Voitures/VoitureBlanche_", 1, ".png", 64, 139, 500);
  Voitures[3] = new ObjVoitures("Images/Voitures/VoitureMini_", 1, ".png", 58, 111, 500);
  PNJ[27].Voiture = Voitures[3];
  PNJ[27].Voiture.Conducteur = PNJ[27];
  PNJ[28].Voiture = Voitures[0];
  PNJ[28].Voiture.Conducteur = PNJ[28];
  
  for ( int i = 0; i < Voitures.length; i++)
  {
    GAME.AjouterTexture(Voitures[i]);
  }
  Voitures[0].PositionHorsCamera.x = -1250;
  Voitures[0].PositionHorsCamera.y = 1130;
  Voitures[1].PositionHorsCamera.x = 600;
  Voitures[1].PositionHorsCamera.y = -950;
  Voitures[2].PositionHorsCamera.x = 4000;
  Voitures[2].PositionHorsCamera.y = -4200;
  Voitures[3].PositionHorsCamera.x = 1145;
  Voitures[3].PositionHorsCamera.y = -1130;
  
  GAME.AjouterGameInstance(BatimentListe); // On ajoute une GameInstance dans la liste de GameInstance de GAME.
  GAME.AjouterGameInstance(BalleListe);
  
  M4 = new Texture("Images/Armes/Fusil_", 1, ".png", 76, 32);
  GAME.AjouterTexture(M4);
  M4.PositionHorsCamera.x = -6000;
  
  HUD = new Texture("Images/HUD/HUD_", 3, ".png", 220, 170);
  GAME.AjouterTexture(HUD);
  
  Missions = new Mission("Images/HUD/MissionHUD_", 1, ".png", 0, 0,
  "An agent of ours is waiting for you at the North-Est of the Salvaged-Ground, he wants to meet you personally and asked for you to go at the meeting point with a car.",
  "The agent turned into a zombie when i approached him, kill him before he turns you too.",
  "The ex-agent is now dead, you can take the M4 he had as a reward, it shall help you survive.");
  GAME.AjouterTexture(Missions);
  
}
void keyPressed(){ //Fonction qui vérifiera à chaque moment si une touche est appuyée.
    
    if (Jeu == false){
      if (HowToPlay == true){
             Jeu = true;
             DebutPartie();
           }
    }
    else{
      if (key == 'D'){
        Touches[0] = true;
        Touches[1] = false;
      }
      if (key == 'Q'){
        Touches[1] = true;
        Touches[0] = false;
      }       
      if (key == 'Z'){
        Touches[2] = true;
        Touches[3] = false;
      }
       
      if (key == 'S'){
        Touches[3] = true;
        Touches[2] = false;
      }
      
      if (key == ' '){
         if (Hero.Voiture == null){
           if (dist(Hero.PositionHorsCamera.x, Hero.PositionHorsCamera.y, Bouton.PositionHorsCamera.x, Bouton.PositionHorsCamera.y) < 60 ){
             Barrieres[0].MouvementBarriere(Barrieres[1]);
           }
           if (dist(Hero.PositionHorsCamera.x, Hero.PositionHorsCamera.y, CabineTelephonique.PositionHorsCamera.x, CabineTelephonique.PositionHorsCamera.y) < 20){
             Missions.ObtentionMission1();
           }
           for(int i = 0; i < Voitures.length; i++){ 
             if (dist(Hero.PositionHorsCamera.x, Hero.PositionHorsCamera.y, Voitures[i].PositionHorsCamera.x, Voitures[i].PositionHorsCamera.y) < 70 && Voitures[i].PDVie > 0){
               if (Voitures[i].Conducteur != null){
                  Voitures[i].Conducteur.QuitterVoiture(); 
               }
               Hero.Voiture = Voitures[i];
               Hero.Voiture.Conducteur = Hero;
             }
           }
         }
         else{
             Hero.QuitterVoiture();
         } 
      }
      
      if (key == TAB){
        if (Hero.ArmeActuelle == null){
          Hero.ArmeActuelle = Armes[0];
          Armes[0].Detenteur = Hero;
        }
        else if (Hero.ArmeActuelle == Armes[0] && Armes[1].Detenteur == Hero){
          Hero.ArmeActuelle = Armes[1];
        }
        else{
          Hero.ArmeActuelle = null;
        }
      }
      
      if (key == 'R'){
        if (Hero.ArmeActuelle == Armes[0] && Hero.ArmeActuelle.BalleChargeur < Hero.ArmeActuelle.CapaciteChargeur && Hero.ArmeActuelle.Rechargement <= 0 ||
        Hero.ArmeActuelle == Armes[1] && Hero.ArmeActuelle.BalleChargeur < Hero.ArmeActuelle.CapaciteChargeur && Hero.ArmeActuelle.Rechargement <= 0){
          Hero.ArmeActuelle.Recharger();
        }
      }
    }
}
    
    
void keyReleased(){ //Fonction qui vérifiera à chaque moment si une touche est relachée.
    if (key == 'D')
    {
         Touches[0] = false;
    }
    if (key == 'Q')
    {
        Touches[1] = false;
    }
    if (key == 'Z')
    {
        Touches[2] = false;
    }
    if (key == 'S')
    {
        Touches[3] = false;
    }
}


void mousePressed(){
  if (Jeu == false)
  {
    if (HowToPlay == false && mouseX>412 && mouseX<587 && mouseY>97 && mouseY<156)
    {
      AnimationMenu[0] = true;
    }
    if (HowToPlay == false && mouseX>412 && mouseX<587 && mouseY>224 && mouseY<283)
    {
      AnimationMenu[1] = true;
    }
    if (HowToPlay == false && mouseX>412 && mouseX<587 && mouseY>351 && mouseY<410)
    {
      AnimationMenu[2] = true;
    }
  }
  if (Jeu == true &&  Hero.Voiture == null && Hero.ArmeActuelle == null && Hero.TempsCoupDePoing <= 0)
  {
    Hero.TempsCoupDePoing = 0.25; 
  }
  
  if (Jeu == true &&  Hero.Voiture == null && Hero.ArmeActuelle == Armes[0])
  {  
    Hero.ArmeActuelle.TireVers((mouseX - camera.Largeur/2) + Hero.PositionHorsCamera.x, (mouseY- camera.Hauteur/2) + Hero.PositionHorsCamera.y, BalleListe);
  }
  if (Jeu == true &&  Hero.Voiture == null && Hero.ArmeActuelle == Armes[1])
  {  
    Hero.ArmeActuelle.TireVers((mouseX - camera.Largeur/2) + Hero.PositionHorsCamera.x, (mouseY- camera.Hauteur/2) + Hero.PositionHorsCamera.y, BalleListe);
  }
}


void Mouvement(){
  if (Hero.Voiture == null){
    if (Touches[0] == true)
    {
      Hero.Velocite.x += 12;
    }
    if (Touches[1] == true)
    {
      Hero.Velocite.x -= 12;
    }
    if (Touches[2] == true)
    {
      Hero.Velocite.y -= 12;
    }
    if (Touches[3] == true)
    {
      Hero.Velocite.y += 12;
    }
  }
  else{
    if (Touches[0] == true)
    {
      Hero.Voiture.Velocite.x += 10;
    }
    if (Touches[1] == true)
    {
      Hero.Voiture.Velocite.x -= 10;
    }
    if (Touches[2] == true)
    {
      Hero.Voiture.Velocite.y -= 10;
    }
    if (Touches[3] == true)
    {
      Hero.Voiture.Velocite.y += 10;
    }  
  }
}



void MenuAffichage(){
  if (AnimationMenu[0] == true || AnimationMenu[1] == true || AnimationMenu[2] == true)
  {
    Compteur += 1;
  }
  if ((Compteur < 10 && Compteur >= 0) && AnimationMenu[0] == true){ 
    Menu[2] = Menu[1].get(742,61,175,59);
    image(Menu[2],412,97);
  }
  if (Compteur == 15 && AnimationMenu[0] == true){
    Compteur = 0;
    AnimationMenu[0] = false;
    Jeu = true;
    DebutPartie();
    
  }
  if ((Compteur < 10 && Compteur >= 0) && AnimationMenu[1] == true){ 
    Menu[2] = Menu[1].get(742,188,175,59);
    image(Menu[2],412,224);
  }
  if (Compteur == 15 && AnimationMenu[1] == true){
    Compteur = 0;
    AnimationMenu[1] = false;
    Menu[0] = Menu[3];
    HowToPlay = true;
  }
  
  if ((Compteur < 10 && Compteur >= 0) && AnimationMenu[2] == true){ 
    Menu[2] = Menu[1].get(742,318,175,59);
    image(Menu[2],412,354);
  }
  if (Compteur == 15 && AnimationMenu[2] == true){
    exit();
  }
}


void HUDAffichage(){
  HUD.PositionHorsCamera.x = camera.Position.x + 120;
  HUD.PositionHorsCamera.y = camera.Position.y + 95;
  
  if (Hero.ArmeActuelle == null)
        {
          HUD.Frame = 0;
        }
        else if (Hero.ArmeActuelle == Armes[0])
        {
          HUD.Frame = 1;
          fill(255,255,255);
          textSize(10);
          text(Hero.ArmeActuelle.BalleChargeur + " / "+ Hero.ArmeActuelle.CapaciteChargeur, 150, 35);
        }
        else
        {
          HUD.Frame = 2;
          fill(255,255,255);
          text(Hero.ArmeActuelle.BalleChargeur + " / "+ Hero.ArmeActuelle.CapaciteChargeur, 150, 35);
        }
  noStroke();
  fill(255,0,0);
  quad(119, 76, Hero.PDVie+117, 76, Hero.PDVie + 117, 104, 119, 104);
  Missions.PointeurQuete.PositionHorsCamera.x = HUD.PositionHorsCamera.x - 73;
  Missions.PointeurQuete.PositionHorsCamera.y = HUD.PositionHorsCamera.y + 51;
}