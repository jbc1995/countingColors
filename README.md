# Counting Colors

For Marcelo Coelho's Design Interactions course at MIT, we were tasked with creating a game and a controller to play it with. We were restricted to using a 1D array of pixels for our game, and our controller could only use push-buttons, joysticks, or rotary encoders.

I designed a 2-player competitive/cooperative memory game where the players must memorize the number of each color of pixel in a random array. They will then be prompted with one of the colors of the array, and must input their guess using the knobs on the controller. There are multiple rounds at different difficulty levels (which bring in more colors and more total pixels to memorize), and the player who guesses the most rounds correctly wins.

This game was created using state machines and class structures in Processing, then was integrated with a bit of Arduino code to interact with the actual controller.

The "project1.pde" file is the main script, with the rest of the code supporting it. The Arduino code is found in the "A_Controller" folder.

The physical controller was constructed by printing the main box portion and the two knobs using a FormLabs SLA 3D printer and the bottom lid with a Prusa FDM 3D printer, soldering the Arduino Nano, two rotary encoders, and subsequent wires, then assembling the box together using some hot glue and screwing the lid to the base using heat insert screws.

See the "3D Printed Parts" folder for the models of the enclosure, knob, and lid designs.

For more info on the project, check out the class website (http://designinteractions.mit.edu/) or the project page on my personal portfolio website (https://justinbchristensen.com/projects/counting_colors.html).

Thank you!
