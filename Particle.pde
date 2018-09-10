class Particle
{
  final static float RAD = 10;
  final static float BOUNCE = -1;
  final static float SPEED_MAX = 0.2;
  final static float DIST_MAX = 90;
  final static float DIST_MIN = 0;
  PVector speedDefault = new PVector(random(-SPEED_MAX, SPEED_MAX), random(-SPEED_MAX, SPEED_MAX));
  PVector speed = new PVector(0,0);
  //PVector changeSpeed = new PVector(0,0);
  PVector acc = new PVector(0, 0);
  PVector pos;
  //neighboors contains the particles within DIST_MAX distance, as well as itself
  ArrayList<Particle> neighboors;
  
  Particle()
  {
    pos = new PVector (random(-width/2,width/2), random(-heightDist,heightDist));
  }

  public void move()
  {    

    speed.x = speedDefault.x * tempo;
    speed.y = speedDefault.y * tempo;
    
    pos.add(speed);
    
    
    acc.mult(0);
    
    if (pos.x < -width/2)
    {
      pos.x = -width/2;
      speedDefault.x *= BOUNCE;
    }
    else if (pos.x > width/2)
    {
      pos.x = width/2;
      speedDefault.x *= BOUNCE;
    }
    if (pos.y < -heightDist)
    {
      pos.y = -heightDist;
      speedDefault.y *= BOUNCE;
    }
    else if (pos.y > heightDist)
    {
      pos.y = heightDist;
      speedDefault.y *= BOUNCE;
    }
    
  }
  
  public void display()
  {
    fill(255, 14);
    ellipse(pos.x, pos.y, RAD, RAD);
  }
}