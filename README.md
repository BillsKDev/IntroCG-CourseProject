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
a door and pressure plate to work with the magnetism mechanic for **SCRAP** where players can use their robot parts to progress through the game. I also used an online image for a water texture for my scrolling UV shader https://www.pinterest.com/pin/1407443628881858/ I used a night skybox from the asset store https://assetstore.unity.com/packages/2d/textures-materials/sky/allsky-free-10-sky-skybox-set-146014

**Screenshot of base game**
<img width="992" height="562" alt="image" src="https://github.com/user-attachments/assets/1a2075f4-e5fc-4205-9883-2ae4aaa55677" />

<h3>Illumination</h3>
<h4>Implemented Diffuse, Diffuse/Ambient, Specular, Specular/Ambient, No lighting</h4>
I used one shader to calculate the different lighting calculations and have a float for the lighting mode that the player can toggle betwween the 1/2/3/4/0 keys. I used the lecture code as a reference so its very similar to them, but I had to adjust things slightly so I could toggle between the different models. The shader just has a texture, and color/shininess for the specular stuff and calculates the nomral, view direction and light then uses them to do the different calculations for every lighting model. For example Ambient uses spherical harmonics, and specular takes the dot product of the reflected direction and view direction changed by a shininess. Finally I have a lighting manager script that just takes the user input and sets float for the material to the correct lighting model. All of this was applied to the walls in the second room to easily see the difference between models.

<h4>EXAMPLE IMAAGES</h4>
<img width="779" height="465" alt="image" src="https://github.com/user-attachments/assets/f765d769-ee34-477e-a865-ea5bef0add5f" />
<img width="714" height="440" alt="image" src="https://github.com/user-attachments/assets/292dddfa-5809-4f43-8b0b-dbdfa632d20c" />


<h3>Color Grading</h3>

Color Grading was done to have a warm, cool, and death LUT that is projected onto a second camera with a render texture. It uses the shader to make materials that applies the LUT's and render textures to create a grading effect on an image UI that is overlayed on the second camera. The shader takes the original colors as inputs and uses paramaters like the LUT's brightness/contrast/hue to modify the color and remap new ouput colors and applying the adjustments. I made it so you can toggle between the different materials with 5/6/7/8 by just changing the the material that is on the image with different materials that use the different LUT's.

**EXAMPLE IMAGES**
<img width="991" height="557" alt="image" src="https://github.com/user-attachments/assets/bdefc934-2f2f-4542-979f-e7d1dcd6cdd9" />
<img width="989" height="546" alt="image" src="https://github.com/user-attachments/assets/f5f79258-eb5f-4763-ad1f-42df3f711525" />


<h3>Shaders</h3>

<h4>Rim Lighting</h4>
Rim Lighting was used on the walls and floor for the first room to give it a unique look. It's modified from what I learned fron the lectures with a few changes such as adding texture support and removing the base color property, enhancing the rim control with an intensity property so that I can adjust the rim effect to be brighter, changing the rim lighting calculation so that rather than the rim lighting appearing on the edges of an obeject the rim appears from the center and on surfaces facing the camera, and finally adjusting how the properties are blended together as mine multiplies the texture and intensity with the color and lighting to scale the final effect.

<h4>EXAMPLE IMAGE</h4>
<img width="992" height="556" alt="image" src="https://github.com/user-attachments/assets/dcc973df-4872-44ee-bf42-0886a1616a0a" />


<h4>Scrolling UVs</h4>
I created a custom scrolling UV shader to simulate water in my environment flowing. It moves the given texture over time by changing the x and y UV coordinates. At first I was having trouble with how time works with shaders, but with a quick google search I found a Unity documentation answer that shaders have their own custom time variable just like Time.DeltaTime https://discussions.unity.com/t/how-does-time-work-in-shaders/888675. With this knowledge I was able to change the textures UV for the x and y with a custom scroll speed property and the shader time. For the water texture I used an online image as mentioned in the external sources https://www.pinterest.com/pin/1407443628881858/

<h4>EXAMPLE IMAGE</h4>
<img src="https://github.com/BillsKDev/IntroCG-CourseProject/blob/main/Gifs/water.gif" width="992" height="546">





