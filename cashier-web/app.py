from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles
from fastapi.responses import FileResponse
from pydantic import BaseModel
from fastapi.middleware.cors import CORSMiddleware
import os

app = FastAPI(title="cashier-web")

# Enable CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# JFrog Frog-Themed Menu
MENU = {
    "fly-burger": 12.0,
    "lily-fries": 5.0,
    "tadpole-shake": 3.5,
    "dragonfly-pizza": 14.0,
    "mosquito-wings": 8.5,
    "swamp-salad": 7.0,
    "cricket-chips": 4.5,
    "catfish-combo": 16.0
}

class Order(BaseModel):
    items: list[str]

@app.get("/")
async def root():
    return FileResponse("static/index.html")

@app.get("/health")
def health():
    return {"ok": True}

@app.post("/bill")
def bill(order: Order):
    total = 0.0
    line_items = []
    for item in order.items:
        price = MENU.get(item, 0.0)
        line_items.append({"item": item, "price": price})
        total += price
    return {"line_items": line_items, "total": total}

@app.get("/menu")
def menu():
    return MENU

# Mount static files
static_dir = os.path.join(os.path.dirname(__file__), "static")
if os.path.exists(static_dir):
    app.mount("/static", StaticFiles(directory=static_dir), name="static")
