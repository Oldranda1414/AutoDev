from datetime import datetime
import os
import re

class Logger:
    def __init__(self, filename):
        os.makedirs(os.path.dirname(filename), exist_ok=True)
        self.file = open(filename, 'a')
        self.empty_line_regex = re.compile(r'^[\s^]*$')  # Matches whitespace/^ chars

    def write(self, message):
        # Skip empty lines and terminal control chars
        if not self.empty_line_regex.match(message):
            timestamp = datetime.now().strftime('[%Y-%m-%d %H:%M:%S]')
            self.file.write(f"{timestamp} {message}")
            self.file.flush()

    def flush(self):
        self.file.flush()

