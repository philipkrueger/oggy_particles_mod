public void Menge(int theValue) {
  midi[1] = theValue;
 println(theValue); 
}

public void Speed(int theValue) {
  midi[2] = theValue; 
}

public void Stroke(int theValue) {
  midi[3] = theValue; 
}

public void Fill(int theValue) {
  midi[4] = theValue; 
}

public void Move(int theValue) {
  midi[0] = theValue; 
}

public void Min(int theValue) {
  midi[5] = theValue; 
}

public void Max(int theValue) {
  midi[6] = theValue; 
}

public void Line(int theValue) {
  midi[7] = theValue; 
}

public void Radius(int theValue) {
  midi[8] = theValue; 
}

public void Inc(int theValue) {
  midi[10] = theValue; 
}

public void Delay(int theValue) {
  midi[9] = theValue; 
}

public void Size(int theValue) {
  midi[11] = theValue; 
}

public void Text(String text) {
  txt = text;
  offSet = txtSize/3;
  Logo = RG.getText(text, "Futura-Medium-01.ttf", txtSize, CENTER);
 // Logo = RG.centerIn(Logo, g, 100);
println(txt);
}

public void Vector(String text) {
  txt = text;
  offSet = 0;
  Logo = RG.loadShape("vector/" + text);
  Logo = RG.centerIn(Logo, g, 100);
println(txt);
}


public void Next(int theValue) {
 // println("a button event from colorC: "+theValue);
  wrd += theValue;
  if (wrd > words.length-1)
  {
    wrd = 1;
  }
  offSet = txtSize/3;
 // translate(0,height/4);
   Logo = RG.getText(words[wrd], "DIN Condensed Bold.ttf", txtSize, CENTER); 
  // Logo.centerIn(g, 100, 4, 1.3);
  //Logo = RG.centerIn(Logo, g, 100);
}

void bar(int n) {
  if (n == 0)
  {
    offSet = 0;
    Logo = RG.loadShape("vector/Antifa.svg");
    Logo = RG.centerIn(Logo, g, 100);
  }
  println("bar clicked, item-value:", n);
}



void input() 
{
 // Logo = RG.getText(txt, "Futura-Medium-01.ttf", 72, CENTER);  
 // Logo = RG.loadShape("Kontrast_logo.svg");
  Logo = RG.centerIn(Logo, g, 100);
}