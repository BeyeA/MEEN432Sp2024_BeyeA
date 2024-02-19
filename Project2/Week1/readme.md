Description: 
For Week 1, our group plotted a racetrack consisting of 2 curved sections of radius of 200 meters, 2 straightaway sections of 900 meters, and a track width of 15 meters using the 'linspace' function to generate points between specified locations. For the curved sections, the parametric equations of a circle were used to compute the x and y coordinates. Then, the x and y coordinates are combined into arrays. Then the green background and track are plotted. 

An animated line feature is then initialized and the "car" patch is also created. A for loop is then used to iterate over each point. The slope of the line at the current point is calculated sing the difference in y-coordinates divided by the difference in x-coordinates between the current point and the next point on the racetrack. Then the car is rotated accordingly and the car image is updated. 

Instructions: 
Download the Week1.m (Matlab) file. Open the downloaded file using the Matlab R2023b application. Click the "run" button on the Matlab application. The expected output is a stadium-shaped track with a rectangular patch that follows the track's path. 

