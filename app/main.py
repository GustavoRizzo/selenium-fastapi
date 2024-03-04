from fastapi import FastAPI, HTTPException, Form
from fastapi.openapi.docs import get_swagger_ui_html
from pydantic import HttpUrl, Field

from schemas.screenshot import ScreenshotRequest
from scripts.save_printscreen_page import save_screenshot_page

app = FastAPI()


@app.post("/screen-shot/")
def screen_shot(request: ScreenshotRequest):
    # Get the URL and width from the request
    url = request.url or None
    width = request.width or None

    print(f"Start Script, page: {url} ({type(url)}), width: {width}({type(width)})")

    # Validate the URL
    if not url:
        raise HTTPException(status_code=400, detail="The URL is required")

    # Save the screenshot
    res, msg = save_screenshot_page(url, width)

    # Return the result
    if res is False:
        raise HTTPException(status_code=500, detail=msg)
    return {"message": msg}


@app.get("/", include_in_schema=False)
async def custom_swagger_ui_html():
    return get_swagger_ui_html(openapi_url="/openapi.json", title="FastAPI Swagger UI")


@app.get("/openapi.json", include_in_schema=False)
async def get_open_api_endpoint():
    return app.openapi()
