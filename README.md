# CPSC334-Final_Project
Jovenetskah - A performable doll to trigger video installation

**Jovenitskah**
The goal of this project was to create an uncannily human simulacrum which could be used mobily in a performance to trigger
video projections. The doll once constructed received the name Jovenetskah. The performance became a meditation on the entrapment
of memory and trauma in the body, and on relationships with elder family members.

**Materials**
One ESP32 Dev Module
One Mac Mini
One Video Projector
One 8" x 12" x 1.5" block of particle board
Two googly eyes
One sheet of 1/4" thick wood
An old pair of pants
An old sweater
A pad of drawing paper
Paints
Lots of 200 kOhm resistors
Three 150 mOhm resistors
Jumper wires and solder
One orange LED
Hot Glue
One Bread Board
Screws and Nails
Two Hinges
Wood-working tools
Needle and thread
Toothpicks
A bit of cardboard
A 3 AA Battery pack with an On/Off switch

**Constructing the Doll**
The most important part of the doll is its face. It allows the final construction to carry emotional weight within the scheme
of the performance. To make a good face, a certain degree of material mastery is required. For Jovenetskah, I carved her face out of
the particle board with a Dremel tool. I emphasized certain areas with a wood-burning tool, and then colored it with watercolors. In
each eye I stuck a plastic googly eye for extra creepiness.

The body of the doll is a little 6"x6"x7" house made from the sheet of 1/4" wood. In the front side, I cut a four-panel window about
1.5" high using a jigsaw. This side I affixed to the rest of the house on a hinge, allowing it to open out and for the inside of the
house to always be accessible. On each of the sides, the top and the bottom faces, I drilled a 1/4" hole. This is where the wires will
come out from. Once built, I painted the house with watercolors.

The arms of the doll are made from an old pair of pants, tied up at the bottom of each leg, stuffed with crumpled drawing paper.
The legs are tubes made from an old white sweater, similarly stuffed.
On the end of each arm, I twisted a ball of stuffing into a bulbous hand and tied it at the wrist. These hands I painted over with
acrylic paints.

With the body put together, I added final touches using mostly acrylic paints to make the whole thing look dirty and weathered.

**Hardware**
The key to Jovenetskah's functionality is a set of resistor-chain tracks affixed to both arms and to her head.
To make a track, I soldered around 25 200kOhm resistors together in series, creating a long wire of straight resistors. I then cut an
equal length of solid electrical wire and stripped it entirely. To the end of each, I soldered a length of lead wire, which would be the
part extending into the house-body of the doll and the ESP. Branching out near the end of the lead attached to the resistor chain, I
soldered one 150 mOhm resistor for a pull-down resistor. Then I layed the resistor chain and stripped wire side by side and hot glued
snapped bits of toothpick across them like the bars of a train track. This was to keep them together and assure they stayed spaced
apart.

I put one track through each side of Jovenitskah's house-body, pulled them around the arms, and stitched the toothpicks into the cloth 
to keep them attached. I put the last track through the top of the house-body and pulled it around the head, hot-gluing it in place.

On the inside of the house, I stuck a bread board down to simplify the wiring, and I made a little nest for the ESP32 using straps of 
canvas and sewing snaps for easy removeability. I also left a little microUSB connected to it poking out of the side of the box through 
a hole I drilled, for quick reflashing if necessary.

I grounded the pull-down resistors of each sensor track, and attached the leads they branched from into the ESP's GPIO. The leads 
connected to the stripped wires I gave 3V through the breadboard from the ESP.

Under the window in the openable front wall, I made a little triangular prism of cardboard, punched holes in its top and back sides, and
hot-glued it to the back of the wall. Then I installed the orange LED with small 20 Ohm resistor and its leads going through those holes, running back to the ESP.

Lastly, I affixed the battery pack to the bottom of the doll with snaps and wide straps, in the same manner as the ESP, and I ran its wires through the hole in the bottom of the house to power the ESP.

Elsewhere, in a manner dependent on the specifics of the installation, the Mac Mini must be plugged in and powered on and its display routed over HDMI to a video projector.

**The Code**
The ESP runs an Arduino script that reads voltages off the resistor chains when something connects across them and th parallel running wire. Depending on where that connection happens along the resistor chain, it reads a different voltage. The ESP hosts a local Wifi network and sends out its readings as UDP messages.

The Mac Mini connects to the ESP's wifi and runs a Processing script that listens for its UDP messages. It parses them, and depending on the value and which limb the reading came from, it jumps around to different clips in a single long video montage prepared ahead of time. The video I used is a compilation of my general personal archive and footage I recorded working on a geneology project last summer. Each time the video skip is triggered, only seven seconds are played before the display fades back to blank.
