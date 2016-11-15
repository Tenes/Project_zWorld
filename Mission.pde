class Mission extends Texture{
  String[] Objectif;
  boolean[] MissionEnCours;
  boolean[] MissionAccomplie;
  float TempsAffichage;
  Texture PointeurQuete;
  Mission(String imagePrefix, int Nombre, String Extension, float HitboxLargeur, float HitboxHauteur, String TexteObjectif1, String TexteObjectif2, String TexteObjectif3){
    super(imagePrefix, Nombre, Extension, HitboxLargeur, HitboxHauteur);
    Objectif = new String[3];
    this.Objectif[0] = TexteObjectif1;
    this.Objectif[1] = TexteObjectif2;
    this.Objectif[2] = TexteObjectif3;
    MissionEnCours = new boolean[3];
    MissionEnCours[0] = false;
    MissionEnCours[1] = false;
    MissionEnCours[2] = false;
    MissionAccomplie = new boolean[3];
    MissionAccomplie[0] = false;
    MissionAccomplie[1] = false;
    MissionAccomplie[2] = false;
    PointeurQuete = new Texture("Images/HUD/Fleche_", 1, ".png", 0, 0);
    GAME.AjouterTexture(PointeurQuete);
  }
  
  void ObtentionMission1(){
    if (MissionAccomplie[0] == false && MissionAccomplie[1] == false && MissionAccomplie[2] == false){
      this.TempsAffichage = 8;
      this.MissionEnCours[0] = true;
    }
  }
  
  void ObtentionMission2(){
    if (MissionAccomplie[0] == true){
      this.TempsAffichage = 5;
      this.MissionEnCours[1] = true;
      this.MissionEnCours[0] = false;
    }
  }
  
  void ObtentionMission3(){
    if (MissionAccomplie[1] == true){
      this.TempsAffichage = 5;
      this.MissionEnCours[2] = true;
      this.MissionEnCours[1] = false;
    }
  }
  
  boolean Mission1(){
    if (Hero.PositionHorsCamera.x > 3900 && Hero.PositionHorsCamera.x < 4300 && Hero.PositionHorsCamera.y > -4300 && Hero.PositionHorsCamera.y < -3900
        && Hero.Voiture != null){
          return true; 
        }
    return false;
  }
  
  boolean Mission2(){
    if (Zombies[0].Mort == true){
          return true; 
        }
    return false;
  }
  
  boolean Mission3(){
    if (dist(Hero.PositionHorsCamera.x, Hero.PositionHorsCamera.y, M4.PositionHorsCamera.x, M4.PositionHorsCamera.y) < 30 && Hero.Voiture == null){
          Armes[1].Detenteur = Hero;
          M4.PositionHorsCamera.x = -6000;
          return true; 
        }
    return false;
  }
  
  
  void Verification(){
    if (this.TempsAffichage > 0 && this.MissionEnCours[0] == true){
      this.PositionHorsCamera.x = camera.Position.x + 500;
      this.PositionHorsCamera.y = camera.Position.y + 120;
      fill(255,255,255);
      textSize(10);
      text("Mission's goal :" + "\n" + this.Objectif[0], 375, 80, 250, 80);
    }
    else if (this.TempsAffichage > 0 && this.MissionEnCours[1] == true){
      this.PositionHorsCamera.x = camera.Position.x + 500;
      this.PositionHorsCamera.y = camera.Position.y + 380;
      fill(255,255,255);
      textSize(10);
      text("Mission's goal :" + "\n" + this.Objectif[1], 375, 340, 250, 80);
    }
    else if (this.TempsAffichage > 0 && this.MissionEnCours[2] == true){
      this.PositionHorsCamera.x = camera.Position.x + 500;
      this.PositionHorsCamera.y = camera.Position.y + 120;
      fill(255,255,255);
      textSize(10);
      text("Mission's goal :" + "\n" + this.Objectif[2], 375, 80, 250, 80);
    }
    else if (TempsAffichage > 0 && this.MissionAccomplie[2] == true){
      this.PositionHorsCamera.x = camera.Position.x + 500;
      this.PositionHorsCamera.y = camera.Position.y + 120;
      fill(255,255,255);
      textSize(10);
      text("You've completed the game's missions ! You're free to roam and slaughter any zombie you want !", 375, 80, 250, 80);
    }
    else {
      this.PositionHorsCamera.x = -6000;
    }
    
    if (this.Mission1() && this.MissionEnCours[0] == true){
      this.MissionAccomplie[0] = true;
      this.ObtentionMission2();
      PNJ[29].Mort = true;
      Zombies[0].PositionHorsCamera.x = PNJ[29].PositionHorsCamera.x;
      Zombies[0].PositionHorsCamera.y = PNJ[29].PositionHorsCamera.y;
    }
    
    if (this.Mission2() && this.MissionAccomplie[0] == true && this.MissionEnCours[1] == true){
      this.MissionAccomplie[1] = true;
      M4.PositionHorsCamera.x = Zombies[0].PositionHorsCamera.x + 25;
      M4.PositionHorsCamera.y = Zombies[0].PositionHorsCamera.y;
      this.ObtentionMission3();
    }
    
    if (this.Mission3() && this.MissionAccomplie[1] == true && this.MissionEnCours[2] == true){
      this.MissionAccomplie[2] = true;
      this.MissionEnCours[2] = false;
      TempsAffichage = 5;
    }
  }
      
  void FlecheIndicative(){
    if (MissionEnCours[0] == true){
      this.PointeurQuete.rotation = atan2(PNJ[29].PositionHorsCamera.y - Hero.PositionHorsCamera.y , PNJ[29].PositionHorsCamera.x - Hero.PositionHorsCamera.x)+HALF_PI;
    }
    else if (MissionEnCours[1] == true){
      this.PointeurQuete.rotation = atan2(Zombies[0].PositionHorsCamera.y - Hero.PositionHorsCamera.y , Zombies[0].PositionHorsCamera.x - Hero.PositionHorsCamera.x)+HALF_PI;
    }
    else if (MissionEnCours[2] == true){
      this.PointeurQuete.rotation = atan2(M4.PositionHorsCamera.y - Hero.PositionHorsCamera.y , M4.PositionHorsCamera.x - Hero.PositionHorsCamera.x)+HALF_PI;
    }
    else{
      this.PointeurQuete.rotation = atan2(-1,0) + HALF_PI;
    }
  }  
  
  void TickRate(float Delta){
    if (this.TempsAffichage >= 0){
      this.TempsAffichage -= Delta; 
    }
  }
}