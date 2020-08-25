function [tox,blk]=detox(tox)
% [tox,blk]=DETOX(tox)
%
% INPUT:
%
% tox   A character variable with empty rows
%
% OUTPUT:
%
% tox   A character variable without empty rows
% blk   A logical array identifying the blank rows
% 
% Gets rid of blank lines in a saved table of contents
%
% Last modified by fjsimons-at-alum.mit.edu, 10/09/2019

% Find the not blank lines
nblk=sum(abs(tox),2)~=0; 
% Identify the blank lines
blk=~nblk;
% Remove the blank lines
tox=tox(nblk,:);
