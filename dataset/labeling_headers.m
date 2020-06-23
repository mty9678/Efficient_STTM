%% Import data from text file.
% Script for importing data from the following text file:
%
%    C:\Users\User\TTNeuralNet\MMK_code\labelfile.txt
%
% To extend the code to different selected data or a different text file,
% generate a function instead of a script.

% Auto-generated by MATLAB on 2019/03/07 15:32:38

%% Initialize variables.
filename = './labelfile.txt';
delimiter = '\t';
startRow = 2;

%% Format string for each line of text:
%   column1: double (%f)
%	column2: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Create output variable
labelfile = [dataArray{1:end-1}];
%% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans;

%% putting label for each file of headers
load('filename.mat');
num = cell(length(headers_test_filename),1);
for i = 1:length(headers_test_filename)
     headers_test_filename{i}.label=labelfile(i,2);
end