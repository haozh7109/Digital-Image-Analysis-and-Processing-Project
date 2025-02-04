
%% Some hints for the mandatory assignment one
% I have received some feedback that it is hard to understand what you are% supposed to do in the first mandatory assignment. 
So here are some hints% on what you are supposed to do. I'm not going to solve the exercises but% I'll try to provide some hints for you. 
%% You have to keep in mind that the overall task in this exercise is to be% able to autmatically segment each texture from the other textures. 
This% means that the answer to the question what is a good direction/good% feature is a direction/feature that will help you segment the textures.
%% Part A% This part is just to look at the 8 different textures and by your own% judgement describe how the features differ. 
Relevant keywords are listed
% in the assignment. So forexample saying that the frequency in texture X% is higher than texture Z is okay. 
But if you are able to figure out the% actual quantitative frequency you are welcome to say so, but this is not% necessary.
%% Part B% Here you should devide the images into subimages of each texture. 
You may% also do different histogram transforms as a pre-prosessing step as I used
% the histogram equalization as a preprossing in the first weekly exercise.% 
% You also should, based on you analysis in A, choose some paramteres you% believe should help separating the textures
.%% Then you are to normalise the image (thus use fewer grayleves). How many% graylevels do you need? 
And calculate the GLCM from each texture.%% 
For example like this: % Here I have chosen some other textures from 
http://www.cb.uu.se/~gustaf/texture/clear allclose alltexture1 = imread('texture1.png');
texture2 = imread('texture2.png');% 
My chosen number of graylevelsG = 16;%
My chosen directiondx = 2;dy = 0;
%Normalizing the imagestexture1 = uint8(round(double(texture1) * (G-1) / double(max(texture1(:)))));
texture2 = uint8(round(double(texture2) * (G-1) / double(max(texture2(:)))));
Lets make a mock texture3texture3 = texture2;lim1 = 6;lim2 = 8;texture3(texture2>lim2) = 8;texture3((texture2>lim1)&(texture2<=lim2)) = 15;texture3(texture2<lim1) = 0;
% Calculate the GLCM from each texture. Here I use the symmetric normalized% GLCM. 
The isotropic GLCM menitioned in the lecture is a GLCM where you% merge many GLCMs calulated for different directions. 
See the lecture% slides for more detail.
P1 = GLCM(texture1,G,dx,dy,1,1);
P2 = GLCM(texture2,G,dx,dy,1,1);
P3 = GLCM(texture3,G,dx,dy,1,1);
P1_test = graycomatrix(imread('texture1.png'), 'numlevels', 16)
% Plot the images and resulting GLCMsfigure(1);clfimagesc(texture1)colormap graytitle('Texture 1');figure(2);clfimagesc(P1)colormap jettitle('GLCM of texture 1');figure(3);clfimagesc(texture2)colormap graytitle('Texture 2');figure(4);clfimagesc(P2)colormap jettitle('GLCM of texture 3');figure(5);clfimagesc(texture3)colormap graytitle('Texture 3');figure(6);clfimagesc(P3)colormap jettitle('GLCM of texture 3');%% Part C pre% In part C you are asked to use three different features. Let's% investigate them a bit.% Creating two matrices with the corresponding index.i = repmat((0:(G-1))', 1, G);j = repmat( 0:(G-1)  , G, 1);%To understand the three different GLCM features, lets look at each of the%weighting%Intertia weightinginertia_weighting = (i-j).^2;%Homogenity (Inverse Difference Moment)idm_weighting = 1./(1+(i-j).^2);%Cluster shade weighting using mean from GLCM from texture 1u_x_1 = sum(sum(P1 .* (i)))u_y_1 = sum(sum(P1 .* (j)));cs_weighting_1 = (i+j-u_x_1-u_y_1).^3;%Cluster shade weighting using mean from GLCM from texture 2u_x_2 = sum(sum(P2 .* (i)));u_y_2 = sum(sum(P2 .* (j)));cs_weighting_2 = (i+j-u_x_2-u_y_2).^3;figure(7)imagesc(inertia_weighting)colorbartitle('GLCM intertia weighting')%Lets calculate some values. What to they mean?text1_intertia = sum(sum(inertia_weighting.*P1))text2_intertia = sum(sum(inertia_weighting.*P2))text3_intertia = sum(sum(inertia_weighting.*P3))figure(8)imagesc(idm_weighting)colorbartitle('Homogenity weighting');%Lets calculate some values. What to they mean?text1_idm = sum(sum(idm_weighting.*P1))text2_idm = sum(sum(idm_weighting.*P2))text3_idm = sum(sum(idm_weighting.*P3))figure(9)imagesc(cs_weighting_1)colorbartitle('Cluster shade weighting using means from P1');figure(10)imagesc(cs_weighting_2)colorbartitle('Cluster shade weighting using means from P2');% I'll leave it for you to calculate some example values for the GLCM % cluster shade% So when looking at these weights, what will each of these features favour?% What kind of structure in the GLCM matrix will get what values??%% Part C% In part C you are supposed to calculate feature images. You do this by% having a local window gliding over the entire image of the four textures% and for each window you get one GLCM matrix which will give you one value% for each feature.% One feature image for one chosen GLCM direction can for example look like% this:load feature_img figure(11)imagesc(feature_img);colormap jetcolorbartitle('Example of a feature image');%% Part D% Part D is to treshold the different feature images to try to segment each% texture.% post_id = 529; %delete this line to force new post;% permaLink = http://inf4300.olemarius.net/2015/09/29/oblig1-m/;