#!/usr/bin/env sh

#img_folder=/home/hzdz505/dl/datasets/full_data-depth/training/
#images=sideboard boxes dino cotton
img_folder=/home/hzdz505/dl/datasets/full_data-depth/additional/
images=(medieval2 pens)

echo "Creating full_test_lmdb and compute mean file for:"
#set root path, so that we can run this script everywhere 
cd $img_folder
for img in ${images[@]}
do
    	echo "${img}..."
	full_test_lmdb="${img_folder}${img}/epi/full_test_lmdb"
	full_test_txt="./${img}/epi/full_test.txt"
    	rm -rf $full_test_lmdb

	# convert_imageset [FLAGS] ROOTFOLDER/ LISTFILE DB_NAME
	# '/' in "${img_folder}/" is required, cos we do not have it in full_test_txt
	convert_imageset \
        $img_folder \
	$full_test_txt \
	$full_test_lmdb

	# Must use name mean.binaryproto 
	compute_image_mean \
	$full_test_lmdb \
	"${img_folder}${img}/epi/mean.binaryproto"
done

echo "All Done.."
