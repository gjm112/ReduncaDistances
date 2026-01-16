wd = "/Users/gregorymatthews/Dropbox"
cd /Users/gregorymatthews/Dropbox/teeth-scriptus-pricei/code/matlab

% get data from bushbuck
data_bushbuck = readtable(wd+"/teeth-scriptus-pricei/data/matlab/data_bushbuck_LM3.csv");
        %get the number of rows and cols
        n_rows = size(data_bushbuck,1);
        n_cols = size(data_bushbuck,2);
        
        %blank array storage for matrix for each image
        teeth_data_bushbuck = zeros(2,100,n_rows/2);
        
        
        %loop to assign each tooth's coordinates to the appropriate spot in the
        %array
        for i=1:2:n_rows
            %get index for the image we are on 
            j = find((1:2:n_rows)==i);
            
            %assign matrix for image j 
             X = data_bushbuck{i:(i+1), 2:n_cols};
            
            %resample so all of the curves have 100 points
            teeth_data_bushbuck(:,:,j) = ReSampleCurve(X,100);
        end



%Get the LM3's fromscriptus and pricei
toothtype = {"LM3"};
species = {"pricei", "scriptus"};
for t=1
  data_scriptus = readtable(wd + "/teeth-scriptus-pricei/data/matlab/data_"+toothtype(t)+"_scriptus.csv")
  data_pricei = readtable(wd + "/teeth-scriptus-pricei/data/matlab/data_"+toothtype(t)+"_pricei.csv")
  data=[data_scriptus; data_pricei] 
        
        %get the number of rows and cols
        n_rows = size(data,1);
        n_cols = size(data,2);
        
        %blank array storage for matrix for each image
        teeth_data = zeros(2,100,n_rows/2);
        
        
        %loop to assign each tooth's coordinates to the appropriate spot in the
        %array
        for i=1:2:n_rows
            %get index for the image we are on 
            j = find((1:2:n_rows)==i);
            
            %assign matrix for image j 
             X = data{i:(i+1), 2:n_cols};
            
            %resample so all of the curves have 100 points
            teeth_data(:,:,j) = ReSampleCurve(X,100);
        end        

    end



load(wd + "/teeth-scriptus-pricei/data/matlab/pairwise_distances_"+toothtype(t)+".mat","ddd")

size(ddd,1)
ddd_bushbuck_LM3 = ddd;

for i = 1:size(ddd,1);
    disp(i);
    for j = 1:size(teeth_data_bushbuck,3);
        disp(j);
        ddd_bushbuck_LM3(i,size(ddd,1)+j)  = GeodesicElasticClosed(teeth_data(:,:,i),teeth_data_bushbuck(:,:,j));     
        ddd_bushbuck_LM3(size(ddd,1)+j,i) = ddd_bushbuck_LM3(i,size(ddd,1)+j);
    end
end

for i = 1:size(teeth_data_bushbuck,3);
    disp(i);
    for j = 1:size(teeth_data_bushbuck,3);
        disp(j);
        ddd_bushbuck_LM3(size(ddd,1)+i,size(ddd,1)+j)  = GeodesicElasticClosed(teeth_data_bushbuck(:,:,i),teeth_data_bushbuck(:,:,j));     
        ddd_bushbuck_LM3(size(ddd,1)+j,size(ddd,1)+i) = ddd_bushbuck_LM3(size(ddd,1)+i,size(ddd,1)+j)
        
    end
end

save(wd + "/teeth-scriptus-pricei/data/matlab/pairwise_distances_bushbuck_LM3.mat","ddd_bushbuck_LM3")
  csvwrite(wd + "/teeth-scriptus-pricei/data/matlab/pairwise_distances_bushbuck_LM3.csv",ddd_bushbuck_LM3)





  %%%%%%%%%%%%%%%%%%%
%LM2
 %%%%%%%%%%%%%%%%%%%%%
 % get data from bushbuck
data_bushbuck = readtable(wd+"/teeth-scriptus-pricei/data/matlab/data_bushbuck_LM2.csv");
        %get the number of rows and cols
        n_rows = size(data_bushbuck,1);
        n_cols = size(data_bushbuck,2);
        
        %blank array storage for matrix for each image
        teeth_data_bushbuck = zeros(2,100,n_rows/2);
        
        
        %loop to assign each tooth's coordinates to the appropriate spot in the
        %array
        for i=1:2:n_rows
            %get index for the image we are on 
            j = find((1:2:n_rows)==i);
            
            %assign matrix for image j 
             X = data_bushbuck{i:(i+1), 2:n_cols};
            
            %resample so all of the curves have 100 points
            teeth_data_bushbuck(:,:,j) = ReSampleCurve(X,100);
        end



%Get the LM2's froms criptus and pricei
toothtype = {"LM2"};
species = {"pricei", "scriptus"};
for t=1
  data_scriptus = readtable(wd + "/teeth-scriptus-pricei/data/matlab/data_"+toothtype(t)+"_scriptus.csv");
  data_pricei = readtable(wd + "/teeth-scriptus-pricei/data/matlab/data_"+toothtype(t)+"_pricei.csv");
  data=[data_scriptus; data_pricei];
        
        %get the number of rows and cols
        n_rows = size(data,1);
        n_cols = size(data,2);
        
        %blank array storage for matrix for each image
        teeth_data = zeros(2,100,n_rows/2);
        
        
        %loop to assign each tooth's coordinates to the appropriate spot in the
        %array
        for i=1:2:n_rows
            %get index for the image we are on 
            j = find((1:2:n_rows)==i);
            
            %assign matrix for image j 
             X = data{i:(i+1), 2:n_cols};
            
            %resample so all of the curves have 100 points
            teeth_data(:,:,j) = ReSampleCurve(X,100);
        end        

    end



load(wd + "/teeth-scriptus-pricei/data/matlab/pairwise_distances_"+toothtype(t)+".mat","ddd");

size(ddd,1)
ddd_bushbuck_LM2 = ddd;

for i = 1:size(ddd,1);
    for j = 1:size(teeth_data_bushbuck,3);
        ddd_bushbuck_LM2(i,size(ddd,1)+j)  = GeodesicElasticClosed(teeth_data(:,:,i),teeth_data_bushbuck(:,:,j));     
        ddd_bushbuck_LM2(size(ddd,1)+j,i) = ddd_bushbuck_LM2(i,size(ddd,1)+j);
    end
end

for i = 1:size(teeth_data_bushbuck,3);
    for j = 1:size(teeth_data_bushbuck,3);
        ddd_bushbuck_LM2(size(ddd,1)+i,size(ddd,1)+j)  = GeodesicElasticClosed(teeth_data_bushbuck(:,:,i),teeth_data_bushbuck(:,:,j));     
        ddd_bushbuck_LM2(size(ddd,1)+j,size(ddd,1)+i) = ddd_bushbuck_LM2(size(ddd,1)+i,size(ddd,1)+j)
        
    end
end

save(wd + "/teeth-scriptus-pricei/data/matlab/pairwise_distances_bushbuck_LM2.mat","ddd_bushbuck_LM2")
  csvwrite(wd + "/teeth-scriptus-pricei/data/matlab/pairwise_distances_bushbuck_LM2.csv",ddd_bushbuck_LM2)


  %%%%%%%%%%%%%%%%%%%
%UM2
 %%%%%%%%%%%%%%%%%%%%%
 % get data from bushbuck
data_bushbuck = readtable(wd+"/teeth-scriptus-pricei/data/matlab/data_bushbuck_UM2.csv");
        %get the number of rows and cols
        n_rows = size(data_bushbuck,1);
        n_cols = size(data_bushbuck,2);
        
        %blank array storage for matrix for each image
        teeth_data_bushbuck = zeros(2,100,n_rows/2);
        
        
        %loop to assign each tooth's coordinates to the appropriate spot in the
        %array
        for i=1:2:n_rows
            %get index for the image we are on 
            j = find((1:2:n_rows)==i);
            
            %assign matrix for image j 
             X = data_bushbuck{i:(i+1), 2:n_cols};
            
            %resample so all of the curves have 100 points
            teeth_data_bushbuck(:,:,j) = ReSampleCurve(X,100);
        end



%Get the LM2's froms criptus and pricei
toothtype = {"UM2"};
species = {"pricei", "scriptus"};
for t=1
  data_scriptus = readtable(wd + "/teeth-scriptus-pricei/data/matlab/data_"+toothtype(t)+"_scriptus.csv");
  data_pricei = readtable(wd + "/teeth-scriptus-pricei/data/matlab/data_"+toothtype(t)+"_pricei.csv");
  data=[data_scriptus; data_pricei];
        
        %get the number of rows and cols
        n_rows = size(data,1);
        n_cols = size(data,2);
        
        %blank array storage for matrix for each image
        teeth_data = zeros(2,100,n_rows/2);
        
        
        %loop to assign each tooth's coordinates to the appropriate spot in the
        %array
        for i=1:2:n_rows
            %get index for the image we are on 
            j = find((1:2:n_rows)==i);
            
            %assign matrix for image j 
             X = data{i:(i+1), 2:n_cols};
            
            %resample so all of the curves have 100 points
            teeth_data(:,:,j) = ReSampleCurve(X,100);
        end        

    end



load(wd + "/teeth-scriptus-pricei/data/matlab/pairwise_distances_"+toothtype(t)+".mat","ddd");

size(ddd,1)
ddd_bushbuck_UM2 = ddd;

for i = 1:size(ddd,1);
    for j = 1:size(teeth_data_bushbuck,3);
        ddd_bushbuck_UM2(i,size(ddd,1)+j)  = GeodesicElasticClosed(teeth_data(:,:,i),teeth_data_bushbuck(:,:,j));     
        ddd_bushbuck_UM2(size(ddd,1)+j,i) = ddd_bushbuck_UM2(i,size(ddd,1)+j);
    end
end

for i = 1:size(teeth_data_bushbuck,3);
    for j = 1:size(teeth_data_bushbuck,3);
        ddd_bushbuck_UM2(size(ddd,1)+i,size(ddd,1)+j)  = GeodesicElasticClosed(teeth_data_bushbuck(:,:,i),teeth_data_bushbuck(:,:,j));     
        ddd_bushbuck_UM2(size(ddd,1)+j,size(ddd,1)+i) = ddd_bushbuck_UM2(size(ddd,1)+i,size(ddd,1)+j)
        
    end
end

save(wd + "/teeth-scriptus-pricei/data/matlab/pairwise_distances_bushbuck_UM2.mat","ddd_bushbuck_UM2")
  csvwrite(wd + "/teeth-scriptus-pricei/data/matlab/pairwise_distances_bushbuck_UM2.csv",ddd_bushbuck_UM2)