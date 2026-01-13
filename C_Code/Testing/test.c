/*
 * blink.c:
 *	Standard "blink" program in wiringPi. Blinks an LED connected
 *	to the first GPIO pin.
 *
 * Copyright (c) 2012-2013 Gordon Henderson.
 ***********************************************************************
 * This file is part of wiringPi:
 *      https://github.com/WiringPi/WiringPi
 *
 *    wiringPi is free software: you can redistribute it and/or modify
 *    it under the terms of the GNU Lesser General Public License as published by
 *    the Free Software Foundation, either version 3 of the License, or
 *    (at your option) any later version.
 *
 *    wiringPi is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU Lesser General Public License for more details.
 *
 *    You should have received a copy of the GNU Lesser General Public License
 *    along with wiringPi.  If not, see <http://www.gnu.org/licenses/>.
 ***********************************************************************
 */

#include <stdio.h>
#include <wiringPi.h>
#include <stdint.h>
// LED Pin - wiringPi pin 0 is BCM_GPIO 17.sf

#define	LED	7

int main (void)
{
  printf ("Raspberry Pi blink\n") ;

  // Using physical pin numbering
  wiringPiSetupPinType(WPI_PIN_PHYS);
  pinMode (LED, OUTPUT) ;
  uint32_t last_blink = 0;
  while(1)
  {
    uint32_t time = millis();
    //printf("Time is %d\n", time);
    if ((time-last_blink)>=1000){
        printf("Current time is %d\n", time);
        uint8_t current_status = digitalRead(LED);
        printf("Current status is %d the inverse is %d\n" , current_status, !current_status);
        digitalWrite(LED, !current_status);	// On
        last_blink = time;
   }
  }
  digitalWrite(LED, 0);
  return 0 ;
}

// heyyyyy
//git hub
