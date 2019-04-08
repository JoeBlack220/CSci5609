import java.util.*;

public class Species {
  private String name;
  private String type;
  private ArrayList<Float> relations = new ArrayList<Float>();
  private PShape shape;
  private float diameter;
  private float xCor;
  private float yCor;
  private float xNum;
  private float yNum;
  private int index;
  private final int speciesNum = 127;
  private final float interval = (float)360/128;

  public Species(TableRow speciesRow, float bigCircleDia, int idx){
  index = idx;
  for(int i = 0; i < speciesRow.getColumnCount(); i++){
      if(i==0) type = speciesRow.getString(i);
      else if(i==1) name = speciesRow.getString(i);
      else relations.add(speciesRow.getFloat(i));
    }
    diameter = (float)(bigCircleDia * Math.PI / speciesNum);
    xCor = (float)(725+Math.cos(Math.toRadians(index*interval))*bigCircleDia/2);
    yCor = (float)(475+Math.sin(Math.toRadians(index*interval))*bigCircleDia/2);
    xNum = (float)(725+Math.cos(Math.toRadians(index*interval))*(bigCircleDia/2+10));
    yNum = (float)(475+Math.sin(Math.toRadians(index*interval))*(bigCircleDia/2+10));
    drawShape();
  }
  
  private void drawShape(){
    // ELLIPSE x, y, width, height
    shape = createShape(ELLIPSE, xCor,yCor ,diameter ,diameter);
    // If type is Basal, set the color to royal blue.
    if (type.equals("Basal")) shape.setFill(color(102,194,165));
    // If type is Freeliving, set the color to Spring Green1.
    else if (type.equals("Freeliving")) shape.setFill(color(252,141,98));
    // If type is Basal, set the color to Orange Red.
    else if (type.equals("Parasite")) shape.setFill(color(141,160,203));
    shape.setStroke(false);
  }
  
  public String getName(){
    return name;
  }
  
  public String getType(){
    return type;
  }
  
  public ArrayList<Float> getRelations(){
    return relations;
  }
  public float getDia(){
    return diameter;
  }
  
  public PShape getShape(){
    return shape;
  }
  
  public float getXCor(){
    return xCor;
  }
  public float getYCor(){
    return yCor;
  }
  public float getXNum(){
    return xNum;
  }
  public float getYNum(){
    return yNum;
  }
  public float getIdx(){
    return index;
  }
}
  
