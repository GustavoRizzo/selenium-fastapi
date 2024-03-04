from fastapi import FastAPI
from fastapi.openapi.docs import get_swagger_ui_html

app = FastAPI()


@app.get("/screen-shot/")
def screen_shot():
    return {"Hello": "In the future, this will return a screen shot of a website."}


@app.get("/", include_in_schema=False)
async def custom_swagger_ui_html():
    return get_swagger_ui_html(openapi_url="/openapi.json", title="FastAPI Swagger UI")


@app.get("/openapi.json", include_in_schema=False)
async def get_open_api_endpoint():
    return app.openapi()
