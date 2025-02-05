import os
import shutil

for i in range(295):
    print(i)
    os.makedirs(f'./data/room/room{i}/2_views/images', exist_ok=True)
    shutil.copy(f'./room/room/img-{str(6*i+1).zfill(5)}.png',f'./data/room/room{i}/2_views/images/r{i}.png')
    shutil.copy(f'./room/room/img-{str(6*i+7).zfill(5)}.png',f'./data/room/room{i}/2_views/images/r{i+1}.png')