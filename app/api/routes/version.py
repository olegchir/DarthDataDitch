from fastapi import APIRouter
from fastapi.responses import PlainTextResponse
from app.utils.config import APP_VERSION

router = APIRouter()

@router.get("/version")
def version():
    version = f""" Welcome to the Star Wars API! ver. {APP_VERSION}
    
          __
.-.__      \ .-.  ___  __
|_|  '--.-.-(   \/\;;\_\.-._______.-.
(-)___     \ \ .-\ \;;\(   \       \ \
 Z    '---._\_((Q)) \;;\\ .-\     __(_)
 L           __'-' / .--.((Q))---'    \,
 O     ___.-:    \|  |   \'-'_          \
 Y  .-'      \ .-.\   \   \ \ '--.__     '\
   |____.----((Q))\   \__|--\_      \     '
    ( )        '-'  \_  :  \-' '--.___\
     K                \  \  \       \(_)
     A                 \  \  \         \,
     B                  \  \  \          \
     A                   \  \  \          '\
     N                    \  \__|           '
                           \_:.  \
                             \ \  \
                              \ \  \
                               \_\_|

"""

    return PlainTextResponse(content=version)
