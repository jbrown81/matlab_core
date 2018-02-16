function []=write_file(array,filename,dtype,varargin)
%write_file writes out data a text file
% dtype can be: 1=float with 4 significant digits, 2: int, 3: string

if length(varargin)<1
    floatpre=4;
    floatpost=4;
else
    floatpre=varargin{1};
    floatpost=varargin{2};
end

fid=fopen(filename,'w+','n', 'US-ASCII');
array_size=size(array);
array_2d=array_size(2)>1;
for i=1:length(array)
    if array_size(2)>1
        cur_out=array(i,:);
    else
        cur_out=array(i);
    end
    if array_2d
        for j=1:array_size(2)
            if dtype==1
                outstring=sprintf('%%%d.%df ',floatpre,floatpost);
                fprintf(fid,outstring,cur_out(j));
            elseif dtype==2
                fprintf(fid,'%d ',cur_out(j));
            elseif dtype==3
                fprintf(fid,'%s ',cur_out(j));
            end
        end
    else
        if dtype==1
            outstring=sprintf('%%%d.%df',floatpre,floatpost);
            fprintf(fid,outstring,cur_out);
        elseif dtype==2
            fprintf(fid,'%d',cur_out);
        elseif dtype==3
            fprintf(fid,'%s',cur_out);
        end
    end
    fprintf(fid,'\n');
end
fclose(fid);