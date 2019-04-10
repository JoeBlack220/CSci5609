import java.util.*;

public class Species {
  private String name;
  private ArrayList<Float> relations = new ArrayList<Float>();
  private PShape shape;
  //private float diameter;
  private float xCor;
  private float yCor;
  private float zCor;
  private float index;
  private int level;
  private int no;
  //private final int speciesNum = 127;
  private final float interval = 10;

  public Species(TableRow speciesRow, float bigCircleDia, int idx){
  no = idx;
  for(int i = 0; i < speciesRow.getColumnCount(); i++){
      if(i==0) level = speciesRow.getInt(i);
      if(i==1) index = speciesRow.getFloat(i);
      else if(i==2) name = speciesRow.getString(i);
      else relations.add(speciesRow.getFloat(i));
    }
    //diameter = (float)(bigCircleDia * Math.PI / speciesNum);
    //xCor = (float)(Math.cos(Math.toRadians(index))*(1000-100*level));
    //yCor = (float)(Math.sin(Math.toRadians(index))*(1000-100*level));
    xCor = (float)(Math.cos(Math.toRadians(index))*500);
    yCor = (float)(Math.sin(Math.toRadians(index))*500);
    zCor = (float)(level*100);
    //drawShape();
  }
  
  private void drawShape(){
    // ELLIPSE x, y, width, height
    shape = createShape(SPHERE, 15);
    if (level==1) shape.setFill(color(179,222,105));
    else if (level==2) shape.setFill(color(253,180,98));
    else if (level==3) shape.setFill(color(128,177,211));
    else if (level==4) shape.setFill(color(251,128,114));
    else if (level==5) shape.setFill(color(190,186,218));
    else if (level==6) shape.setFill(color(255,255,179));
    else if (level==7) shape.setFill(color(141,211,199));
    shape.setStroke(false);
  }
  
  public String getName(){
    return name;
  }
  
  public int getLevel(){
    return level;
  }
  
  public float getIndex(){
    return index;
  }
  
  public float getXCor(){
    return xCor;
  }
  
  public float getYCor(){
    return yCor;
  }
  
  public float getZCor(){
    return zCor;
  }
  
  public ArrayList<Float> getRelations(){
    return relations;
  }
  
  public PShape getShape(){
    return shape;
  }
}
  
