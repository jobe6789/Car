class Defaults{
  // main windows defaults:
  static final int windowWidth  = 1500,
                   windowHeight = 800;
  
  static final float mm2pix = 0.50;
   
  // for the long tail:
  static final int tailLength = 1000;
  
  static final float  wheelWidth = 10 * mm2pix,
                      wheelHeight = 20  * mm2pix,
                      carWidth  = 100  * mm2pix,
                      carHieght =  160  * mm2pix,
                      axelWidth = carWidth -  wheelWidth;
  
  static final float  trackWhiteWidth =  20 * mm2pix,
                      trackBlackWidth =  240 * mm2pix;
                      
  static final float  trackStraightLength =  560 * mm2pix,
                      trackOuterDiameter  =  1400 * mm2pix;
                      
                    
  
  
  static final color  red   = #FF0000,
                      green = #00FF00,
                      blue  = #0000FF,
                      grey  = #A7A7A7,
                      black = #000000,
                      white = #FFFFFF,
                      targetColor = red,
                      wheelColor = blue;
            
  Defaults(){};
}