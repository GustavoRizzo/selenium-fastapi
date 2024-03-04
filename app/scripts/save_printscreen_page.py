from selenium import webdriver
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities

print("Start Script")

URL_PAGE = "https://www.horariodebrasilia.org/"

# Chrome options
chrome_options = webdriver.ChromeOptions()
chrome_options.add_argument('--headless')
chrome_options.add_argument('--no-sandbox')
chrome_options.add_argument('--disable-dev-shm-usage')

try:
    ############################################
    # Start driver
    ############################################
    print("Starting driver...")
    driver = webdriver.Chrome(options=chrome_options)
    # driver = webdriver.Chrome(ChromeDriverManager().install())
    print("Driver started")

    try:
        ############################################
        # Open page
        ############################################
        print("Opening page...")
        driver.get(URL_PAGE)
        driver.implicitly_wait(200)
        print(f"Page opened - page title: {driver.title}")

        try:
            ############################################
            # take screenshot
            ############################################
            screenshot = driver.get_screenshot_as_png()
            DIR_MEDIA = "../media"
            # save screenshot
            with open(f"{DIR_MEDIA}/screenshot.png", "wb") as f:
                f.write(screenshot)
            print("Screenshot saved")
        except Exception as screenshot_error:
            print(f"Error taking screenshot: {screenshot_error}")
    except Exception as page_error:
        print(f"Error opening page: {page_error}")

finally:
    ############################################
    # Close driver
    ############################################
    try:
        driver.quit()
        print("Driver closed")
    except Exception as driver_close_error:
        print(f"Error closing driver: {driver_close_error}")
