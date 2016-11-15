class GameInstance{
  ArrayList<Texture> Textures = new ArrayList<Texture>();
  ArrayList<Humanoide> Humanoides = new ArrayList<Humanoide>();
  ArrayList<Balle> Balles = new ArrayList<Balle>();
  ArrayList<GameInstance> GameInstances = new ArrayList<GameInstance>();
  ArrayList<Integer> Index = new ArrayList<Integer>();
  int GIindex;
  int TextureIndex;
  int HumanoideIndex;
  int BalleIndex;
  float Delta;
  float AncienTempsImage;
  
  GameInstance(){
    GIindex = 0;
    TextureIndex = 0;
    HumanoideIndex = 0;
    BalleIndex = 0;
  }
  
  void AjouterTexture(Texture elem){
    Textures.add(elem);
    Index.add(0);
  }
  
  void AjouterGameInstance(GameInstance elem){
    GameInstances.add(elem);
    Index.add(1);
  }
  
  void AjouterHumanoide(Humanoide elem){
    Humanoides.add(elem);
    Index.add(2);
  }
  
  void AjouterBalle(Balle elem){
    Balles.add(elem);
    Index.add(3);
  }
  
  void RetirerTexture(Texture elem){
    this.TextureIndex = 0;
    for (int i = 0; i < this.Index.size(); i += 1)
    {
       if (this.Index.get(i) == 0 && this.Textures.get( this.TextureIndex ) == elem)
       {
         this.Index.remove(i);
         this.Textures.remove( elem );
       }
       this.TextureIndex += 1;
    }
    
  }
    
   void RetirerGameInstance(GameInstance elem){
    this.GIindex = 0;
    for (int i = 0; i < this.Index.size(); i += 1)
    {
       if (this.Index.get(i) == 2 && this.GameInstances.get( this.GIindex ) == elem)
       {
         this.Index.remove(i);
         this.GameInstances.remove( elem );
       }
       this.GIindex += 1;
    }
  }
  
  void RetirerHumanoide(Humanoide elem){
    this.HumanoideIndex = 0;
    for (int i = 0; i < this.Index.size(); i += 1)
    {
       if (this.Index.get(i) == 2 && this.Humanoides.get( this.HumanoideIndex ) == elem)
       {
         this.Index.remove(i);
         this.Humanoides.remove( elem );
       }
       this.HumanoideIndex += 1;
    }
    
  }
  
  void RetirerBalle(Balle elem){
    
    /*
    if (elem.ParentIndex >= 0){ 
    Index.remove(elem.ParentIndex);
    Balles.remove(elem);
    elem.ParentIndex = -1;
    }
    */
    
    this.BalleIndex = 0;
    for (int i = 0; i < this.Index.size(); i += 1)
    {
       if (this.Index.get(i) == 3 && this.Balles.get( this.BalleIndex ) == elem)
       {
         this.Index.remove(i);
         this.Balles.remove( elem );
       }
       this.BalleIndex += 1;
    }
    
  }
  
  void render(){
    GIindex = 0;
    TextureIndex = 0;
    HumanoideIndex = 0;
    BalleIndex = 0;

    for (int i = 0; i < Index.size(); i++){
     if (Index.get(i) == 0 && TextureIndex < Textures.size()){
       Textures.get(TextureIndex).render();
       TextureIndex++;
     } 
     else if (Index.get(i) == 1 && GIindex < GameInstances.size())
     {
       GameInstances.get(GIindex).render();
       GIindex++;
     }
     else if (Index.get(i) == 2 && HumanoideIndex < Humanoides.size())
     {
       Humanoides.get(HumanoideIndex).render();
       HumanoideIndex++;
     }
     else if (Index.get(i) == 3 && BalleIndex < Balles.size())
     {
       Balles.get(BalleIndex).render();
       BalleIndex++;  
     }
    }
    this.Delta = (millis() - this.AncienTempsImage)/1000;
    this.AncienTempsImage = millis();
  }
  
  void updatePositionVelocite(float Delta){
    GIindex = 0;
    TextureIndex = 0;
    HumanoideIndex = 0;
    BalleIndex = 0;
    
    for (int i = 0; i < Index.size(); i++){
     if (Index.get(i) == 0){
       Textures.get(TextureIndex).updatePositionVelocite(Delta);
       TextureIndex++;
     } 
     else if (Index.get(i) == 1 && GIindex < GameInstances.size())
     {
       GameInstances.get(GIindex).updatePositionVelocite(Delta);
       GIindex++;
     }
     else if (Index.get(i) == 2 && HumanoideIndex < Humanoides.size())
     {
       Humanoides.get(HumanoideIndex).updatePositionVelocite(Delta);
       HumanoideIndex++;
     }
     else if (Index.get(i) == 3 && BalleIndex < Balles.size())
     {
       Balles.get(BalleIndex).updatePositionVelocite(Delta);
       BalleIndex++;  
     }
    }
  }
  
  void updatePositionCamera(ClasseCamera camera){
    GIindex = 0;
    TextureIndex = 0;
    HumanoideIndex = 0;
    BalleIndex = 0;
    
    for (int i = 0; i < Index.size(); i++){
     if (Index.get(i) == 0){
       Textures.get(TextureIndex).updatePositionCamera(camera);
       TextureIndex++;
     } 
     else if (Index.get(i) == 1 && GIindex < GameInstances.size())
     {
       GameInstances.get(GIindex).updatePositionCamera(camera);
       GIindex++;
     }
     else if (Index.get(i) == 2 && HumanoideIndex < Humanoides.size())
     {
       Humanoides.get(HumanoideIndex).updatePositionCamera(camera);
       HumanoideIndex++;
     }
     else if (Index.get(i) == 3 && BalleIndex < Balles.size())
     {
       Balles.get(BalleIndex).updatePositionCamera(camera);
       BalleIndex++;  
     }
    }
  }
  
  void AppliquerFriction(){
    GIindex = 0;
    TextureIndex = 0;
    HumanoideIndex = 0;
    BalleIndex = 0;
    
    for (int i = 0; i < Index.size(); i++){
     if (Index.get(i) == 0){
       Textures.get(TextureIndex).AppliquerFriction();
       TextureIndex++;
     } 
     else if (Index.get(i) == 1 && GIindex < GameInstances.size())
     {
       GameInstances.get(GIindex).AppliquerFriction();
       GIindex++;
     }
     else if (Index.get(i) == 2 && HumanoideIndex < Humanoides.size())
     {
       Humanoides.get(HumanoideIndex).AppliquerFriction();
       HumanoideIndex++;
     }
     else if (Index.get(i) == 3 && BalleIndex < Balles.size())
     {
       Balles.get(BalleIndex).AppliquerFriction();
       BalleIndex++;  
     }
    }
  }
  
  void Animation(){
    HumanoideIndex = 0;

     for (int i = 0; i < Index.size(); i++){
       if (Index.get(i) == 2 && HumanoideIndex < Humanoides.size()){
         Humanoides.get(HumanoideIndex).Animation();
         HumanoideIndex++;
       } 
     }
  }
  
  
  void TickRate(float Delta){
    GIindex = 0;
    TextureIndex = 0;
    HumanoideIndex = 0;
    BalleIndex = 0;
    
    for (int i = 0; i < Index.size(); i++){
     if (Index.get(i) == 0){
       Textures.get(TextureIndex).TickRate(Delta);
       TextureIndex++;
     } 
     else if (Index.get(i) == 1 && GIindex < GameInstances.size())
     {
       GameInstances.get(GIindex).TickRate(Delta);
       GIindex++;
     }
     else if (Index.get(i) == 2 && HumanoideIndex < Humanoides.size())
     {
       Humanoides.get(HumanoideIndex).TickRate(Delta);
       HumanoideIndex++;
     }
     else if (Index.get(i) == 3 && BalleIndex < Balles.size())
     {
       Balles.get(BalleIndex).TickRate(Delta);
       BalleIndex++;  
     }
    }
    
  }
  
}