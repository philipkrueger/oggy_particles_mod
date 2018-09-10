class Triangle
{
  PVector A, B, C; 

  Triangle(PVector p1, PVector p2, PVector p3)
  {
    A = p1;
    B = p2;
    C = p3;
  }
  
  public void display()
  {
    vertex(A.x, A.y);
    vertex(B.x, B.y);
    vertex(C.x, C.y);
  }
}


void drawTriangles()
{
  noStroke();
  fill(255,255,255,midi[4]);              // ----------------------------------- <- Triangle Fill/Farbe
  stroke(255,255,255,10);          // ----------------------------------- <- Stroke Farbe Triangles
  strokeWeight(map(midi[3],0,127,0.5,5));    // ----------------------------------- <- Stroke Stärke!!
  //noFill();
  beginShape(TRIANGLES);
  for (int i = 0; i < triangles.size(); i ++)
  {
    Triangle t = triangles.get(i);
    t.display();
  }
  endShape();  
}

void addTriangles(ArrayList<Particle> p_neighboors)
{
  int s = p_neighboors.size();
  if (s > 2)
  {
    for (int i = 1; i < s-1; i ++)
    { 
      for (int j = i+1; j < s; j ++)
      { 
         triangles.add(new Triangle(p_neighboors.get(0).pos, p_neighboors.get(i).pos, p_neighboors.get(j).pos));
      }
    }
  }
}