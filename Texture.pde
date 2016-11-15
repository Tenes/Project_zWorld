class Texture {
 PImage[] images;
 PVector Position;
 PVector PositionHorsCamera;
 PVector Velocite;
 float friction;
 float rotation;
 float MiLargeur;
 float MiHauteur;
 float DistX;
 float DistY;
 int NombreImage;
 int Frame;
 float HitboxHauteur;
 float HitboxLargeur;
 PVector OverlapV;
 boolean Activer;
 Texture(String imagePrefix, int Nombre, String Extension, float HitboxLargeur, float HitboxHauteur) {
   Position = new PVector(0,0);
   PositionHorsCamera = new PVector(0,0);
   Velocite = new PVector(0,0);
   friction = 0.95;
   rotation = 0;
   NombreImage = Nombre;
   images = new PImage[NombreImage];
   for (int i = 0; i < NombreImage; i++) {
      String NomFichier = imagePrefix + i + Extension;
      images[i] = loadImage(NomFichier);
    }
   MiLargeur = images[0].width/2;
   MiHauteur = images[0].height/2;
   this.HitboxLargeur = HitboxLargeur;
   this.HitboxHauteur = HitboxHauteur;
   OverlapV = new PVector(0,0);
   Activer = false;
   
 }
 
 void updatePositionVelocite(float Delta){
   this.PositionHorsCamera.x += this.Velocite.x*Delta;
   this.PositionHorsCamera.y += this.Velocite.y*Delta;
 }
 
 void updatePositionCamera(ClasseCamera camera) {
  Position.x = (PositionHorsCamera.x - camera.Position.x);
  Position.y = (PositionHorsCamera.y - camera.Position.y);
 }
 
 void render() {
  pushMatrix();
  translate(Position.x, Position.y);
  rotate(rotation);
  image(images[Frame], -MiLargeur, -MiHauteur); 
  popMatrix();
 }
 
 void AppliquerFriction(){
   this.Velocite.mult(friction);
 }
 
 void MouvementBarriere(Texture elem){
   if (this.PositionHorsCamera.x > -900){
     Activer = true; 
   }
   if (Activer == true){
     this.PositionHorsCamera.x -= 2;
     elem.PositionHorsCamera.x += 2; 
   }
   else if (this.PositionHorsCamera.x <= -900){
     Activer = false; 
   }
   
 }
 
 float[] ObtenirAngles(){
   float[] Angles;
   Angles = new float[8];
   //Bas-Gauche
   Angles[0] = (HitboxLargeur/2) * cos(this.rotation) - (HitboxHauteur/2) * sin(this.rotation) + this.PositionHorsCamera.x;
   Angles[1] = (HitboxLargeur/2) * sin(this.rotation) + (HitboxHauteur/2) * cos(this.rotation) + this.PositionHorsCamera.y;
   
   //Haut-Gauche
   Angles[2] = -(HitboxLargeur/2) * cos(this.rotation) - (HitboxHauteur/2) * sin(this.rotation) + this.PositionHorsCamera.x;
   Angles[3] = -(HitboxLargeur/2) * sin(this.rotation) + (HitboxHauteur/2) * cos(this.rotation) + this.PositionHorsCamera.y;
  
   //Haut-Droite
   Angles[4] = -(HitboxLargeur/2) * cos(this.rotation) + (HitboxHauteur/2) * sin(this.rotation) + this.PositionHorsCamera.x;
   Angles[5] = -(HitboxLargeur/2) * sin(this.rotation) - (HitboxHauteur/2) * cos(this.rotation) + this.PositionHorsCamera.y;
          
   //Bas-Droite
   Angles[6] = (HitboxLargeur/2) * cos(this.rotation) + (HitboxHauteur/2) * sin(this.rotation) + this.PositionHorsCamera.x;
   Angles[7] = (HitboxLargeur/2) * sin(this.rotation) - (HitboxHauteur/2) * cos(this.rotation) + this.PositionHorsCamera.y;
   
   return Angles;
 }
 
 /*boolean DetectionCollision(Texture obstacle){
   if ((this.PositionHorsCamera.x + this.MiLargeur-12 > obstacle.PositionHorsCamera.x - obstacle.MiLargeur && this.PositionHorsCamera.x - this.MiLargeur+12 < obstacle.PositionHorsCamera.x + obstacle.MiLargeur &&
    this.PositionHorsCamera.y + this.MiLargeur > obstacle.PositionHorsCamera.y - obstacle.MiHauteur && this.PositionHorsCamera.y - this.MiLargeur < obstacle.PositionHorsCamera.y + obstacle.MiHauteur))
    {
      return true;
    }
   else{
     return false;
     }
   }
   
 void ReponseCollision(Texture obstacle){
    DistX = (this.PositionHorsCamera.x - obstacle.PositionHorsCamera.x) / (this.MiLargeur + obstacle.MiLargeur) ;
    DistY = (this.PositionHorsCamera.y - obstacle.PositionHorsCamera.y) / (this.MiHauteur + obstacle.MiHauteur) ;
    if (abs(DistX) > abs(DistY)){
        if (DistX > 0){       // Si il y a colision de la gauche du personnage avec un objet alors...
            Normal = new PVector(1,0);
            this.Velocite.sub(Normal.mult(Normal, Normal.dot(Velocite)));
            this.PositionHorsCamera.x += 0.2;
        }
        else{                 // Si il y a colision de la droite du personnage avec un objet alors...
            Normal = new PVector(-1,0);
            this.Velocite.sub(Normal.mult(Normal, Normal.dot(Velocite)));
            this.PositionHorsCamera.x -= 0.2;
        }
    }
    else{
        if (DistY > 0){       // Si il y a colision du dessous du personnage avec un objet alors...
            Normal = new PVector(0,1);
            this.Velocite.sub(Normal.mult(Normal, Normal.dot(Velocite)));
            this.PositionHorsCamera.y += 0.2;
        }
        else{                 // Si il y a colision du dessus du personnage avec un objet alors...
            Normal = new PVector(0,-1);
            this.Velocite.sub(Normal.mult(Normal, Normal.dot(Velocite)));
            this.PositionHorsCamera.y -= 0.2;
        }
    }
  }*/
  
  void TickRate(float Delta){

  }

  void FlattenedPointsOn(float [] xPoints, PVector Normal, float[] FlattenedPoints){

        float Min = Float.POSITIVE_INFINITY;
        float Max = Float.NEGATIVE_INFINITY;

        for (int i = 0; i < xPoints.length; i += 2 ){
            float Dot = Normal.dot(new PVector (xPoints[i], xPoints[i+1]));
            if (Dot < Min){
              Min = Dot;
            }

            if (Dot > Max){
              Max = Dot;
            }
        }
        FlattenedPoints[0] = Min;
        FlattenedPoints[1] = Max;

    }


  boolean AxeSeparateur(PVector selfPosition, PVector obsPosition, float[] aPoints, float[] bPoints, PVector Normal, Texture obs, Overlap Results){
    PVector OffsetVecteur = new PVector (obsPosition.x, obsPosition.y);
    OffsetVecteur.sub(selfPosition);
    if (OffsetVecteur.mag() > this.HitboxLargeur + obs.HitboxLargeur + this.HitboxHauteur + obs.HitboxHauteur){
              return true;
          }
    float OffsetProjete = new PVector (OffsetVecteur.x, OffsetVecteur.y).dot(Normal);
    float [] FlattenedPointsA = new float[2];
    float [] FlattenedPointsB = new float[2];
    this.FlattenedPointsOn( aPoints, Normal, FlattenedPointsA);
    this.FlattenedPointsOn( bPoints, Normal, FlattenedPointsB);
    float option1 = FlattenedPointsA[1] - FlattenedPointsB[0];
    float option2 = FlattenedPointsB[1] - FlattenedPointsA[0];
    
    FlattenedPointsA[0] += OffsetProjete;
    FlattenedPointsB[1] += OffsetProjete;
    
    if (FlattenedPointsA[0] > FlattenedPointsB[1] || FlattenedPointsB[0] > FlattenedPointsA[1]){
      return true;
    }
    float overlap = 0;
   
    if (FlattenedPointsA[0] < FlattenedPointsB[0]){ 
        if (FlattenedPointsA[1] < FlattenedPointsB[1]){
            overlap = FlattenedPointsA[1] - FlattenedPointsB[0];
        }
        else{
            if (option1 < option2){
               overlap = option1;
            }
            else{
              overlap = -option2;
            }
        }
    }
    else{
        if (FlattenedPointsA[1] > FlattenedPointsB[1]){
            overlap = FlattenedPointsA[0] - FlattenedPointsB[1];
   
        }
        else{ 
            if (option1 < option2){
               overlap = option1;
            }
            else{
              overlap = -option2;
            }
        }
    }
 
    float absOverlap = overlap;
    if (overlap < 0){
      absOverlap *= -1; 
    }
   
    if (absOverlap < Results.Overlap){
        Results.Overlap = absOverlap;
        Results.OverlapN = new PVector(Normal.x, Normal.y);
   
        if (overlap < 0){
            Results.OverlapN.x *= -1;
            Results.OverlapN.y *= -1;
        }
    }
    return false;
  }


  boolean DetectionCollision(Texture obstacle){
   float[] aPoints = this.ObtenirAngles();
   float[] bPoints = obstacle.ObtenirAngles();
   PVector Normal = new PVector(0,0);
   Overlap Results = new Overlap(); 
   for (int i = 0; i < aPoints.length/2; i += 2){
     Normal.x = aPoints[(i+2) % 8] - aPoints[i];
     Normal.y = aPoints[((i+2) % 8)+1] - aPoints[i+1];
     Normal.normalize();
     if (this.AxeSeparateur (this.PositionHorsCamera, obstacle.PositionHorsCamera, aPoints, bPoints, Normal, obstacle, Results) ){
        return false;
     }
   }
   for (int i = 0; i < bPoints.length/2; i += 2){
     Normal.x = bPoints[(i+2) % 8] - bPoints[i];
     Normal.y = bPoints[((i+2) % 8)+1] - bPoints[i+1];
     Normal.normalize();
     if (this.AxeSeparateur (obstacle.PositionHorsCamera, this.PositionHorsCamera, bPoints, aPoints, Normal, obstacle, Results) ){
        return false;
     }
   }
   this.OverlapV.x = Results.OverlapN.x;
   this.OverlapV.y = Results.OverlapN.y;
   this.OverlapV.mult(Results.Overlap);
   return true;
  }
  
  
  void ReponseCollision(PVector OverlapV){
        this.PositionHorsCamera.x += OverlapV.x;
        this.PositionHorsCamera.y += OverlapV.y;
}
}