from selenium import webdriver
from selenium.webdriver.firefox.service import Service as FirefoxService
from webdriver_manager.firefox import GeckoDriverManager

from .base_driver import BaseDriverHelper

DRIVER_NAME = 'geckowebdriver'

class WebDriverHelper(BaseDriverHelper):

    options = webdriver.FirefoxOptions()
    options.add_argument("--disable-gpu")
    options.add_argument('--ignore-certificate-errors')
    options.add_argument("--start-maximized")
    options.add_argument("--disable-infobars")

    def __init__(self):
        super().__init__(name=DRIVER_NAME)
        self._driver_path = FirefoxService(GeckoDriverManager().install())
        self._driver = webdriver.Firefox(service=self._driver_path, options=self.options) 

    @property
    def driver(self):
        return self._driver

    def cleanup(self):
        self._driver.quit()

    """ PRIVATE """

    def check_valid_driver_connection(self):
        try:
            driver = webdriver.Firefox(self._driver_path)
            driver.quit()
            return True
        except Exception as e:
            print('Could not load geckodriver: %s'.format(e))
            return False
