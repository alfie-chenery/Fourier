float theta = 0;
FloatList wave;
int c = 10;

void setup(){
  size(1000,600);
  wave = new FloatList();
}

void keyPressed(){
  if(keyCode == UP){
    c++;
  }else if(keyCode == DOWN){
    if(c>1){
      c--;
    }
  }
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

void draw(){
  background(0);
  translate(250,height/2);


  float x = 0;
  float y = 0;

  for (int k=0; k<c; k++){
    int n = k*2 +1;
    
    float prevx = x;
    float prevy = y;
    
    float radius = 100*(4/(n*PI));
    x += radius * cos(n*theta);
    y += radius * sin(n*theta);
  
    stroke(255,100);
    noFill();
    circle(prevx,prevy,radius*2);
  
    stroke(255);
    line(prevx,prevy,x,y);
    
    if (k==c-1){//if outermost circle
      fill(255);
      circle(x,y,5);
      wave=appendStart(wave,y);
    }
  }
  translate(150,0);
  stroke(255,100);
  line(x-150,y,0,wave.get(0));
  
  stroke(255);
  beginShape();
  noFill();
  for (int i=0; i<wave.size(); i++){
    vertex(i,wave.get(i)); 
  }
  endShape();
 
  
  theta+=0.02;
  if(wave.size()>750){
    wave.remove(wave.size()-1);//remove last element 
  }
}
