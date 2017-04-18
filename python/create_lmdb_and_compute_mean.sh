#!/usr/bin/env sh

########### 特别注意，下面生成lmdb时不要再打乱顺序，禁止 --shuffle，要和hdf5中的真值一一对应 #######

save_path=/home/hzdz505/dl/datasets/full_data-depth/training/lmdb_data
img_folder=/home/hzdz505/dl/datasets/full_data-depth/training/

#echo "Make directory: caffe_data ..."
#mkdir $save_path

echo "Creating train img lmdb.."
rm -rf $save_path/train_lmdb
convert_imageset \
$img_folder \
./train.txt \
$save_path/train_lmdb

echo "Creating validate img lmdb.."
rm -rf $save_path/val_lmdb
convert_imageset \
$img_folder \
./val.txt \
$save_path/val_lmdb

echo "Creating test img lmdb"
rm -rf $save_path/test_lmdb
convert_imageset \
$img_folder \
./test.txt \
$save_path/test_lmdb

echo "Computing mean for train_lmdb"
compute_image_mean \
$save_path/train_lmdb \
$save_path/train_mean.binaryproto

echo "Computing mean for val_lmdb"
compute_image_mean \
$save_path/val_lmdb \
$save_path/val_mean.binaryproto

echo "Computing mean for test_lmdb"
compute_image_mean \
$save_path/test_lmdb \
$save_path/test_mean.binaryproto

echo "All Done.."
