from selenium import webdriver
from selenium.webdriver.chrome.service import Service as ChromeService
from webdriver_manager.chrome import ChromeDriverManager

from .base_driver import BaseDriverHelper

DRIVER_NAME = 'chromewebdriver'

class WebDriverHelper(BaseDriverHelper):

    options = webdriver.ChromeOptions()
    options.add_argument("--headless=new")

    def __init__(self):
        super().__init__(name=DRIVER_NAME)
        self._driver_path = ChromeService(ChromeDriverManager().install())#executable_path="geckodriver")
        self._driver = webdriver.Chrome(service=self._driver_path, options=self.options) 

    @property
    def driver(self):
        return self._driver

    def cleanup(self):
        self._driver.quit()

    """ PRIVATE """

    def check_valid_driver_connection(self):
        try:
            driver = webdriver.Chrome(self._driver_path)
            driver.quit()
            return True
        except Exception as e:
            print('Could not load chromedriver: %s'.format(e))
            return False