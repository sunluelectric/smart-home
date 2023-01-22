# -*- coding: utf-8 -*-
"""
sunlu - sunlu.electric@gmail.com
"""
from picamera import PiCamera
import time

def main():
    pi_camera = PiCamera()
    pi_camera.resolution = (640, 480)
    pi_camera.start_preview()
    time.sleep(3)
    pi_camera.capture('../data/test_camera.jpg')

if __name__ == '__main__':
    main()
