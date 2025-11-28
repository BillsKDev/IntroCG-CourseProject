<h2>Graphics Course Project</h2>
<h4><a href="#graphics-project-progression">FOR ASSIGNMENT 1 DELIVERABLES VIEW HERE</a></h4>
To reach grading requirements, I have A1 deliverable info above and still in the project, a release build and a readme documenting everything with explanations and screenshots, a youtube video for the report, and my project utilizes lighting that can be toggled on/off with some other effects like post processing/color grading/illumination that can also be toggled.
<h3>Video Report:</h3>
<h3>Slides:</h3>

<h3>Improvements:</h3>
<h4>Post Processing</h4>
The first improvement I made to make the game look more gritty and realistic is add some post processing through the global volume. Here I adjusted values like tonemapping, bloom, color, depth of field, film grain etc. to make the game look a lot better compared to what it was in the project progression. I also decided to make this toggleable to reach the project grading requirements so that this effect can be toggled on and off with the global volume with the G key
<img src="https://github.com/BillsKDev/IntroCG-CourseProject/blob/main/Gifs/PP.gif" width="992" height="546">

<h4>Lighting</h4>

The lighting was adjusted and I actually took time to decide where each light will be placed to give the game a more darker feel with more focused lights like giving the enemy more shine, and darker around. I also made it so you can **TOGGLE** the lights on and off with the T key by having a script that just toggles all the gameobjects with lights off an off with a keycode.
<img src="https://github.com/BillsKDev/IntroCG-CourseProject/blob/main/Gifs/Lighting.gif" width="992" height="546">

<h4>Removed Rim from Walls & used it for Damage</h4>
In the project progression, I felt that I did a pretty bad job of finding a good way to actually use the rim lighting shader and it was placed on walls/floors. This time around I wanted an actual reason to use the rim lighting so I removed the rim lighting from the walls and floors and added textures for them, then I made it so whenever the player or enemy takes damage there is a rim lighting flicker to let the player know that they took damage. This was done by changing the health script to loop through all the players render objects then swap them to the rim material for a short period then swap back to the original material after.
<img src="https://github.com/BillsKDev/IntroCG-CourseProject/blob/main/Gifs/RimChange.gif" width="992" height="546">

<h4>Map adjustments</h4>
As stated before, in the project progression I didn't really put things together properly, as I just made effects for the sake of making them. Now I am using the illumination models from the project progression on the pipes rather than the walls like before. I decided that I wanted the second room to look completely different so I decided to give it a glass look instead. You can view glass changes in visual effects, but below is the screenshot for an example illumination (a+s+d) on the pipes.
<img width="805" height="531" alt="image" src="https://github.com/user-attachments/assets/1b59bf9c-cb11-4233-81a9-041119572d51" />


<h3>Texturing</h3>

<h3>Visual Effects</h3>

<h4>Waves/Scrolling</h4>
From the previous project progression, I only had a scrolling texture shader for the water and I wanted to improve on this to make realistic looking waves on top of the scrolling effect. This is done by having a point defined on itself and have the waves move in towards that point, so if the values were 0 they would move to the origin of the plane. It uses a sine wave to have some displacement and paramaters like amplitude, frequency and speed that control how the wave actually behaves. This is completely different than the one showed in class since that was completely flat and simulates the movement rather than here I have an actual waves moving across the facility. I decided to do this because I thought in my project progression the scrolling shader was kind of forced so I had the water fill the entire facility, and the player would be able to see they are stranded through some glass windows in the second floor which would give the player some depth of danger seeing they are stranded on this facility

<img src="https://github.com/BillsKDev/IntroCG-CourseProject/blob/main/Gifs/WaterUpdated.gif" width="992" height="546">

<h4>Glass</h4>
Glass was made because I wanted to have the player to see the water and waves outside and make them feel like they are stranded. It was done by using a grab texture that takes a screenshot of the object, and then using the normal map distort the background for a glass like effect. It combines the object normals with the normal map and based on the angle between the view direction and surface normal it would make the edges more reflective. This one is different from the one in class since I added a lot more color control to what the glass would look like with a color shift, brightness, and reflection tint which can be updated to make the glass look unique. Its also different because I tried implementing reflections for more realism instead of the normal fresnel effect and I added a brightness adjuster to make the glass look a lot darker

 <img width="676" height="515" alt="image" src="https://github.com/user-attachments/assets/926edfef-f0a3-45a5-8d3f-c232b353de4c" />






<h2>Graphics Project Progression</h2>
<h4>Slides</h4>
https://docs.google.com/presentation/d/1xmUP6Fy1iveyDPFE9YhHVGZHih8lr-p5Y8zfMe-eHnI/edit?usp=sharing

<h4>Video Report</h4>
https://www.youtube.com/watch?v=Zyih_3_A2Og

<h4>Controls</h4>
Q & E to drop arms
Z & C to retract arms
Tab to lock onto enemy
Click to attack
Right click to block
Can be played with controller
Toggle the lighting models with 0/1/2/3/4
Toggle the LUTs with 5/6/7/8 (8 is normal)

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





