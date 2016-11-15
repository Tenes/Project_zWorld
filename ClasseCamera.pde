class ClasseCamera{
  PVector Position;
  PVector Normal;
  int Vitesse;
  int Largeur;
  int Hauteur;
  Texture Follow;
  ClasseCamera(int width, int height, Texture elem){
    Position = new PVector(elem.Position.x - width/2, elem.Position.y - height/2);
    Vitesse = 5;
    Largeur = width;
    Hauteur = height;
    Follow = elem;
  }
  
  void Marche(ClasseCamera elem){
      this.Position.x += (elem.Follow.PositionHorsCamera.x-elem.Position.x-(Largeur/2))/Vitesse;
      this.Position.y += (elem.Follow.PositionHorsCamera.y-elem.Position.y-(Hauteur/2))/Vitesse;
  }
}