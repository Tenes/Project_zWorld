class Overlap{
  float Overlap;
  PVector OverlapN;
  PVector OverlapV;
  Overlap(){
    Overlap = Float.POSITIVE_INFINITY;
    OverlapN = new PVector(0, 0);
    OverlapV = new PVector(0, 0);
  }
}