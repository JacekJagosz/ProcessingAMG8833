import processing.serial.*;
Serial port;
int baudRate = 115200;
int time;
int liczbaArduino=0;
int colord = 1024;
int bok = 800;
int[][] colorp = new int[colord][3];
float[] a = new float[64];
//float[] a = {26,27,28,29,30,31,32,33,26,27,28,29,30,31,32,33,26,27,28,29,30,31,32,33,26,27,28,29,30,31,32,33,26,27,28,29,30,31,32,33,26,27,28,29,30,31,32,33,26,27,28,29,30,31,32,33,26,27,28,29,30,31,32,33};
//int[1024][3] colorp;
int n=0;
int p=0;
PImage img = createImage(bok,bok,RGB);
boolean q=true;
void keyTyped(){
  q=!q;
}
//PImage simg = createImage(8,8,RGB);
void settings(){
   //System.setProperty("jogl.disable.opengles", "true");
    //smooth(0);
    //noSmooth();
  size(bok, bok,FX2D);
  //size(bok, bok,P3D);
}
void setup(){
  //frameRate(15);
  //size(200,200);
 for(int i=0; i<256; i++){
   colorp[i][0]=0;
   colorp[i][1]=i;
   colorp[i][2]=255;
 }
 for(int i=0; i<256; i++){
   colorp[256+i][0]=0;
   colorp[256+i][1]=255;
   colorp[256+i][2]=255-i;
 }
 for(int i=0; i<256; i++){
   colorp[512+i][0]=i;
   colorp[512+i][1]=255;
   colorp[512+i][2]=0;
 }
 for(int i=0; i<256; i++){
   colorp[768+i][0]=255;
   colorp[768+i][1]=255-i;
   colorp[768+i][2]=0;
 }
 String portName = Serial.list()[liczbaArduino];
  port = new Serial(this, portName, baudRate);
 time=millis();
}

void draw(){
  //delay(100);
  port.write('n');
  delay(20);
    while(p!=64 &&(port.available() > 0)){
    String t = null;
    ///if (port.available() > 0){
    t = port.readStringUntil(10);
    //print("0");
    if(t!=null){
    float b = float(t);
    a[p]=b;
    p++;
    //println(b);
    }
  }
    //port.clear();
if (p==64){
float minimum = min(a);
float maximum = max(a);

if(q) interpol();
else noInterpol();
for (int i = 0; i < bok*bok; i++) {
  if(dest[i]<minimum)dest[i]=minimum;
  else if(dest[i]>maximum) dest[i]=maximum;
  int k = int(map(dest[i], minimum, maximum, 0, colord-1));
  //if(k>=1024) k=1023;
  img.pixels[i] = color(colorp[k][0], colorp[k][1], colorp[k][2]); 
  }
img.updatePixels();
//img.resize(bok, bok);
image(img, 0, 0);
//for(int i=0; i<4; i++) line((1+2*i)*bok/8, 0, (1+2*i)*bok/8, bok);
//img.resize(8, 8);

p=0;
textSize(40);
fill(0);
text(a[amg*int((map(pmouseY,0,bok,0,amg)))+int(map(pmouseX,0,bok,0,amg))],pmouseX,pmouseY);
point(pmouseX,pmouseY);
textSize(20);
text(String.format("%.2f", minimum)+" - "+String.format("%.2f", maximum), 10, 30);
println(millis()-time);
time=millis();
//port.clear();
}}
