import bcrypt

password = input("Enter the token/password: ").encode('utf-8')
hashed = bcrypt.hashpw(password)
print(hashed.decode('utf-8'))