from fastapi import APIRouter
from fastapi.responses import PlainTextResponse
from app.utils.config import APP_VERSION

router = APIRouter()

@router.get("/")
def root():
    help_text = f"""
    Welcome to the Star Wars API! ver. {APP_VERSION}
To upload a file using curl, run the following command:

    ```
    curl -X POST -H "Authorization: Bearer <your auth token here>" "http://<your_host>:<your_port>/upload" -F "file=@<path_to_your_file>"
    ```
    Example:
    ```
    curl -X POST "https://ddd.darthdataditch.jftr.info/upload" -F "file=@./sample.txt"
    curl -X POST -H "Authorization: Bearer <your auth token here>" http://localhost:8000/upload -F "file=@./sample.txt"
    ```

             ___
          ,-'___'-.
        ,'  [(_)]  '.
       |_]||[][O]o[][|
     _ |_____________| _
    | []   _______   [] |
    | []   _______   [] |
   [| ||      _      || |]     Need help? Only R2-D2 could decode this one!
    |_|| =   [=]     ||_|
    | || =   [|]     || |
    | ||      _      || |
    | ||||   (+)    (|| |
    | ||_____________|| |
    |_| \___________/ |_|
    / \      | |      / \ 
   /___\    /___\    /___\    
"""

    return PlainTextResponse(content=help_text)