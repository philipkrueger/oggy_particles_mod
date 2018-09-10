//  This sketch is based on the "particles triangles" sketch by oggy: https://www.openprocessing.org/sketch/147268


//  APC40 Midi Setup:
//  • Menge  • Speed  • Stroke  • Fill
//  • Min    • Max    • onLine  • Radius
//  Master: movePrtSize  CrossFader: incSpeed

import controlP5.*;
import codeanticode.syphon.*;
import themidibus.*;
import javax.sound.midi.MidiMessage;
import geomerative.*;

ControlP5 cp5;
SyphonServer server;
MidiBus myBus;

final int NB_PARTICLES = 500;   //      ----------------------  <- Partikelmenge
int onLine = 60;
int nb_part;
String[] words;
ArrayList<Triangle> triangles;
Particle[] parts = new Particle[NB_PARTICLES];

PVector center = new PVector(0,0);
int centerDist =300;

RShape Logo;
RPoint[] LogoPnts;

int ind = 30;
float fixMove = 0.001;
float distMIN;
float distMAX;
int startPnt = 0;
int heightDist;
int growth;
boolean[] fix = new boolean[NB_PARTICLES];
boolean[] mold = new boolean[NB_PARTICLES];

int [] midi = new int [20];

float movePrt;
int movePrtSize = 60;
float tempo = 1;
int bnce = -1;
int wrd = 0;
int midi8 = 0;

int LogoRes = 50;
int offSet = 0;

float a = 0.0;
float inc = TWO_PI/10;
int incSpeed = 100;
String txt;
int txtSize;
color[] pix;


void setup()
{
  size(1280, 754, P2D);
  smooth(8);
  
  words = loadStrings("Reclaim.txt");
  cp5 = new ControlP5(this);
  cp5.addSlider("Menge", 0, 127, 100, 0, 0, width/6, 10);
  cp5.addSlider("Speed", 0, 127, 90, width/5, 0, width/6, 10);
  cp5.addSlider("Stroke", 0, 127, 40, width/5*2, 0, width/6, 10);
  cp5.addSlider("Fill", 0, 127, 0, width/5*3, 0, width/6, 10);
  cp5.addSlider("Move", 0, 127, 50, width/5*4, 0, width/6, 10);
  cp5.addSlider("Min", 0, 127, 0, 0, 12, width/6, 10);
  cp5.addSlider("Max", 0, 127, 50, width/5, 12, width/6, 10);
  cp5.addSlider("Line", 127, 0, 30, width/5*2, 12, width/6, 10);
  cp5.addSlider("Radius", 0, 127, 127, width/5*3, 12, width/6, 10);
  cp5.addSlider("Inc", 0, 127, 16, width/5*4, 12, width/6, 10);
  cp5.addSlider("Delay", 0, 127, 10, width/5*4, 24, width/6, 10);
  cp5.addSlider("Size", 0, 127, 100, width/5*3, 24, width/6, 10);
  cp5.addTextfield("Text", 0, 24, width/10, 10)
     .setColorLabel(0) ;
  cp5.addTextfield("Vector", width/5, 24, 100, 10)
     .setColorLabel(0) ;   
  cp5.addButton("Next")
     .setValue(1)
     .setPosition(width/5*2,24)
     .setSize(50,10)
     ;  
  ButtonBar bttn = cp5.addButtonBar("bar")
     .setPosition(width/10, 24)
     .setSize(width/10, 10)
     .addItems(split("a b c"," "))
     ;
  bttn.onMove(new CallbackListener(){
    public void controlEvent(CallbackEvent ev) {
      ButtonBar bar = (ButtonBar)ev.getController();
      println("hello ",bar.hover());
    }
  });
     
  txtSize = 400; 
  offSet = txtSize/3;
  heightDist = height/2 - 17;
  MidiBus.list();
  RG.init(this);
 // Logo = RG.loadShape("Kontrast_logo.svg");
  Logo = RG.getText(words[wrd], "DIN Condensed Bold.ttf", txtSize, CENTER);
 // Logo = RG.centerIn(Logo, g, 100);
 // RG.shape(Logo,width/2,50);
  
  myBus = new MidiBus(this, 0, 0);
  myBus.sendTimestamps(false);
  
  distMIN = Particle.DIST_MIN;
  distMAX = Particle.DIST_MAX;
  
  onLine = 260;
  
  server = new SyphonServer(this, "Processing Syphon");
  
  
  for (int i = 0; i < NB_PARTICLES; i++)
  {
    parts[i] = new Particle();
    fix[i] = false;
  }
  
  midi[1] = 100;  //Particle
  midi[2] = 90;  //Speed
  midi[3] = 40;  //Stroke
  midi[6] = 50;  //MaxDist
  midi[7] = 30;  //onLine
  midi[8] = 127; //Radius
  midi[9] = 7;   //Delay
  midi[10]= 16;  //incSpeed
  midi[11]= 100;  //txtSize
  midi[0] = 50;    //Move
  
  background(0);
}

void draw()
{
  noStroke();
 fill(0, midi[9]*2);
 rect(0,0,width,height);
  translate(width/2, height/2 + 17);
  triangles = new ArrayList<Triangle>();
  Particle p1, p2;
  
 distMIN = midi[5];
 distMAX = midi[6];
 movePrtSize = midi[0];
 incSpeed = midi[10]*100+500;
 onLine  = midi[7];
 txtSize = midi[11]*4;
 
 nb_part = int(map(midi[1],0,127,50,NB_PARTICLES));
 tempo   = map(midi[2],0,127,0.1,10); 
 centerDist = int (map(midi[8],0,127,0,sqrt(sq(width)+sq(height))));
  
  
  
  RG.setPolygonizer(RG.UNIFORMLENGTH);
  RG.setPolygonizerLength(map(movePrt, 0, 127, onLine, onLine*2));
  //heightDist = int (map(mouseX, 0, width, 35, height/2));

 LogoPnts = Logo.getPoints();

 
    myBus.sendMessage(
    new byte[] {
      (byte)0xF0, (byte)0x1, (byte)0x2, (byte)0x3, (byte)0x4, (byte)0xF7
    }
    );
    
   //println("SVG Punkte: "+LogoPnts.length+", Max: "+distMAX+", Dicke: "+map(midiValue_4,0,127,0.5,5)+", onLine:"+onLine+", p50 Default: "+parts[50].speedDefault.x+", p50 Speed: "+parts[50].speed.x); 
 
if (LogoPnts.length<NB_PARTICLES-1){    
  for (int i = startPnt; i < LogoPnts.length; i++)      // ----------------------- <- Particles positionieren
  { 
      mold[i] = false;
      //if ((parts[i].pos.x > ((midiValue_2*6)-(width/2)))&&(parts[i].pos.y < ((midiValue_3*6)-(height/2)))){
      //if ((parts[i].pos.x > (map(midiValue_5,0,127,-width/2,width/2)))&&(parts[i].pos.y < (map(midiValue_6,0,127,-height/2,height/2)))){  
      if (parts[i].pos.dist(center)<centerDist){
        mold[i] =true;   
      }
      if (mold[i]){
        parts[i].pos.x = LogoPnts[i].x;
        parts[i].pos.y = LogoPnts[i].y + offSet;
        fix[i] =true;
      }
      if (!mold[i]) {
        parts[i].move();
      }
      
  
  }
  
    for (int i = 0; i< NB_PARTICLES; i++)    
  {         
      if (i == startPnt){
      i = LogoPnts.length;
      }
      if (fix[i]){
      parts[i].pos.x = random(-width/2,width/2);
      parts[i].pos.y = random(-height/2,height/2);
      //println("heppa "+ i + " "+LogoPnts.length);
      fix[i] = false;
      } 
      
      parts[i].move();
      fix[i]=false;  
  }
  }
 fixAni();
  
  


fill(255,0,0);
//ellipse(parts[ind].pos.x,parts[ind].pos.y,40,40);
noFill();
  
//  parts[NB_PARTICLES - 1].pos = new PVector(0,0);                //Achtung!! Translate Mitte
//  parts[NB_PARTICLES - 2].pos = new PVector(0,height); 
//  parts[NB_PARTICLES - 3].pos = new PVector(width,0); 
//  parts[NB_PARTICLES - 4].pos = new PVector(width,height); 

  for (int i = 0; i < nb_part; i++)
  {
    p1 = parts[i];
    p1.neighboors = new ArrayList<Particle>();
    p1.neighboors.add(p1);
    for (int j = i+1; j < nb_part; j++)
    {
      p2 = parts[j];
      float d = PVector.dist(p1.pos, p2.pos); 
      if (d > distMIN && d < distMAX)
      {
        p1.neighboors.add(p2);
      }
    }
    if(p1.neighboors.size() > 1)
    {
      addTriangles(p1.neighboors);
    }
  }
  drawTriangles();
  
  
  
    if (keyPressed)
  {
    if (key == ENTER)
    {
   //   input();
    }
    /*if (key == TAB)
    {
    //  wrd +=1 ;
      if (wrd > words.length)
      {
        wrd = 0;
      }
    Logo = RG.loadShape(words[wrd]);
    Logo = RG.centerIn(Logo, g, 100);
    println(wrd);
    }*/
  }
  
 // println(midi[1]);
  server.sendScreen();
translate(-width/2,-height/2 - 17);
}
//-----------------------------------------------------------------

void keyReleased() {
 
  if(keyCode == TAB){                              
     wrd +=1 ;
     if (wrd > words.length-1)
     {
        wrd = 1;
     }
     offSet = txtSize/3;
     Logo = RG.getText(words[wrd], "Futura-Medium-01.ttf", txtSize, CENTER);    
     //Logo = RG.centerIn(Logo, g);
     println(wrd+" "+g);
   }
}



void fixAni(){
//  for (int i = 0; i<100; i++){
    inc = TWO_PI/incSpeed;
    
    fixMove = sin(a);
    a = a + inc;
//  }
    
    movePrt = fixMove * movePrtSize;
 // println(movePrt+"   "+a);
}



/*  
  if (midiValue_1 > 126 && fixMove < 0){
  midiValue_1 = 126;
  fixMove = fixMove *-1;
  println(midiValue_1);
}
  if (midiValue_1 < 1 && fixMove > 0){
    midiValue_1 = 1;
    fixMove = fixMove *-1;
}
midiValue_1 += fixMove;
//println(midiValue_1+ "     "+fixMove);
}


void mouseWheel(MouseEvent event) {
  midiValue_1 += event.getCount()/10;
  if (midiValue_1 >= 127){
  midiValue_1 = 126;
  //println(midiValue_1);
}
  if (midiValue_1 <= 0){
    midiValue_1 = 1;
}
  
 println(LogoPnts.length+"   "+NB_PARTICLES+"   ");
}
*/
void mouseClicked() {
  center = new PVector(mouseX-width/2,mouseY-height/2);
}