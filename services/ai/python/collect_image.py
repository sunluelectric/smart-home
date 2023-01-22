# -*- coding: utf-8 -*-
"""
sunlu - sunlu.electric@gmail.com
"""

import cv2 # require package opencv-python
import time
from datetime import datetime
from alive_progress import alive_bar # require alive_progress, for displaying progress

IMAGE_RESOLUTION = (640, 480)
SAVE_PATH = '../data/camera_raw/'
IMAGE_INTERVAL = 5
IMAGE_NUM = 60

def collect_image(save_path: str, image_interval: int, image_num: int):
    print("Initializing...")
    cap = cv2.VideoCapture(0)
    time.sleep(5)
    cap.set(cv2.CAP_PROP_FRAME_WIDTH, IMAGE_RESOLUTION[0])
    cap.set(cv2.CAP_PROP_FRAME_HEIGHT, IMAGE_RESOLUTION[1])
    with alive_bar(image_num, bar='classic') as bar:
        for i in range(image_num):
            ret, frame = cap.read()
            image_name = save_path + datetime.now().strftime('%Y-%m-%d-%H-%M-%S') + '.jpg'
            cv2.imwrite(image_name, frame)
            time.sleep(image_interval)
            bar()
            if cv2.waitKey(1) & 0xFF == ord('q'):
                break
    print("Image collection completed.")
    _ = input("Press any key to continue...")
if __name__ == '__main__':
    print("Start image collection program.")
    collect_image(SAVE_PATH, IMAGE_INTERVAL, IMAGE_NUM)
