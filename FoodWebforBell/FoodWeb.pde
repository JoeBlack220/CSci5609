import java.util.*;
import java.lang.*;

// --------------------- Sketch-wide variables ----------------------
Table table;
String[] allSpeciesName = new String[13];
int speciesNum;
ArrayList<Species> allSpecies = new ArrayList<Species>();
float bigCircleDia = 600;
float interval;
PShape bigCircle;
// ------------------------ Initialisation --------------------------

// Initialises the data and bar chart.

// ------------------------ Initialisation --------------------------

// Initialises the data and bar chart.


void setup(){
  size(1280, 720);
  smooth(); 
  // ELLIPSE x, y, width, height
  bigCircle = createShape(ELLIPSE,640,360,bigCircleDia,bigCircleDia);  
  // Load the data table.
  table = loadTable("carpinteria.csv");
  // The first row of the table saves all the name of species in the food web.
  // Extract them all and save them in a String array.
  TableRow row0 = table.getRow(0);
  for (int i = 2;i < row0.getColumnCount();i++){
    allSpeciesName[i-2] = row0.getString(i);
  }
  // The first two columns are not species name
  // Initialize save all species information into an arraylist
  for (int i = 3; i < table.getRowCount(); i++){
    allSpecies.add(new Species(table.getRow(i), bigCircleDia, i-3));
    } 
  speciesNum = allSpecies.size();
  
}

void draw()
{
 background(255); 
 shape(bigCircle,0,0);
 for(int i = 0; i < speciesNum; i++){
   shape(allSpecies.get(i).getShape(),0,0);
 }
 for(int i = 0; i < speciesNum; i ++){
   for(int j = 0; j < speciesNum; j++){
     float ijRelation = allSpecies.get(i).getRelations().get(j);
     // draw links if two speceis have relations
     if(ijRelation!=0) {
       if(ijRelation==1) {
         stroke(204,235,197);
         line(allSpecies.get(i).getXCor(), allSpecies.get(i).getYCor(), allSpecies.get(j).getXCor(), allSpecies.get(j).getYCor());
       }
       if(ijRelation==2) {
         stroke(179,205,227);
         line(allSpecies.get(i).getXCor(), allSpecies.get(i).getYCor(), allSpecies.get(j).getXCor(), allSpecies.get(j).getYCor());
       }
       if(ijRelation==3) {
         stroke(251,180,174);
         line(allSpecies.get(i).getXCor(), allSpecies.get(i).getYCor(), allSpecies.get(j).getXCor(), allSpecies.get(j).getYCor());
       }
     }
   }
 }
}
