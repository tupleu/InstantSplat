import os
import shutil
import imageio

def images_to_video(image_folder, output_video_path, fps=30):
    """
    Convert images in a folder to a video.

    Args:
    - image_folder (str): The path to the folder containing the images.
    - output_video_path (str): The path where the output video will be saved.
    - fps (int): Frames per second for the output video.
    """
    images = []

    for filename in sorted(os.listdir(image_folder)):
        if filename.endswith(('.png', '.jpg', '.jpeg', '.JPG', '.PNG')):
            image_path = os.path.join(image_folder, filename)
            image = imageio.imread(image_path)
            images.append(image)

    imageio.mimwrite(output_video_path, images, fps=fps)

# try:
#     for i in range(295):
#         print(i)
#         shutil.copy(f'./output/infer/room/room{i}/2_views_1000Iter_1xPoseLR/interp/ours_1000/renders/00001.png',f'./room/output/img-{str(6*i+7).zfill(5)}.png')
# except:
#     pass
images_to_video('./room/input', './original.mp4')
# images_to_video('./room/output', './generated.mp4')