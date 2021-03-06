#!/bin/bash
set -eu

# training
python train_ppdet.py --config_url_path picodet/picodet_s_320_coco_lcnet.yml \
    --weights https://paddledet.bj.bcebos.com/models/picodet_s_320_coco_lcnet.pdparams \
    --coco_json_path ./img/coco.json --image_root ./img/ --batch_size 1 --epoch 500 --num_classes 2 --learning_rate 0.01
# training + validation
python train_ppdet.py --config_url_path picodet/picodet_s_320_coco.yml \
    --weights https://paddledet.bj.bcebos.com/models/picodet_s_320_coco.pdparams \
    --coco_json_path ./img/coco.json --image_root ./img/ --batch_size 1 --epoch 10 \
    --coco_json_path_valid ./img/coco.json --image_root_valid ./img/ --batch_size_valid 1 --num_classes 2
# training GPU + fp16
python train_ppdet.py --config_url_path picodet/picodet_s_320_coco.yml \
    --weights https://paddledet.bj.bcebos.com/models/picodet_s_320_coco.pdparams \
    --coco_json_path ./img/coco.json --image_root ./img/ --batch_size 1 --epoch 10 ---use_gpu ---fp16
# inference image
python train_ppdet.py --config_url_path picodet/picodet_s_320_coco_lcnet.yml \
    --weights https://paddledet.bj.bcebos.com/models/picodet_s_320_coco_lcnet.pdparams \
    --img ./img/img_dog_cat.jpg --num_classes 80
# inference video
python train_ppdet.py --config_url_path picodet/picodet_s_320_coco.yml \
    --weights https://paddledet.bj.bcebos.com/models/picodet_s_320_coco.pdparams \
    --video ./palace.h264.mp4 --num_classes 80
# training keypoint
python train_ppdet.py --config_url_path keypoint/tiny_pose/tinypose_128x96.yml \
    --weights https://bj.bcebos.com/v1/paddledet/models/keypoint/tinypose_128x96.pdparams \
    --coco_json_path ./img/coco.json --image_root ./img/ --batch_size 1 --epoch 50  --num_classes 2 ---is_kpt --num_joints 4
# inference keypoint
python train_ppdet.py --config_url_path keypoint/tiny_pose/tinypose_128x96.yml \
    --weights ./output20220614152149/myyaml/model_final.pdopt \
    --img ./img/img_dog_cat.jpg --num_classes 2 ---is_kpt --num_joints 4
