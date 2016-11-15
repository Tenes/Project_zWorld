class Humanoide extends Texture {
   ObjVoitures Voiture; 
   Arme ArmeActuelle;
   boolean EstZombie;
   boolean EstNonJoueur;
   boolean Mort;
   float PDVie;
   float VitesseDeplacement;
   float Animation;
   float DisparitionCadavre;
   float Ralentissement;
   float TempsCoupDePoing;
   float TempsEntreMouvement;
   float TempsSortieRoute;
   PVector Direction;
   boolean SurRoute;
   Humanoide(String imagePrefix, int Nombre, String Extension, float HitboxLargeur, float HitboxHauteur, boolean ZombieOuPas,  boolean NonJoueurOuPas, float Vie){
     super(imagePrefix, Nombre, Extension, HitboxLargeur, HitboxHauteur);
     this.PDVie = Vie;
     this.EstZombie = ZombieOuPas;
     this.EstNonJoueur = NonJoueurOuPas;
     TempsEntreMouvement = 0;
     Direction = new PVector(0,0);
     SurRoute = false;
}

  void updatePositionVelocite(float Delta){
    if (this.EstZombie == false && this.EstNonJoueur == false){
      if (this.ArmeActuelle == null){
        this.rotation = atan2(-this.Velocite.x, this.Velocite.y) + HALF_PI;
      }
      else if(this.ArmeActuelle != null && this.ArmeActuelle.AncienTir <= 0){
        this.rotation = atan2(-this.Velocite.x, this.Velocite.y) + HALF_PI;
      }
      else{
       Hero.rotation = -(atan2((Hero.Position.x)-mouseX, (Hero.Position.y)-mouseY))-HALF_PI; 
      }
      if (this.Voiture == null){
        this.PositionHorsCamera.x += this.Velocite.x * this.VitesseDeplacement * Delta;
        this.PositionHorsCamera.y += this.Velocite.y * this.VitesseDeplacement * Delta;
        this.VitesseDeplacement = 1;
      }
      else if (this.Voiture != null){
        this.Voiture.PositionHorsCamera.x += this.Voiture.Velocite.x * this.VitesseDeplacement * Delta;
        this.Voiture.PositionHorsCamera.y += this.Voiture.Velocite.y * this.VitesseDeplacement * Delta;
        this.VitesseDeplacement = 1.5;
        this.rotation = atan2(-this.Voiture.Velocite.x, this.Voiture.Velocite.y) + HALF_PI;
        this.Voiture.rotation = atan2(this.Voiture.Velocite.x, -this.Voiture.Velocite.y);
        this.PositionHorsCamera.x = this.Voiture.PositionHorsCamera.x; 
        this.PositionHorsCamera.y = this.Voiture.PositionHorsCamera.y;
        if (this.Ralentissement > 0){
          this.VitesseDeplacement = 1;
        }
      }
    }     
    else{
      this.rotation = atan2(-this.Velocite.x, this.Velocite.y)+HALF_PI;
    }
  }
  
  void Collision(){
  if (this == Hero && this.Voiture == null){
    for (int i = 0; i < ZombieListe.Humanoides.size(); i++){
        if (this.DetectionCollision(Zombies[i]) && Zombies[i].Mort == false){
          this.PDVie -= 0.1;
        }
        if (this.DetectionCollision(Zombies[i]) && Zombies[i].Mort == false && TempsCoupDePoing > 0.08 && TempsCoupDePoing < 0.09){
          Zombies[i].PDVie -=  25;
          if (Zombies[i].PositionHorsCamera.x < Hero.PositionHorsCamera.x){
            Zombies[i].PositionHorsCamera.x -= 15;         
          }
          if (Zombies[i].PositionHorsCamera.x > Hero.PositionHorsCamera.x){
            Zombies[i].PositionHorsCamera.x += 15;         
          }
          if (Zombies[i].PositionHorsCamera.y < Hero.PositionHorsCamera.y){
            Zombies[i].PositionHorsCamera.y -= 15;         
          }
          if (Zombies[i].PositionHorsCamera.y > Hero.PositionHorsCamera.y){
            Zombies[i].PositionHorsCamera.y += 15;         
          }
          if(Zombies[i].PDVie == 0){
            Zombies[i].DisparitionCadavre = 3;
            Zombies[i].Frame = int(random(27,30));
          }
        }
    }
    for (int i = 0; i < PNJListe.Humanoides.size(); i++){
        if (this.DetectionCollision(PNJ[i]) && PNJ[i].Mort == false && TempsCoupDePoing > 0.08 && TempsCoupDePoing < 0.09){
          PNJ[i].PDVie -=  25;
          if (PNJ[i].PositionHorsCamera.x < Hero.PositionHorsCamera.x){
            PNJ[i].PositionHorsCamera.x -= 15;         
          }
          if (PNJ[i].PositionHorsCamera.x > Hero.PositionHorsCamera.x){
            PNJ[i].PositionHorsCamera.x += 15;         
          }
          if (PNJ[i].PositionHorsCamera.y < Hero.PositionHorsCamera.y){
            PNJ[i].PositionHorsCamera.y -= 15;         
          }
          if (PNJ[i].PositionHorsCamera.y > Hero.PositionHorsCamera.y){
            PNJ[i].PositionHorsCamera.y += 15;         
          }
          if(PNJ[i].PDVie == 0){
            PNJ[i].DisparitionCadavre = 3;
            PNJ[i].Frame = int(random(20,23));
          }
        }
    }
  }
  if (this.Voiture == null){
      for (int i = 0; i < BatimentListe.Textures.size(); i++){
        if (this.DetectionCollision(BatimentListe.Textures.get(i))){
            this.ReponseCollision(this.OverlapV);
        }
      }
      for(int i = 0; i < Voitures.length; i++){
        if (this.DetectionCollision(Voitures[i]) && this.Mort  == false){
            this.ReponseCollision(this.OverlapV);
        }
      }
      for (int i = 0; i < PNJ.length; i++){
      if (this.DetectionCollision(PNJ[i]) && PNJ[i] != this && PNJ[i].Mort == false){
        this.ReponseCollision(this.OverlapV);
      }
    }
  }
   else
   {
     for (int i = 0; i < BatimentListe.Textures.size(); i++){
          if (this.Voiture.DetectionCollision(BatimentListe.Textures.get(i))){
              this.Voiture.ReponseCollision(this.Voiture.OverlapV);
              this.Voiture.PDVie -= 1;
              this.VitesseDeplacement = 0.5;
          }
        }
        for(int i = 0; i < Voitures.length; i++){
          if (this.Voiture.DetectionCollision(Voitures[i]) && Voitures[i] != this.Voiture){
              this.Voiture.ReponseCollision(this.Voiture.OverlapV);
              this.VitesseDeplacement = 0.5;
          }
        }
        for (int i = 0; i < Zombies.length; i++){
          if (this.Voiture.DetectionCollision(Zombies[i]) && Zombies[i].Mort == false){
             Zombies[i].PDVie = 0;
             Zombies[i].Frame = int(random(26,30));
             Zombies[i].DisparitionCadavre = 3;
             this.Ralentissement = 0.125;
          }
        }
        for (int i = 0; i < PNJ.length; i++){
          if (this.Voiture.DetectionCollision(PNJ[i]) && PNJ[i].Mort == false){
             PNJ[i].PDVie = 0;
             PNJ[i].Frame = int(random(20,23));
             PNJ[i].DisparitionCadavre = 3;
             this.Ralentissement = 0.125;
          }
        }
        if (this.Voiture.DetectionCollision(Hero)){
             this.Voiture.Direction = new PVector (0,0);
        }
   }
  }
  
  void IA(Humanoide Hero, float Delta){
    if ( this.EstZombie == true && this.Mort == false &&
       (dist(this.PositionHorsCamera.x, this.PositionHorsCamera.y, Hero.PositionHorsCamera.x, Hero.PositionHorsCamera.y) < 400 &&
       (dist(this.PositionHorsCamera.x, this.PositionHorsCamera.y, Hero.PositionHorsCamera.x, Hero.PositionHorsCamera.y) > 25))){
      if (this.PositionHorsCamera.x < Hero.PositionHorsCamera.x){
        this.Velocite.x += 0.1;
        this.PositionHorsCamera.add(this.Velocite.mult(Velocite, VitesseDeplacement));
        this.VitesseDeplacement = 0.2;
      }
      if (this.PositionHorsCamera.x > Hero.PositionHorsCamera.x){
        this.Velocite.x -= 0.1;
        this.PositionHorsCamera.add(this.Velocite.mult(Velocite, VitesseDeplacement));
        this.VitesseDeplacement = 0.2;
      }
      if (this.PositionHorsCamera.y < Hero.PositionHorsCamera.y){
        this.Velocite.y += 0.1;
        this.PositionHorsCamera.add(this.Velocite.mult(Velocite, VitesseDeplacement));
        this.VitesseDeplacement = 0.2;
      }
      if (this.PositionHorsCamera.y > Hero.PositionHorsCamera.y){
        this.Velocite.y -= 0.1;
        this.PositionHorsCamera.add(this.Velocite.mult(Velocite, VitesseDeplacement));
        this.VitesseDeplacement = 0.2;
      }
    }
        
    if (this.EstZombie == false && this.Mort == false && this != PNJ[29]){
      if ((this.PositionHorsCamera.x < -1100 && this.PositionHorsCamera.x > -1300 && this.PositionHorsCamera.y < 1300 && this.PositionHorsCamera.y > -1300) ||
      (this.PositionHorsCamera.x < 1300 && this.PositionHorsCamera.x > -1300 && this.PositionHorsCamera.y < -1100 && this.PositionHorsCamera.y > -1300) ||
      (this.PositionHorsCamera.x < 694 && this.PositionHorsCamera.x > 511 && this.PositionHorsCamera.y < -822 && this.PositionHorsCamera.y > -1111) || 
      (this.PositionHorsCamera.x < 94 && this.PositionHorsCamera.x > -91 && this.PositionHorsCamera.y < -389 && this.PositionHorsCamera.y > -1050) || 
      (this.PositionHorsCamera.x < 700 && this.PositionHorsCamera.x > -686 && this.PositionHorsCamera.y < -210 && this.PositionHorsCamera.y > -389) || 
      (this.PositionHorsCamera.x < -453 && this.PositionHorsCamera.x > -686 && this.PositionHorsCamera.y < 702 && this.PositionHorsCamera.y > -210) ||
      (this.PositionHorsCamera.x < -357 && this.PositionHorsCamera.x > -453 && this.PositionHorsCamera.y < 702 && this.PositionHorsCamera.y > 507) ||
      (this.PositionHorsCamera.x < 250 && this.PositionHorsCamera.x > -242 && this.PositionHorsCamera.y < 702 && this.PositionHorsCamera.y > 507) || 
      (this.PositionHorsCamera.x < 65 && this.PositionHorsCamera.x > -94 && this.PositionHorsCamera.y < 1110 && this.PositionHorsCamera.y > 694) ||
      (this.PositionHorsCamera.x < 1300 && this.PositionHorsCamera.x > 1100 && this.PositionHorsCamera.y < -1300 && this.PositionHorsCamera.y > 1300) ||
      (this.PositionHorsCamera.x < 1055 && this.PositionHorsCamera.x > 352 && this.PositionHorsCamera.y < 701 && this.PositionHorsCamera.y > 507) ||
      (this.PositionHorsCamera.x < 700 && this.PositionHorsCamera.x > 511 && this.PositionHorsCamera.y < 507 && this.PositionHorsCamera.y > -210) ||
      (this.PositionHorsCamera.x < 1300 && this.PositionHorsCamera.x > -1300 && this.PositionHorsCamera.y < 1300 && this.PositionHorsCamera.y > 1100)){
        this.SurRoute = true;
      }
      else{
        this.SurRoute = false; 
      }
      if (this.SurRoute == true && this.Voiture == null){
        this.Velocite.x -= this.Direction.x * this.VitesseDeplacement;
        this.Velocite.y -= this.Direction.y * this.VitesseDeplacement;
        this.PositionHorsCamera.x += this.Velocite.x * this.VitesseDeplacement * Delta;
        this.PositionHorsCamera.y += this.Velocite.y * this.VitesseDeplacement * Delta;
        this.rotation = atan2(-this.Velocite.x, this.Velocite.y)+HALF_PI;
        this.VitesseDeplacement = 1.5; 
        this.TempsSortieRoute = 4;
      }
      else if (this.SurRoute == false && this.TempsSortieRoute <= 0 && this.Voiture == null){
        this.Velocite.x += this.Direction.x * this.VitesseDeplacement;
        this.Velocite.y += this.Direction.y * this.VitesseDeplacement;
        this.PositionHorsCamera.x += this.Velocite.x * this.VitesseDeplacement * Delta;
        this.PositionHorsCamera.y += this.Velocite.y * this.VitesseDeplacement * Delta;
        this.rotation = atan2(-this.Velocite.x, this.Velocite.y)+HALF_PI;
        this.VitesseDeplacement = 1.5;
        if (TempsEntreMouvement <= 0){
           this.Direction.x = int(random(-2,2));
           this.Direction.y = int(random(-2,2));
           this.TempsEntreMouvement = 4;
        }
      }
      else if (this.Voiture != null){
        this.Voiture.Velocite.x += this.Voiture.Direction.x * this.VitesseDeplacement;
        this.Voiture.Velocite.y += this.Voiture.Direction.y * this.VitesseDeplacement;
        this.Voiture.PositionHorsCamera.x += this.Velocite.x * this.VitesseDeplacement * Delta;
        this.Voiture.PositionHorsCamera.y += this.Velocite.y * this.VitesseDeplacement * Delta;
        this.Voiture.rotation = atan2(-this.Voiture.Velocite.x, this.Voiture.Velocite.y) + PI;
        this.VitesseDeplacement = 1.5;
        
        if (this.Voiture.PositionHorsCamera.x > -1270 && this.Voiture.PositionHorsCamera.x < -1120 && this.Voiture.PositionHorsCamera.y > -1280 &&this.Voiture.PositionHorsCamera.y < -1124){
            this.Voiture.Direction.y = 0;
            this.Voiture.Direction.x = 10;
        }
        else if (this.Voiture.PositionHorsCamera.x > 1120 && this.Voiture.PositionHorsCamera.x < 1270 && this.Voiture.PositionHorsCamera.y > -1280 &&this.Voiture.PositionHorsCamera.y < -1124){
            this.Voiture.Direction.x = 0;
            this.Voiture.Direction.y = 10;
        }
        else if (this.Voiture.PositionHorsCamera.x > 1120 && this.Voiture.PositionHorsCamera.x < 1270 && this.Voiture.PositionHorsCamera.y > 1120 && this.Voiture.PositionHorsCamera.y < 1270){
            this.Voiture.Direction.y = 0;
            this.Voiture.Direction.x = -10;
        }
        else if (this.Voiture.PositionHorsCamera.x > -1270 && this.Voiture.PositionHorsCamera.x < -1120 && this.Voiture.PositionHorsCamera.y > 1120 && this.Voiture.PositionHorsCamera.y < 1270){
            this.Voiture.Direction.x = 0;
            this.Voiture.Direction.y = -10;
        }
      }
    }
  }
  
 void Animation(){
   if (this.TempsCoupDePoing > 0){
      Hero.Animation = (Hero.Animation + GAME.Delta) % 0.075;
      if (Hero.Animation >= 0.016 && Hero.Animation <= 0.033){
        Hero.Frame = ((Hero.Frame + 1) % 7) + 120;
      }  
   }
   else if (Hero.Velocite.x > 10 || Hero.Velocite.x < -10 || Hero.Velocite.y > 10 || Hero.Velocite.y < -10 ){
      if (Hero.ArmeActuelle == null){
        Hero.Animation = (Hero.Animation + GAME.Delta) % 0.1;
        if (Hero.Animation >= 0.016 && Hero.Animation <= 0.033){
          Hero.Frame = ((Hero.Frame + 1) % 19) + 20;
        }
      }
      if (Hero.ArmeActuelle == Armes[0]){
        Hero.Animation = (Hero.Animation + GAME.Delta) % 0.1;
        if (Hero.Animation >= 0.016 && Hero.Animation <= 0.033){
          Hero.Frame = ((Hero.Frame + 1) % 19) + 60;
        }
      }
      if (Hero.ArmeActuelle == Armes[1]){
        Hero.Animation = (Hero.Animation + GAME.Delta) % 0.2;
        if (Hero.Animation >= 0.016 && Hero.Animation <= 0.033){
          Hero.Frame = ((Hero.Frame + 1) % 19) + 100;
        }
      }
    }
    else{
      if (Hero.ArmeActuelle == null){
        Hero.Animation = (Hero.Animation + GAME.Delta) % 0.1;
        if (Hero.Animation >= 0.016 && Hero.Animation <= 0.033){ 
          Hero.Frame = (Hero.Frame + 1) % 19;
        }
      }
      if (Hero.ArmeActuelle == Armes[0]){
        Hero.Animation = (Hero.Animation + GAME.Delta) % 0.1;
        if (Hero.Animation >= 0.016 && Hero.Animation <= 0.033){
          Hero.Frame = ((Hero.Frame + 1) % 19) + 40;
        }
      }
      if (Hero.ArmeActuelle == Armes[1]){
        Hero.Animation = (Hero.Animation + GAME.Delta) % 0.2;
        if (Hero.Animation >= 0.016 && Hero.Animation <= 0.033){
          Hero.Frame = ((Hero.Frame + 1) % 19) + 80;
        }
      }
  }
  
  for ( int i = 0; i < PNJ.length; i++){
    if (PNJ[i].Mort == false){
      PNJ[i].Animation = (PNJ[i].Animation + GAME.Delta) % 0.1;
      if (PNJ[i].Animation >= 0.016 && PNJ[i].Animation <= 0.033){
         PNJ[i].Frame = ((PNJ[i].Frame + 1) % 20);      
      }
    }
  }
  for ( int i = 0; i < Zombies.length; i++){
    if (Zombies[i].Mort == false){
      if (Zombies[i].Velocite.x > 5 || Zombies[i].Velocite.x < -5 || Zombies[i].Velocite.y > 5 || Zombies[i].Velocite.y < -5){
        Zombies[i].Animation = (Zombies[i].Animation + GAME.Delta) % 0.1;
        if (Zombies[i].Animation >= 0.016 && Zombies[i].Animation <= 0.033){
           Zombies[i].Frame = ((Zombies[i].Frame + 1) % 9)+17;
        }
      }
      else{
        Zombies[i].Animation = (Zombies[i].Animation + GAME.Delta) % 0.1;
        if (Zombies[i].Animation >= 0.016 && Zombies[i].Animation <= 0.033){
           Zombies[i].Frame = ((Zombies[i].Frame + 1) % 9);
        }
      }
    }
  }
  for (int i = 0; i < BalleListe.Balles.size(); i++){
    BalleListe.Balles.get(i).rotation = atan2(BalleListe.Balles.get(i).Velocite.x, -BalleListe.Balles.get(i).Velocite.y);
  }
 }  

 void QuitterVoiture(){
  this.PositionHorsCamera.x = this.Voiture.PositionHorsCamera.x + this.Voiture.HitboxLargeur * cos(this.Voiture.rotation - PI) * 1.2;
  this.PositionHorsCamera.y = this.Voiture.PositionHorsCamera.y + this.Voiture.HitboxLargeur * sin(this.Voiture.rotation - PI) * 1.2;
  this.Voiture.Conducteur = null;
  this.Voiture = null; 
 }
    
 void Mort(){
    if (this != Hero && this.PDVie <= 0){
      this.Mort = true;
      this.Velocite = new PVector(0,0);
    }
    if (this.EstZombie == true && this.Mort == true){
      if (this.DisparitionCadavre <= 0){
        this.PositionHorsCamera.x = random(-4400, -1980);
        this.PositionHorsCamera.y = random(-4400, 4400);
        this.PDVie = 100;
        this.Mort = false;
      }
    }
    if (this.EstNonJoueur == true && this.Mort == true){
      if (this.DisparitionCadavre <= 0){
        this.PositionHorsCamera.x = random(-1080, -720);
        this.PositionHorsCamera.y = random(-1110, 1590);
        this.PDVie = 100;
        this.Mort = false;
      }
    }
    
    if (this == Hero && this.PDVie <= 2 ){
      Jeu = false; 
    }
  }
  
  void TickRate(float Delta){
     if (this.ArmeActuelle != null){
       this.ArmeActuelle.TickRate(Delta);       
     }
     if (this.DisparitionCadavre > 0){
       this.DisparitionCadavre -= Delta;
     }
     if (this.TempsCoupDePoing > 0){
       this.TempsCoupDePoing -= Delta;       
     }
     if (this.Ralentissement > 0){
       this.Ralentissement -= Delta;       
     }
     if (this.TempsEntreMouvement > 0){
       this.TempsEntreMouvement -= Delta;       
     }
     if (this.TempsSortieRoute > 0){
       this.TempsSortieRoute -= Delta;       
     }
  }
  
  void ReponseCollision(PVector OverlapV){
   if (this.Voiture != null){
        this.Voiture.PositionHorsCamera.x += OverlapV.x;
        this.Voiture.PositionHorsCamera.y += OverlapV.y;
    }
    else{
        this.PositionHorsCamera.x += OverlapV.x;
        this.PositionHorsCamera.y += OverlapV.y;
    }
}
}