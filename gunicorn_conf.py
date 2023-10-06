import signal
import os

def handle_sigint(sig, frame):
    os.kill(os.getpid(), signal.SIGQUIT)

signal.signal(signal.SIGINT, handle_sigint)