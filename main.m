% INITIALIZATION
addpath(genpath('libraries'),genpath('pcdata'));

%ptCloud = pcread('bun_zipper.ply');
% dataFile = fullfile(toolboxdir('vision'), 'visiondata', 'livingRoom.mat');
% load(dataFile);
% ptCloud = livingRoomData{44};
% 
% ptCloud = pcread('body-v2.ply');
% gridStep = 10;
% iscolor = 1;
% ptCloud = pcdownsample(ptCloud, 'gridAverage', gridStep);

ptCloud = pcread('teapot.ply');
iscolor = 0;
pcshow(ptCloud);
gridStep = 0.1;
ptCloud = pcdownsample(ptCloud, 'gridAverage', gridStep);
%% PART 1 : GRAPH CONSTRUCTION:
%threshold = 1;
%disp('adding nodes to graph');
%G = graph_addnodes(ptCloud);
disp('adding edges to graph'); 
num_neighbors = 5;
sigma_sq = 10;
G = graph_addedges(ptCloud,num_neighbors,sigma_sq);
Graph_pc = graph_addnodeattributes(G,ptCloud,iscolor);
%% PART 2 : GRAPH RESAMPLING:
Graph_pc_imp = graph_calcimp(Graph_pc, ptCloud);
sampling_density = 0.3;
sample_index = randsample(ptCloud.Count, round(sampling_density * ptCloud.Count), true, Graph_pc_imp.Nodes.Imp);
%construct new point cloud from sample_index:
xyz_rs = ptCloud.Location(sample_index,:);
if(iscolor)
    color_rs = ptCloud.Color(sample_index,:);
    ptCloud_rs = pointCloud(xyz_rs, 'Color',color_rs);
else
    ptCloud_rs = pointCloud(xyz_rs);
end
figure(1);
pcshow(ptCloud);
figure(2);
pcshow(ptCloud_rs);











%% PART 3 : SEGMENTATION









%% PART 3 : SEGMENTATION:

