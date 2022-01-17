#include <esp_task_wdt.h>

/*This goes to check our web server for a current light setting.
 * Changes it on the target device if changed. If it hasn't changed
 * then it checks the current CheerLights color. Goes back
 * and forth until one changes and then the color on the device
 * gets changed.
 * Lather, rinse, repeat.
 * 
 * I started this on an Adafruit Feather Huzzah using this tutorial as a guide:
 * https://learn.adafruit.com/cheerlights. Then I moved it to an ESP32 Feather
 * and decided to put some code together to control the lights on my tree
 * directly, but fall back on CheerLights. 
 * Then I moved it to a QT Py ESP32-S2. 
 */
#include<ArduinoJson.h>
#include <HTTPClient.h>
#include <WiFi.h>
#include <Adafruit_NeoPixel.h>

//For Feather with NeoPixel Jewel
//#define PixelPin 14
//#define PixelNum 7

//for QTPY with on-board NeoPixel
#define PixelPin A0
#define PixelNum 7

#define WDT_TIMEOUT 30

Adafruit_NeoPixel pixels = Adafruit_NeoPixel(PixelNum, PixelPin, NEO_GRBW + NEO_KHZ800);
WiFiClient client;
HTTPClient http;

const char* ssid = "Your SSID";
const char* password = "Your password";
char strColor [100];
unsigned long prevHouse; 
unsigned long currHouse;
unsigned long prevCL;
unsigned long currCL;

int makeRGBW(unsigned long color);

void setup() {
 esp_task_wdt_init(WDT_TIMEOUT, true); //enable panic so ESP32 restarts
  esp_task_wdt_add(NULL); //add current thread to WDT watch
Serial.begin(); //Don't specify a baud rate on the QT Py
  delay(10);
  Serial.println();
    
  Serial.print("Connecting to ");
  Serial.println(ssid);

  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println("");
  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());   //You can get IP address assigned to ESP

    // Neopixel power for QT PY code - comment out for Feather
  pinMode(NEOPIXEL_POWER, OUTPUT);
  digitalWrite(NEOPIXEL_POWER, HIGH); // on
}
void loop()
{
    getHouse();
}

void getHouse()
{
  
  //Serial.println(House Lights!"); 
  delay(500); // Wait half a second to settle.
 // Send request
http.begin(client, "http://www.Your web site/Lights.txt"); //Or whatever other feed you want to pull from.
http.GET();

// Print the response

//Serial.print(http.getString());
int status = http.GET();
Serial.print("Did GET, status=");
Serial.println(http.errorToString(status));
//Serial.println ("Status done");
if (status>0)
{
  String payload = http.getString();
//  Serial.println ("Payload:");
//Serial.println(payload);
//Serial.println ("Payload done");

// Parse response
DynamicJsonDocument doc(2048);
DeserializationError err = deserializeJson(doc,payload);
//deserializeJson(doc, http.getString());
Serial.print("JSON stat: ");

Serial.println(err.c_str());

pixels.begin();
pixels.setBrightness(20); // not so bright

String sColor = doc["Setting"];
Serial.println("String");
Serial.println(sColor); //Debugging
if (sColor !="null")
{

  strncpy(strColor, sColor.c_str(), sizeof(strColor));
    setColor(strColor);
  }
else
{
  strncpy(strColor, sColor.c_str(), sizeof(strColor));

}
  
// Read values

Serial.println(doc["Setting"].as<long>());

}

// Disconnect
http.end();
//delay(5000); //Wait five seconds. I don't think we need this.
}

void setColor(char* colorName)
{
 /*      int rVal, gVal, bVal;
                sscanf(colorName, "%d,%d,%d", &rVal, &gVal, &bVal);     
                */
      unsigned long color=0;
      sscanf(colorName+1, "%X", &color); //strips the # off of the color name and adds 0x
Serial.println("Converted House color");
Serial.println(color);
currHouse=(color);
//Serial.println("current");
//Serial.println(currHouse); // This is the one we just retrieved

if (prevHouse != currHouse) // If they don't match, then do the next thing.
{
 Serial.println("colorName: ");
  Serial.println(strColor); // Yep, just wanted to check it worked 

  color = makeRGBW(color);

//Serial.println("current2");
//Serial.println(currHouse); //Hey, I'm paranoid. But now comes the fun part. We get to send the color!
       for(int i=0;i<PixelNum;i++){
         pixels.setPixelColor(i, color); 
      }
      pixels.show(); // This sends the updated pixel color to the hardware.
 //delay (30000);  //Wait 30 seconds or so in case someone wants to set the new color     
 prevHouse=currHouse; // Make the current color the previous color for next time
 //Serial.println("previous2");
 //Serial.println(prevHouse);   //  Just to make sure
 return;
}

  else {
    //Serial.println("goto CheerLights!"); // If the current and previous colors matched, then we check the CheerLights
   
  delay(5000);
getCL();
  }}

void getCL()
{
  //delay(1000);
 //  Serial.println("it's CheerLights!"); //This is just like the previous bit, except we check the CheerLights feed
  // Send request
http.begin(client, "http://api.thingspeak.com/channels/1417/field/2/last.json");
http.GET();

// Print the response

//Serial.print(http.getString());
int status = http.GET();
//Serial.print("Did GET, status=");
//Serial.println(http.errorToString(status));
//Serial.println ("Status done");
if (status>0)
{
  String payload = http.getString();
  Serial.println ("Payload:");

// Parse response
DynamicJsonDocument doc(2048);
DeserializationError err = deserializeJson(doc,payload);
//deserializeJson(doc, http.getString());
Serial.print("JSON stat: ");

Serial.println(err.c_str());

pixels.begin();

String sColor = doc["field2"];
Serial.println("String");
Serial.println(sColor);
if (sColor !="null")
{
//Serial.println("sending CL color");
  strncpy(strColor, sColor.c_str(), sizeof(strColor));
    setCLcolor(strColor);
  
}
else
{
  strncpy(strColor, sColor.c_str(), sizeof(strColor));

}
  
// Read values
//Serial.println("field2");
//Serial.println(doc["field2"].as<long>()); // Debugging to make sure I got the correct value

}


// Disconnect
http.end();

}
 //Set the Neopixel to the CheerLights color 
void setCLcolor(char* colorName)
{

      unsigned long color=0;
      sscanf(colorName+1, "%X", &color);
Serial.println("Converted CL color");
Serial.println(color);
currCL=color;
//Serial.println("currCL");
//Serial.println(currCL);
if (prevCL != currCL)
{
 //Serial.println("colorName: ");
 // Serial.println(strColor);
//Serial.println("current2");
//Serial.println(currCL);

  color=makeRGBW(color);
       for(int i=0;i<PixelNum;i++){
         //pixels.setPixelColor(i, rVal, gVal, bVal, 20); //20 is just a bit of white
         pixels.setPixelColor(i, color); 
      }
      pixels.show(); // This sends the updated pixel color to the hardware.
   
prevCL=currCL; 
//Serial.println("previous2");
//Serial.println(prevCL);     
return; 
}


  else {
   
  Serial.println("Configuring WDT...");
  esp_task_wdt_init(WDT_TIMEOUT, true); //enable panic so ESP32 restarts
  esp_task_wdt_add(NULL); //add current thread to WDT watch
    Serial.println("go to House");
   delay(500);
getHouse();
  }



}
// Given a color long containing RGB in the low 3 bytes, generate a W value for the upper byte
// Thank you to Paul Barrett for this bit of code.
int makeRGBW(unsigned long color)
{
  int B = color & 0xFF;
  int G = (color >> 8) & 0xFF;
  int R = (color >> 16) & 0xFF;
  int W = (R + G + B) / 3;  // avg of the three
  if ((R > 220) && (G > 220) && (B > 220))
    W = 255;
  else
    W = W * 0.0; // Cut it back a bit
  int RGBW = (W << 24) | (color & 0x00FFFFFF);
  return RGBW;
}
