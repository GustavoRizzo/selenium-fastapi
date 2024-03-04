from pydantic import BaseModel, HttpUrl, Field


class ScreenshotRequest(BaseModel):
    url: str = Field("", title="Page URL", description="The URL of the page to capture the screen from", min_length=1)
    width: int = Field(400, title="Capture Width", description="The width of the screen capture (in pixels)", ge=1)
