function tox2cell(tox)
% TOX2CELL(tox)
%
% Takes a RAPIDEYE table of contents and returns a cell with the variables
% already in it and their times identified from the filenames inside of it
%
% INPUT:
%
% tox    A table of contents as we've been saving for satellite imagerey
%        using RAPIDEYS, RAPIDEYE, RAPIDEYG, RAPIDEYC, MOSAIC, PUZZLE, etc
%        Find the ROWS in which the characters chars appear
%
% OUTPUT:
%
% None, but the following variables appear as if by magic in the calling workspace
%   ims    A cell array collecting the images (if already loaded)
%   tims   A DATEVEC array with their time stamps, for use in DATETIME
% and, if it makes sense given the format, also
%   timd   A DATENUM array with their time stamps, for use in DATESTR
%   timn   A NUMERIC array with their time stamps, just for fun
% 
% Last tested on MATLAB Version: 9.0.0.341360 (R2016a)
%
% Last modified by fjsimons-at-alum.mit.edu, 10/12/2019

% The thing(s) you know that the non-nonsensical variable names contain
chars=abs('_');

% Find the appropriate variable names from the table of contents
toxi=findvars(tox,chars);
% Find the appropriate time strings from those variable names 
toxj=findstrs(toxi,chars);

% Count them
seno=ones(size(toxi,1),1);

% First report the appropriate time stamps as a straight NUMBER
evalin('caller',sprintf('timn=round([%s]/1e6)'';',reshape([toxj 32*seno]',1,[])))

% Format in which you deliver the dates to the subsequent processing
fmt='yyyymmdd';
% This works from a truncated character and produces a datevec
assignin('caller','tims',datevec(datenum(...
    reshape([toxj(:,1:8) 32*seno],size(toxj,1),[]),fmt)))

% Looks like EVALIN doesn't work with DATETIME... yet?

if size(toxj,2)==14
  % The following two rely on complete formats so that the 1e-6 division is reasonable
  % This works from a number converted to a string, just to show the option
  % This returns the string as a number just for fun
  evalin('caller',sprintf('timn=round([%s]/1e6)'';',reshape([toxj 32*seno]',1,[])))
  % This returns the string as a DATENUM just for fun - order matters!
  evalin('caller',sprintf('timd=datenum(num2str(timn),''%s'');',fmt))
end

% Stick in quotes and a blank column and merrily move along
% Don't complain if we just want the time convesion but we hadn't loaded
% the variables yet
try
  evalin('caller',sprintf('ims={%s};',reshape([toxi 32*seno]',1,[])))
end

% Auxiliary function to find variable names
function toxi=findvars(tox,chars)
% The thing(s) you know that the non-nonsensical variable names contain
toxi=tox(ceil(mod(find(abs(tox)==chars),size(tox,1)+1e-6)),:);

% Auxiliary function to find variable time strings, could use PREF
function toxj=findstrs(toxi,chars)
% All begin with a common string followed by the special character
toxj=toxi(:,find(abs(toxi(randi(size(toxi,1)),:))==chars)+1:end);
