// Global Parameters
// chrisjrob

use <MCAD/boxes.scad>;

// Globals
scoop_width     = 100;
scoop_length    =  50; // Must be greater than or equal to scoop_height
scoop_lip       =   1; // The thickness of the leading edge of the scoop
handle_length   = 100; // A comfortable length for a hand
handle_diameter =  25;
roundedness     =   5;
scoop_height    =  handle_diameter * 1.5; // Should not need changing

module icescraper() {

    difference() {

        // Things that exist
        union() {

            // cube
            translate(v = [0,0,scoop_height/2]) {
                // cube( size = [scoop_width, scoop_length, scoop_height], center = true);
                roundedBox( [scoop_width, scoop_length, scoop_height], roundedness, true );
            }

            // lip that isn't rounded
            translate(v = [0,scoop_length/4,scoop_height/8]) {
                cube( size = [scoop_width, scoop_length/2, scoop_height /4], center = true);
            }

            // handle
            translate(v = [0, -handle_length/2 -scoop_length/2 +roundedness, handle_diameter/2]) {
                roundedBox( [handle_diameter, handle_length + roundedness, handle_diameter], roundedness, false );
            }

        }

        // Things to be cut out
        union() {
            
            // Cutaway from cube to make scoop
            translate(v = [0,scoop_length/2,scoop_length + scoop_lip]) {
                rotate(a = [0,90,0]) {
                    cylinder(h = scoop_width +10, r = scoop_length, center = true);
                }
            }


        }
    }

}

translate( v = [0, handle_length/2, 0] ) {
    icescraper();
}
