% Get all entries in KKI directory
D = dir;
V = cell(numel(D),1);
headers = cell(numel(D),1);
% A counter of valid subdirectories
cnt = 0;
for i=1:numel(D)
    fprintf('Checking file %s...', D(i).name);
    if (D(i).isdir)&&(~isnan(str2double(D(i).name)))
        % Read files from subdirectories with numerical names
        cnt = cnt+1;
        V{cnt} = niftiread(sprintf('%s/sfnwmrda%s_session_1_rest_1.nii.gz', D(i).name, D(i).name));
        V{cnt} = mean(V{cnt}, 4); % average immediately to save mem
        headers{cnt} = niftiinfo(sprintf('%s/sfnwmrda%s_session_1_rest_1.nii.gz', D(i).name, D(i).name));
        fprintf('got %dth NII data!\n', cnt);
    else
        fprintf('garbage\n');
    end
end
V = V(1:cnt);
headers = headers(1:cnt);
save('KKI.mat', 'V', 'headers');
