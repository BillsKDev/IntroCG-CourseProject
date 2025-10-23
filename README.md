<h2>Graphics Project Progression</h2>

<h2>Explanations</h2>

<h3>Base Game</h3>
This game is a third person puzzle-combat game that is built off from teams GDW game Scrap from Cracked Eggs last year, however I did remove alot of the polish since it was not needed for the prototype. 
In this prototype, the player has to use their magnetic arms to solve a puzzle and then come face to face with an enemy and must defeat it to win the game. The losing condition is if the player is defeated by the enemy.
Since the professor allowed me to use my previous GDW game, I am only using scripts/models from our game without any polish to get an idea of what our game was like, but will create custom shaders and effects for this assignment.<br>

<h4>NOTE ON EXTERNAL SOURCES</h4>


Since this game was made by my team, the models/textures are made by my previous teammates, and since I do not have GDW this year the professor told me I could use my previous GDW game to build this project off of.
The code however, was written by myself and one other team member so i acknowledge that there was another team member working on these systems with me. The **SCRAP** repository can be seen here with all the code changes I made: https://github.com/Cracked-Eggs/ScrapY4
To explain the code from here, We worked on a state machine system over the course of the last year that is used for both the player & enemy and is integrated smoothly with the combat system with every action having a different state. There are also simple scripts for
a door and pressure plate to work with the magnetism mechanic for **SCRAP** where players can use their robot parts to progress through the game. I also acknowledge over the course of last year we probably used AI to help with bug fixing. 

**Screenshot of base game**
<img width="992" height="562" alt="image" src="https://github.com/user-attachments/assets/1a2075f4-e5fc-4205-9883-2ae4aaa55677" />

<h3>Illumination</h3>

<h3>Color Grading</h3>

Color Grading was done to have a warm, cool, and death LUT that is projected onto a second camera with a render texture. It uses the shader to make materials that applies the LUT's and render textures to create a grading effect on an image UI that is overlayed on the second camera. The shader takes the original colors as inputs and uses paramaters like the LUT's brightness/contrast/hue to modify the color and remap new ouput colors and applying the adjustments. I made it so you can toggle between the different materials with 5/6/7/8 by just changing the the material that is on the image with different materials that use the different LUT's.

**EXAMPLE IMAGES**
<img width="991" height="557" alt="image" src="https://github.com/user-attachments/assets/bdefc934-2f2f-4542-979f-e7d1dcd6cdd9" />
<img width="989" height="546" alt="image" src="https://github.com/user-attachments/assets/f5f79258-eb5f-4763-ad1f-42df3f711525" />


<h3>Shaders</h3>


