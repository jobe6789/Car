String incoming = "";
int maxIn = 19,
    lastBtTime = 0;
final int btTimeOut = 1000;

/*
String btName = "Linvor2",
       adr = "00:13:03:27:05:41";
*/


class BTManager{
  final int btStartupTime = 1000;
  
  KetaiBluetooth bt;
  String deviceName;

  BTManager(String name, KetaiBluetooth btt){
    deviceName = name;
    bt = btt;
    bt.start();
    while(!bt.isStarted()){
      //println("bt server starting up..");
    }
    // stupid call seems to be needed by Ketai???
    bt.getPairedDeviceNames();
  }
  
  void doBtConnect(){
    //println("Paired Devices:");
    //println(bt.getPairedDeviceNames());
    //println("Connected Devices:");
    //println(bt.getConnectedDeviceNames());
    
    if (bt.getConnectedDeviceNames().isEmpty()){
      //bt.connectToDeviceByName(name); 
      bt.connectDevice(bt.lookupAddressByName(deviceName));
      delay(btStartupTime);
    }
    //println("does it contain the name?" + isNamedDeviceConnected(deviceName));
    areWeConnected();
  }

  boolean areWeConnected(){
    return !bt.getConnectedDeviceNames().isEmpty();
  }

  boolean isNamedDeviceConnected(String nam){
    ArrayList<String> devices = bt.getConnectedDeviceNames(); 
    for (String device: devices){
      String aName = split(device, '(')[0];
      println("Device Name: " + aName);
      if(nam.equals(aName)){
        return true;
      }
    }
    return false;
  }

  String getBluetoothInformation(){
    String btInfo = "Server Running: ";
    btInfo += bt.isStarted() + "\n";
    btInfo += "Discovering: " + bt.isDiscovering() + "\n";
    btInfo += "Device Discoverable: "+bt.isDiscoverable() + "\n";
    btInfo += "\nConnected Devices: \n";
  
    ArrayList<String> devices = bt.getConnectedDeviceNames();  
    // this returns a list of String Toto(aa:bb:cc:dd:ee:ff)
    // to extract the name and adress alone:
    //
    for (String device: devices){
      String name = split(device, '(')[0];
      String adr  = split(split(device, '(')[1],')')[0];
      btInfo+= device + 
      "\n  name: " + name +
      "\n  address: " + adr + 
      "\n  address resulting from lookup of the name: " + bt.lookupAddressByName(name) + "\n";
    }
    return btInfo;
  }
  
  void send(String msg){
    bt.writeToDeviceName(deviceName,str2bytes(msg));
    //bt.write(adr, str2bytes(outgoing))
    //bt.broadcast(str2bytes(outgoing));
      //bt.writeToDeviceName(name, str2bytes(outgoing));
      //btm.send(bt.write(adr, str2bytes(outgoing));
  }
  
  byte[] str2bytes(String s){
    byte b[] = new byte[s.length()];
    for (int i=0;i<s.length();i++){
      b[i] = byte(s.charAt(i));
    }
    return b;
  }
}

//Call back method to manage data received
void onBluetoothDataEvent(String connectAddress, byte[] data){
  //println("Bt incoming from: " + connectAddress);
  /*if(incoming.length()> maxIn){
     incoming = "";
  }
  */
  int l = incoming.length(),
      now = millis();
  
  if((now-lastBtTime > btTimeOut)    ||  // been too long, start over!
     (l>0) && (incoming.charAt(l-1) == ')')){  // we finished a read
    incoming = "";
    lastBtTime = millis();
  }
  for (int i=0;i<data.length;i++){
    //println(incoming);
    int curLen = incoming.length();
    switch (curLen){
      case 2:
        incoming +=": (";
        break;
      case 0:
      case 6:
      case 9:
        incoming += " ";
        break;
    }      
    incoming += char(data[i]);
  }
  if(incoming.length()==15){
    incoming +=")";
  }
}