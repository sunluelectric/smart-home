from picamera import PiCamera
import time
from datetime import datetime

CAMERA_NAME = 'sunlu-iot-1-cam'
CAMERA_MODE = {'picture', 'vedio'}

class PiCameraManager:
    def __init__(self):
        self.camera_mode = None
        self.resolution = None
        self.interval = None
        self.framerate = None
        self.save_as_path = None
        self.pi_camera = PiCamera()
    def set_mode(self, camera_mode: str = 'picture'):
        if camera_mode in CAMERA_MODE:
            self.camera_mode = camera_mode
        else:
            raise Exception("Unrecognized pi camera mode.")
    def set_resolution(self, resolution: tuple = (640, 480)):
        self.resolution = resolution
        self.pi_camera.resolution = self.resolution
    def set_interval(self, interval: int = 1):
        self.interval = interval
    def set_framerate(self, framerate: int = 24):
        self.framerate = framerate
    def set_save_as_path(self, save_as_path: str = './'):
        self.save_as_path = save_as_path
    def warmup(self):
        self.pi_camera.start_preview()
        time.sleep(3)
    def take_a_picture(self):
        self.pi_camera.capture(self.save_as_path + 'take_a_picture.jpg')
    def take_pictures(self, num: int = None, duration: int = None, start_time: str = None, end_time: str = None) -> int:
        num_taken = 0
        if num:
            while num_taken < num:
                time_start = time.time()
                self.pi_camera.capture(self.save_as_path + self._get_save_as_name())
                num_taken += 1
                time.sleep(max(0, self.interval - (time.time() - time_start)))
            return num_taken
        if duration:
            time_to_stop = time.time() + duration 
            while time.time() < time_to_stop:
                time_start = time.time()
                self.pi_camera.capture(self.save_as_path + self._get_save_as_name())
                num_taken += 1
                time.sleep(max(0, self.interval - (time.time() - time_start)))
            return num_taken
        if (start_time is not None) and (end_time is not None):
            start_time_epoch = None
            end_time_epoch = None
            try:
                start_time_epoch = datetime.strptime(start_time, '%Y%m%d%H%M%S').timestamp()
                end_time_epoch = datetime.strptime(end_time, '%Y%m%d%H%M%S').timestamp()
            except:
                pass
            try:
                today = datetime.now()
                start_time_epoch = datetime.strptime(start_time, '%H%M%S')
                start_time_epoch = start_time_epoch.replace(year = today.year, month = today.month, day = today.day)
                start_time_epoch = start_time_epoch.timestamp()
                end_time_epoch = datetime.strptime(end_time, '%H%M%S')
                end_time_epoch = end_time_epoch.replace(year = today.year, month = today.month, day = today.day)
                end_time_epoch = end_time_epoch.timestamp()
            except:
                pass
            if not (start_time_epoch and end_time_epoch):
                raise Exception("Start and/or end time of the pictures taking is set incorrectly.")
            if not (start_time_epoch < end_time_epoch):
                raise Exception("Start and/or end time of the pictures taking is set incorrectly.")
            while time.time() < start_time_epoch:
                time.sleep(1)
            while time.time() < end_time_epoch:
                time_start = time.time()
                self.pi_camera.capture(self.save_as_path + self._get_save_as_name())
                num_taken += 1
                time.sleep(max(0, self.interval - (time.time() - time_start)))
            return num_taken
        raise Exception("Take picture command is set incorrectly.")
    def _get_save_as_name(self) -> str:
        return CAMERA_NAME + '-' + datetime.now().strftime('%Y-%m-%d-%H-%M-%S') + '.jpg' 

if __name__ == '__main__':
    print("Initializing ...")
    picam_manager = PiCameraManager()
    picam_manager.set_mode('picture')
    picam_manager.set_resolution((320, 240))
    picam_manager.set_interval(10)
    picam_manager.set_save_as_path('/home/sunlu/Project/data/camera_raw/')
    picam_manager.warmup()
    print("Start taking pictures...")
    num_taken = picam_manager.take_pictures(start_time = '013000', end_time = '014500')
    print("A total number of {} pictures are taken.".format(num_taken))
    _ = input()
