from selenium import webdriver
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities


URL_PAGE = "https://www.horariodebrasilia.org/"
WIDTH_DEFAULT = 400


def save_screenshot_page(url_page: str = URL_PAGE, width: int = WIDTH_DEFAULT) -> (bool, str):
    """
    Save a screenshot of a page.
    :param url_page: The URL of the page to capture the screen from
    :param width: The width of the screen capture (in pixels)
    :return: None
    """
    print(f"Start Script, page: {url_page} ({type(url_page)}), width: {width}({type(width)})")
    # Chrome options
    chrome_options = webdriver.ChromeOptions()
    chrome_options.add_argument('--headless')
    chrome_options.add_argument('--no-sandbox')
    chrome_options.add_argument('--disable-dev-shm-usage')
    chrome_options.add_argument(f'--window-size={width},1080')

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
        driver.get(url_page)
        driver.implicitly_wait(200)
        print(f"Page opened - page title: {driver.title}")

        try:
            ############################################
            # take screenshot
            ############################################
            screenshot = driver.get_screenshot_as_png()
            DIR_MEDIA = "./media"
            # save screenshot
            with open(f"{DIR_MEDIA}/screenshot.png", "wb") as f:
                f.write(screenshot)
            print("Screenshot saved")
        except Exception as screenshot_error:
            print(f"Error taking screenshot: {screenshot_error}")
            return False, f"Error taking screenshot: {screenshot_error}"
    except Exception as page_error:
        print(f"Error opening page: {page_error}")
        return False, f"Error opening page: {page_error}"
    driver.quit()
    print("Driver closed")
    return True, "Screenshot saved"
