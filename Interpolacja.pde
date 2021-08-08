int amg=8;
float mu = (amg - 1.0)/(bok-1.0);
int x,y;
float xx,yy;
float[] adj_2d=new float[16];
float[] dest= new float[bok*bok];
float[] arr = {0,0,0,0};
void noInterpol(){
  //float X = bok / amg;
  for(int i=0; i<bok*bok; i++){
    int kolumna = min(int(((i%bok)*amg)/bok), 7);
    int rzad = min(int((i/bok)*amg/bok), 7);
    int temp = 8*rzad + kolumna;
    dest[i] = a[temp];
    
  }

}
void interpol(){
  //float[] adj_2d=new float[16]; - nie wiem, czy można
  for(int yi=0; yi<bok; yi++){
    for(int xi=0; xi<bok; xi++){
      xx = xi * mu;
      //print(mu);
      x=int(xx);
      yy = yi * mu;
      //print(yy);
      y=int(yy);
      get_adjacents_2d(x, y);
      float frac_x = xx - x;//nie wiem jak zadziała ze względu na działanie int()
      float frac_y = yy - y;//może int(yy)
      float out = bicubicInterpolate(frac_x, frac_y);
      //print(out);
      dest[int(yi*bok+xi)]=out;
      //print(yy*bok+xx);
    }
  }
}
float cubicInterpolate(int p, float x){
  float r = adj_2d[1+p] + (0.5 * x * (adj_2d[2+p] - adj_2d[p] + x*(2.0*adj_2d[p] - 5.0*adj_2d[1+p] + 4.0*adj_2d[2+p] - adj_2d[3+p] + x*(3.0*(adj_2d[1+p] - adj_2d[2+p]) + adj_2d[3+p] - adj_2d[p]))));
  return r;
}
float cubicInterpolate2(float x){
  int p=0;
  //print(arr[0]);
  float r = arr[1+p] + (0.5 * x * (arr[2+p] - arr[p] + x*(2.0*arr[p] - 5.0*arr[1+p] + 4.0*arr[2+p] - arr[3+p] + x*(3.0*(arr[1+p] - arr[2+p]) + arr[3+p] - arr[p]))));
  return r;
}
float bicubicInterpolate(float x, float y) {
    //arr[] = {0,0,0,0};
    arr[0] = cubicInterpolate(0, x);
    //print(arr[0]);
    arr[1] = cubicInterpolate(4, x);
    arr[2] = cubicInterpolate(8, x);
    arr[3] = cubicInterpolate(12, x);
    //print(arr[3]);
    return cubicInterpolate2(y);
}
void get_adjacents_2d(int x, int y){
  for(int delta_y=-1; delta_y < 3; delta_y++)
    for(int delta_x=-1; delta_x<3; delta_x++){
//print((y+delta_y)*amg+delta_x+x);
//int aa=(y+delta_y)*amg+delta_x+x;
int a1=y+delta_y;
int a2=x+delta_x;
if(a1<0){
  a1=0;
  
}
if(a1>=amg-1){
  
  a1=amg-1;
}
if(a2<0) {
a2=0;

}
if(a2>=amg-1){
  a2=amg-1;
}
  int aa=a1*amg+a2;
    adj_2d[delta_x+1+(delta_y+1)*4]=a[aa];
}}
