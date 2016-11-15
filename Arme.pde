class Arme {
  Humanoide Detenteur;
  String Type;
  float CadenceTir;
  int Degat;
  float VitesseProjectile;
  PVector DestinationBalle;
  int CapaciteChargeur;
  int BalleChargeur;
  float AncienTir;
  float Rechargement;
  Arme(String elem, float CadenceTir, int Degats, float VitesseProjectile,int CapaciteChargeur, int BalleChargeur){ 
    DestinationBalle = new PVector(0,0);
    this.Type = elem;
    this.Degat = Degats;
    this.CadenceTir = CadenceTir;
    this.VitesseProjectile = VitesseProjectile;
    this.CapaciteChargeur = CapaciteChargeur;
    this.BalleChargeur = BalleChargeur;
  }
   
  void TireVers(float x, float y, GameInstance Instance){
    if (this.Rechargement <= 0  && this.AncienTir <= 0&& Hero.ArmeActuelle.BalleChargeur > 0){
    Balle NouvelleBalle = new Balle("Images/Armes/Balle_", 1, ".png", 8, 8);
    NouvelleBalle.friction = 1;
    NouvelleBalle.PositionHorsCamera.x = Detenteur.PositionHorsCamera.x + (Detenteur.HitboxLargeur/2) * cos(Detenteur.rotation);
    NouvelleBalle.PositionHorsCamera.y = Detenteur.PositionHorsCamera.y + (Detenteur.HitboxHauteur/2) * sin(Detenteur.rotation);
    DestinationBalle.x = x - NouvelleBalle.PositionHorsCamera.x;
    DestinationBalle.y = y - NouvelleBalle.PositionHorsCamera.y;
    
    DestinationBalle.setMag(this.VitesseProjectile);
    NouvelleBalle.Velocite.add(DestinationBalle);
    
    NouvelleBalle.PositionHorsCamera.x += NouvelleBalle.Velocite.x * 0.0167;
    NouvelleBalle.PositionHorsCamera.y += NouvelleBalle.Velocite.y * 0.0167;
    
    Instance.AjouterBalle(NouvelleBalle);
    this.AncienTir = 1/this.CadenceTir;
    this.BalleChargeur -= 1;
    }
  } 
  
  void Recharger(){
       this.Rechargement = 1;
  }
  
  void TickRate(float Delta){
    if (this.Rechargement > 0){
      this.Rechargement -= Delta;
      if (this.Rechargement <= 0){
        this.BalleChargeur = CapaciteChargeur; 
      }
    }
    if (this.AncienTir > 0){
      this.AncienTir -= Delta;
      this.Detenteur.VitesseDeplacement = 0.25;
    }
  }
}