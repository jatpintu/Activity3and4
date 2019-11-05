// This #include statement was automatically added by the Particle IDE.
#include <InternetButton.h>
InternetButton button = InternetButton();

void setup()
{
     button.begin();
     Particle.function("precipitation", showPrecipitation);
     Particle.function("temprature", showTemperature);
     Particle.function("hours", showHours);
     Particle.function("minutes", showMinutes);


}

void loop() {

}




int showPrecipitation(String cmd)
{
    float a = cmd.toFloat();

        if (a >= 0.00 && a <= 0.20)
        {
            button.allLedsOn(76, 5, 148);
            delay(2000);
            button.allLedsOff();
        }
        else if (a >= 0.21 && a <= 0.40)
        {
            button.allLedsOn(53, 126, 205);
            delay(2000);
            button.allLedsOff();
        }
        else if (a >= 0.41 && a <= 0.60)
        {
            button.allLedsOn(36, 196, 66);
            delay(2000);
            button.allLedsOff();
        }
        else if (a >= 0.61 && a <= 0.80)
        {
            button.allLedsOn(229, 227, 63);
            delay(2000);
            button.allLedsOff();
        }
        else if (a >= 0.81 && a <= 1.00)
        {
            button.allLedsOn(229, 124, 0);
            delay(2000);
            button.allLedsOff();
        }
        else
        {
            return -1;
        }
    return 1;
}






int showTemperature(String cmd)
{
    int a = cmd.toInt();

        if (a >= -30 && a <= -26)
        {
            button.allLedsOn(0, 17, 255);
            delay(2000);
            button.allLedsOff();
        }
        else if (a >= -25 && a <= -21)
        {
            button.allLedsOn(62, 69, 230);
            delay(2000);
            button.allLedsOff();
        }
        else if (a >= -20 && a <= -16)
        {
            button.allLedsOn(108, 113, 254);
            delay(2000);
            button.allLedsOff();
        }
        else if (a >= -15 && a <= -11)
        {
            button.allLedsOn(47, 127, 136);
            delay(2000);
            button.allLedsOff();
        }
        else if (a >= -10 && a <= -6)
        {
            button.allLedsOn(69, 207, 212);
            delay(2000);
            button.allLedsOff();
        }
         else if (a >= -5 && a <= 0)
        {
            button.allLedsOn(69, 252, 222);
            delay(2000);
            button.allLedsOff();
        }
         else if (a >= 1 && a <= 5)
        {
            button.allLedsOn(150, 255, 124);
            delay(2000);
            button.allLedsOff();
        } else if (a >= 6 && a <= 10)
        {
            button.allLedsOn(187, 254, 177);
            delay(2000);
            button.allLedsOff();
        } else if (a >= 11 && a <= 15)
        {
            button.allLedsOn(247, 254, 34);
            delay(2000);
            button.allLedsOff();
        } else if (a >= 16 && a <= 20)
        {
            button.allLedsOn(136, 129, 33);
            delay(2000);
            button.allLedsOff();
        } else if (a >= 21 && a <= 25)
        {
            button.allLedsOn(212, 195, 39);
            delay(2000);
            button.allLedsOff();
        } else if (a >= 26 && a <= 30)
        {
            button.allLedsOn(252, 138, 24);
            delay(2000);
            button.allLedsOff();
        }
        else
        {
            return -1;
        }
    return 1;
}




int showHours(String cmd)
{
    int a = cmd.toInt();
    button.ledOn(a, 255, 0, 0);
    delay(10000);
    button.allLedsOff();
    return 1;
}


int showMinutes(String cmd)
{
    int a = cmd.toInt();
    button.ledOn(a, 0, 255, 0);
    delay(10000);
    button.allLedsOff();
    return 1;
}




  
