void midiMessage(MidiMessage message) { // You can also use midiMessage(MidiMessage message, long timestamp, String bus_name)
  println();
  println("MidiMessage Data:");
  println("--------");
  println("Status Byte/MIDI Command:"+message.getStatus());
  for (int i = 1;i < message.getMessage().length;i++) {
    println("Param "+(i+1)+": "+(int)(message.getMessage()[i] & 0xFF));

  }
  
  println("Menge: "+midi[1]+", Speed: "+midi[2]+", Stroke: "+midi[3]+", Fill:   "+midi[4]);
  println("Min:   "+midi[5]+", Max:   "+midi[6]+", onLine: "+midi[7]+", Radius: "+midi[8]);
  println("moveSize: "+midi[0]+", moveSpeed: "+midi[10]);
  
   if (((int)message.getMessage()[1] == 16)&&(message.getStatus() == 176)){
      midi[1] = +(int)(message.getMessage()[2] & 0xFF);
   }
   if (((int)message.getMessage()[1] == 17)&&(message.getStatus() == 176)){
      midi[2] = +(int)(message.getMessage()[2] & 0xFF);
   }
   if (((int)message.getMessage()[1] == 18)&&(message.getStatus() == 176)){
      midi[3] = +(int)(message.getMessage()[2] & 0xFF);
   }   
   if (((int)message.getMessage()[1] == 19)&&(message.getStatus() == 176)){
      midi[4] = +(int)(message.getMessage()[2] & 0xFF);
   }  
   if (((int)message.getMessage()[1] == 20)&&(message.getStatus() == 176)){
      midi[5] = +(int)(message.getMessage()[2] & 0xFF);
   }
   if (((int)message.getMessage()[1] == 21)&&(message.getStatus() == 176)){
      midi[6] = +(int)(message.getMessage()[2] & 0xFF);
   }   
   if (((int)message.getMessage()[1] == 22)&&(message.getStatus() == 176)){
      midi[7] = +(int)(message.getMessage()[2] & 0xFF);
   }   
   if (((int)message.getMessage()[1] == 23)&&(message.getStatus() == 176)){
      midi[8] = +(int)(message.getMessage()[2] & 0xFF);
   }   
   if (((int)message.getMessage()[1] == 24)&&(message.getStatus() == 176)){
      midi[9] = +(int)(message.getMessage()[2] & 0xFF);
   } 
   if (((int)message.getMessage()[1] == 15)&&(message.getStatus() == 176)){
      midi[10] = +(int)(message.getMessage()[2] & 0xFF);
   } 
   if (((int)message.getMessage()[1] == 25)&&(message.getStatus() == 176)){
      midi[11] = +(int)(message.getMessage()[2] & 0xFF);
   } 
   
   
   
   if (((int)message.getMessage()[1] == 14)&&(message.getStatus() == 176)){
      midi[0] = +(int)(message.getMessage()[2] & 0xFF);
   }   
   
   
}