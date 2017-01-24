addpath('./matlab_utils')

load('../benchmarkData/metadata/classMapping40.mat')

label_dir = '../benchmarkData/groundTruth';
output_dir = '../benchmarkData/groundTruth40cls';
mkdir_notexist(output_dir);

mapClass = [255, mapClass];
mask_cmap = labelcolormap(256);
raw_label_files = my_list_file(label_dir)';

for i = 1:length(raw_label_files)
    file_name = raw_label_files{i};
    file_path = fullfile(label_dir, raw_label_files{i});
    one_file = load(file_path);
    raw_label = one_file.groundTruth{1}.SegmentationClass + 1;
    map_label = mapClass(uint16(raw_label));
    assert( all(map_label(:) <= 255) && all(map_label(:) >= 0));
    
    output_path = fullfile(output_dir,  strrep(file_name,'.mat', '.png'));
    imwrite(uint8(map_label), mask_cmap, output_path);
end
