float theta = 0;
float dt;
FloatList wave;
FloatList Y;
ArrayList<Complex> fourierY;

void setup(){
  size(800,800);
  wave = new FloatList();
  fourierY = new ArrayList<Complex>();
  Y = new FloatList();
  
  ////INPUT SIGNAL
  for(int i=0; i<100; i++){
    //Y.append(100*sin(map(i,0,100,0,TWO_PI)));
    //Y.append(100*cos(map(i,0,100,0,TWO_PI)));
    Y.append(0.0001*tan(map(i,0,100,0,TWO_PI)));
    //Y.append(i);
  }
  ////INPUT SIGNAL
  
  fourierY = FourierTransform(Y);
  
  dt = TWO_PI / fourierY.size();
}

void draw(){
  background(0);
  translate(200,height/2);
  
  float x = 0;
  float y = 0;
  
  for(int i=0; i<fourierY.size(); i++){
    float prevx = x;
    float prevy = y;
    
    int freq = fourierY.get(i).freq;
    float radius = fourierY.get(i).amp;
    float phase = fourierY.get(i).phase;
    
    x += radius * cos(freq * theta + phase + HALF_PI);
    y += radius * sin(freq * theta + phase + HALF_PI);
    
    
    
    stroke(255,100);
    noFill();
    circle(prevx,prevy, radius*2);
    stroke(255);
    line(prevx,prevy,x,y);
  }
  appendStart(wave,y);
  
  translate(200,0);
  line(x-200,y,0,wave.get(0));
  beginShape();
  noFill();
  for(int i=0; i<wave.size(); i++){
    vertex(i,wave.get(i)); 
  }
  endShape();
  
  theta += dt;
  if (wave.size()>width/2){
    wave.remove(wave.size()-1);
  }
}


ArrayList<Complex> FourierTransform(FloatList vals){
  int N = vals.size();
  ArrayList<Complex> fourier = new ArrayList<Complex>();
  
  for(int k=0; k<N; k++){
    float re = 0;
    float im= 0;
    
    for(int n=0; n<N; n++){
      float phi = (TWO_PI*k*n)/N;
      re += vals.get(n) *cos(phi);
      im -= vals.get(n) *sin(phi);
    }    
    
    re = re/N;
    im = im/N;
    float amp = sqrt(re*re+im*im);
    int freq = k;
    float phase = atan2(im,re);
    
    Complex c = new Complex(re,im,amp,freq,phase);
    fourier.add(c); 
  }
  
  
  return fourier;
}




//equivilant of p5js unshift
FloatList appendStart(FloatList array, float item){
  for(int i=array.size(); i>0; i--){
    array.set(i,array.get(i-1));
    //set index to value before it
  }//has effect of shifting everything to the right one
  array.set(0,item);
  
  return array;
}
