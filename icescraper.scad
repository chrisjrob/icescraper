// icescraper.scad
// Ice Scraper
// 
// Copyright (C) 2013 Christopher Roberts
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.


// Global Parameters

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
            translate(v = [0,scoop_length/2-scoop_lip,scoop_length + scoop_lip]) {
                rotate(a = [0,90,0]) {
                    cylinder(h = scoop_width +10, r = scoop_length, center = true);
                }
            }

            // Grooves from top of scoop
            for(x = [-scoop_width/2 : (scoop_width/10) : scoop_width/2]) {
                translate(v = [x,-scoop_length/2,scoop_height*1.05]) {
                    rotate(a = [0,45,0]) {
                        cube( size = [scoop_width/10, scoop_width/10, scoop_width/10], center = true);
                    }
                }
            }

        }
    }

}

translate( v = [0, handle_length/2, 0] ) {
    icescraper();
}
