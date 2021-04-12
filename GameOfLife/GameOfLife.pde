//Codigo hecho con base a los ejemplos de processing de el GameOfLife, Button, frameRate, MouseFuntions y wikipedia.org/wiki/Juego_de_la_vida
//declaración de tamaño de celdas y "matrices" de estados
int fps = 10;
int size = 10;
int[][] lug; 
int[][] lugNue; 
byte [] save;
color rectColor1, rectColor2, rectColor3, rectColor4;
color base;
//boolean para iniciar y pausar
boolean pause = true;
//tamaño de la cuadricula usada para el juego
int gridX = 800;
int gridY = 800;
void setup() {
  size (1000,800);
  rectColor1 = color(90);
  rectColor2 = color(0,255,0);
  rectColor3 = color(0);
  rectColor4 = color(255,0,0);
  save = new byte [((gridX/size)*(gridY/size))+80];
  stroke(90);
  lug = new int[gridX/size][gridY/size];
  lugNue = new int[gridX/size][gridY/size];
  for (int f=0; f<800/size;f++){
    for (int c=0; c<800/size;c++){
      lug[f][c]= 0;
    }
  } 
  background(0);
}
void draw(){
  botones();
  //Dibujar cuadricula, revisar y actualizar el estado de las posiciones de la "matriz" lugares
  for (int f=0; f<800/size;f++){
    for (int c=0; c<800/size;c++){
      if (lug[f][c] == 0){
        fill(rectColor3);
      }else{
        fill(rectColor1);
      }
      rect(f*size,c*size,size,size); 
    }
  }
  if (pause == false){
    rules();
  }
}
//verifica la posción del mouse cuando se hace click
void mousePressed(){
  if (overGrid() && pause){
    int x = (mouseX*(gridX/size)/gridX);
    int y = (mouseY*(gridY/size)/gridY);
    if (lug[x][y] == 0){
      lug[x][y] = 1;
    }else{lug[x][y] = 0;
    }
  
  }
  //si overPause es verdadera cambia el estado de pause
  if(overPause()) {
    if (pause == true){
      pause=false;
    }else 
      pause=true;   
  }
  //si overRand y pause son verdaderas llama a la función que crea matrizes o "semillas" aleatorias
  if (overRand() && pause){
    iniAle();
  }
  //si nothing to see here y pause son verdaderas guarda la matriz actual como el archivo array.dat
  if (nTSH() && pause){
    int c = 0;
    for (int x=0; x<gridX/size; x++) {
      for (int y=0; y<gridY/size; y++) {
        save[c]= byte(lug[x][y]);
        c++;
        if (y == (gridY/size-1)){
          save[c] = 2;
          c++;
        }
        
      }
    }
    saveBytes("array.dat", save);
  }
  //si pause y gunLoad son verdaderas carga la "semilla" de pistola y naves.
  if (gunLoad() && pause){
    byte load[] = loadBytes("gun.dat");
    int pX = 0;
    int pY = 0;
    for (int a = 0; a<load.length;a++){
      if (load[a]!=2){
        lug[pX][pY]= int(load[a]);
        pY++;
      }else{
        pX++;
        pY=0;
      }
    }
  }
  //si pause y osciLoad son verdaderas carga la "semilla" de osciladores.
  if (osciLoad() && pause){
    byte load[] = loadBytes("osci.dat");
    int pX = 0;
    int pY = 0;
    for (int a = 0; a<load.length;a++){
      if (load[a]!=2){
        lug[pX][pY]= int(load[a]);
        pY++;
      }else{
        pX++;
        pY=0;
      }
    }
  }
  //si pause y matuLoad son verdaderas carga la "semilla" matusalenes.
  if (matuLoad() && pause){
    byte load[] = loadBytes("matu.dat");
    int pX = 0;
    int pY = 0;
    for (int a = 0; a<load.length;a++){
      if (load[a]!=2){
        lug[pX][pY]= int(load[a]);
        pY++;
      }else{
        pX++;
        pY=0;
      }
    }
  }
  //verifica la posición del mouse y si pause es verdadero para aumentar o disminuir los fps
  if (pause){
    int mX = mouseX;
    int mY = mouseY;
    if (mX<=(gridX+80) && (mX>=(gridX+50))&& mY<=(600) && (mY>=550)){
      fps--;
    }else if (mX<=(gridX+150) && (mX>=(gridX+120))&& mY<=(600) && (mY>=550)){
       fps++;
    }
    if (fps < 1){
      fps = 1;
    }else if( fps > 60){
       fps = 60;
    }
    frameRate(fps);
  }
}
//verifica la posición del mouse y para cada boton y devuelve 
//true o false de acuerdo a si esta o no el mouse sobre el boton respectivo
boolean matuLoad(){
  int mX = mouseX;
  int mY = mouseY;
  if (mX<=(gridX+150) && mX >=(gridX+50)&& mY<=(500) && (mY>=450)){
    return true;
  }else
    return false;
}

boolean osciLoad(){
  int mX = mouseX;
  int mY = mouseY;
  if (mX<=(gridX+150) && mX >=(gridX+50)&& mY<=(400) && (mY>=350)){
    return true;
  }else
    return false;

}

boolean overPause(){
  int mX = mouseX;
  int mY = mouseY;
  if (mX<=(gridX+150) && mX >=(gridX+50)&& mY<=(100) && (mY>=50)){
    return true;
  }else
    return false;

}
  
boolean overGrid(){
  int mX = mouseX;
  if (mX<(gridX)){
    return  true;
  }else 
  return false;
}

boolean overRand(){
  int mX = mouseX;
  int mY = mouseY;
  if (mX<=(gridX+150) && mX >=(gridX+50)&& mY<=(200) && (mY>=150)){
    return true;
  }else
    return false;
}

boolean gunLoad(){
  int mX = mouseX;
  int mY = mouseY;
  if (mX<=(gridX+150) && mX >=(gridX+50)&& mY<=(300) && (mY>=250)){
    return true;
  }else
    return false;
}

//nothing to see here 
boolean nTSH(){
  int mX = mouseX;
  int mY = mouseY;
  if (mX>(gridX+150) && mY<=(50)){
    return true;
  }else
    return false;
}
//generador de matrices aleatorias se puede varias el valor del if  para reducir o aumentar el numero de celdas vivas.
void iniAle(){
   for (int x=0; x<gridX/size; x++) {
    for (int y=0; y<gridY/size; y++) {
      float estado = random (100);
      if (estado > 16) { 
        estado = 0;
      }
      else {
        estado = 1;
      }
      lug[x][y] = int(estado); 
    }
  }  
}
//aplicación de las reglas del juego de la vida
void rules(){
  for (int x=0; x<gridX/size; x++) {
    for (int y=0; y<gridY/size; y++) {
      int vec =0;
      for (int x1=x-1; x1<=x+1;x1++) {
        for (int y1=y-1; y1<=y+1;y1++) {  
          if (((x1>=0)&&(x1<gridX/size))&&((y1>=0)&&(y1<gridY/size))) { 
            if (!((x1==x)&&(y1==y))) { 
              if (lug[x1][y1]==1){
                vec ++; 
              }
            } 
          } 
        } 
      } 
      if (lug[x][y]==1){
        if (vec>=2 && vec<=3){ 
          lugNue[x][y] = 1;
        }else lugNue[x][y]=0;
      }else if (lug[x][y] == 0 && vec==3){
        lugNue[x][y] = 1;
      }
      
    }
  }
  for (int d=0; d<800/size;d++){
    for (int b=0; b<800/size;b++){
      lug[d][b] = lugNue[d][b];
      lugNue[d][b]=0;
      
    }
  }
}
//dibujar los botones
void botones (){
  if (pause){
    fill(rectColor2);
    rect(gridX+50,50,100,50);
    fill(255);
    triangle(gridX+85,60,gridX+85,90,gridX+115,75);
  }else {
    fill(rectColor4);
    rect(gridX+50,50,100,50);
    fill(0);
    rect(gridX+85,65,10,20);
    rect(gridX+105,65,10,20);
  }
  fill(rectColor2);
  rect(gridX+50,150,100,50);
  fill(randColor());
  rect(gridX+90,160,5,5);
  rect(gridX+95,155,10,5);
  rect(gridX+105,160,5,10);
  rect(gridX+100,170,5,10);
  rect(gridX+100,185,5,5);
  
  fill(rectColor2);
  rect(gridX+50,250,100,50);
  fill(0);
  rect(gridX+65,275,5,15);
  rect(gridX+70,270,5,5);
  rect(gridX+70,290,5,5);
  rect(gridX+75,265,10,5);
  rect(gridX+75,295,10,5);
  rect(gridX+90,280,5,5);
  rect(gridX+95,270,5,5);
  rect(gridX+95,290,5,5);
  rect(gridX+100,275,5,15);
  rect(gridX+105,280,5,5);
  rect(gridX+115,265,10,15);
  rect(gridX+125,260,5,5);
  rect(gridX+125,280,5,5);
  rect(gridX+135,255,5,10);
  rect(gridX+135,280,5,10);
  
  fill(rectColor2);
  rect(gridX+50,350,100,50);
  fill(0);
  rect(gridX+85,370,5,15);
  rect(gridX+90,365,5,5);
  rect(gridX+90,385,5,5);
  rect(gridX+95,360,15,5);
  rect(gridX+95,390,15,5);
  
  
  fill(rectColor2);
  rect(gridX+50,450,100,50);
  fill(0);
  rect(gridX+85,465,5,25);
  rect(gridX+90,470,5,5);
  rect(gridX+95,475,5,5);
  rect(gridX+100,470,5,5);
  rect(gridX+105,465,5,25);
  
  
  fill(rectColor2);
  rect(gridX+50,550,30,50);
  fill(0);
  rect(gridX+55,570,20,10);
  
  
  fill(rectColor2);
  rect(gridX+120,550,30,50);
   fill(0);
  rect(gridX+125,570,20,10);
  rect(gridX+130,565,10,20);
  
  
}
//generador de colores aleatorios
color randColor(){
  float r = random (255);
  float g = random (255);
  float b = random (255);
  return color(r,g,b);

}
