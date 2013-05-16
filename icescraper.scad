// Global Parameters
// chrisjrob

use <MCAD/boxes.scad>;

// Globals
scoop_width     = 100;
scoop_height    =  30;
scoop_depth     =  32; // Must be greater than or equal to scoop_height
scoop_lip       =   1; // The thickness of the leading edge of the scoop
handle_length   =  75;
handle_diameter =  20;
roundedness = 5;

module icescraper() {

    difference() {

        // Things that exist
        union() {

            // cube
            translate(v = [0,0,scoop_height/2]) {
                // cube( size = [scoop_width, scoop_depth, scoop_height], center = true);
                roundedBox( [scoop_width, scoop_depth, scoop_height], roundedness, false );
            }

            // handle
            translate(v = [0, -handle_length/2 -scoop_depth/2 +roundedness, handle_diameter/2]) {
                roundedBox( [handle_diameter, handle_length + roundedness, handle_diameter], roundedness, false );
            }

        }

        // Things to be cut out
        union() {
            
            // Cutaway from cube to make scoop
            translate(v = [0,scoop_depth/2,scoop_height + scoop_lip]) {
                rotate(a = [0,90,0]) {
                    cylinder(h = scoop_width +10, r = scoop_height, center = true);
                }
            }


        }
    }

}

translate( v = [0, handle_length/2, 0] ) {
    icescraper();
}
