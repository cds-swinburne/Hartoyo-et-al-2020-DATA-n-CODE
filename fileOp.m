%fileOp

str = '78C \n 72C \n 64C \n 66C \n 49C';
fileID = fopen('temperature.dat','w');
fprintf(fileID,'%s',str);
fclose(fileID);

%type output1.txt
fileID = fopen('output1.txt','r');
degrees = char(176);
[A,count] = fscanf(fileID, ['%d']);
fclose(fileID);

for i=1:300
    i
    yy= sum(A(:) == i)
    if yy==1
        i=i
    end
end