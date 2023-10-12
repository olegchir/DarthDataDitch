from fastapi import APIRouter
from fastapi.responses import PlainTextResponse
from app.utils.config import APP_VERSION

router = APIRouter()

@router.get("/version")
def version():
    version = f"""

    Welcome to the Star Wars API! ver. {APP_VERSION}
    
```

          __
.-.__      \ .-.  ___  __
|_|  '--.-.-(   \/\;;\_\.-._______.-.
(-)___     \ \ .-\ \;;\(   \       \ \
 Y    '---._\_((Q)) \;;\\ .-\     __(_)
 I           __'-' / .--.((Q))---'    \,
 I     ___.-:    \|  |   \'-'_          \
 A  .-'      \ .-.\   \   \ \ '--.__     '\
 |  |____.----((Q))\   \__|--\_      \     '
    ( )        '-'  \_  :  \-' '--.___\
     Y                \  \  \       \(_)
     I                 \  \  \         \,
     I                  \  \  \          \
     A                   \  \  \          '\
     |                    \  \__|           '
                           \_:.  \
                             \ \  \
                              \ \  \
                               \_\_|

"""

    return PlainTextResponse(content=version)
