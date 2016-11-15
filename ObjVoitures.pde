class ObjVoitures extends Texture{
  Humanoide Conducteur;
  float PDVie;
  PVector Direction;
  ObjVoitures(String imagePrefix, int Nombre, String Extension, float HitboxLargeur, float HitboxHauteur, float Vie){
    super(imagePrefix, Nombre, Extension, HitboxLargeur, HitboxHauteur);
    Conducteur = null;
    this.PDVie = Vie;
    Direction = new PVector(0,0);
  }
  
  void EtatVoiture(){
   if (this.PDVie == 0)
   {
       this.Conducteur.PositionHorsCamera.x = this.Conducteur.PositionHorsCamera.x - (this.Conducteur.MiLargeur + this.MiLargeur);
       this.Conducteur = null;
       Hero.Voiture = null;
   }
  }
}