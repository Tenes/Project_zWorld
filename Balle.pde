class Balle extends Texture{
  int DureeDeVie;   
  Balle(String imagePrefix, int Nombre, String Extension, float HitboxLargeur, float HitboxHauteur){ 
    super(imagePrefix, Nombre, Extension, HitboxLargeur, HitboxHauteur);
  }
  
  
  void Degats(Humanoide elem){
    if ((dist(this.PositionHorsCamera.x, this.PositionHorsCamera.y, 
    elem.PositionHorsCamera.x, elem.PositionHorsCamera.y)) < 29 && elem.Mort == false)
    {
      elem.PDVie = 0;
      if (elem.EstZombie == true){
        elem.Frame = int(random(27,30));
      }
      else{
        elem.Frame = int(random(20,23));
      }
      elem.DisparitionCadavre = 3;
      BalleListe.RetirerBalle(this);
      
    }
  }
  
  void updateBalle(){
    if ( this.PositionHorsCamera.x < camera.Position.x || 
      this.PositionHorsCamera.x > camera.Position.x + camera.Largeur || 
      this.PositionHorsCamera.y < camera.Position.y || 
      this.PositionHorsCamera.y > camera.Position.y + camera.Hauteur)
      {
        this.Velocite.x = 0;
        this.Velocite.y = 0;
        //BalleListe.RetirerBalle(this);
        this.PositionHorsCamera.x = -10000;
      }
  }
    
   void TickRate(float Delta){

  }
}