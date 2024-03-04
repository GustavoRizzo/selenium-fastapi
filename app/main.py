from fastapi import FastAPI

app = FastAPI()


@app.get("/screen-shot/")
def screen_shot():
    return {"Hello": "In the future, this will return a screen shot of a website."}
