import bcrypt
from fastapi import Depends, HTTPException, Security
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from app.utils.config import USER_TOKENS

security = HTTPBearer()

def get_current_user(authorization: HTTPAuthorizationCredentials = Depends(security)):
    token = authorization.credentials 
    for user, hashed_token in USER_TOKENS.items():
        if bcrypt.checkpw(token.encode('utf-8'), hashed_token.encode('utf-8')):
            return user

    raise HTTPException(status_code=401, detail="Invalid or expired token")
