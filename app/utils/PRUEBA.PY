import pyotp, time

secret = "RMWFUK35TQP2EWKAXGQWY6EOQA27BUGB"
totp = pyotp.TOTP(secret)
ahora = time.time()

print(f"Código actual: {totp.now()}")


codigos_validos = [totp.at(ahora + (i * 30)) for i in range(-5, 6)]
print(f"[DEBUG] codigos ventana : {codigos_validos}")
