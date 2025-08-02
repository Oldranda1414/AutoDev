class Table:
    def __init__(self, headers: list[str], rows: list[list[str]] = []):
        if rows:
            for index, row in enumerate(rows):
                if len(headers) != len(row):
                    raise ValueError(f"Row {index}'s number of items ({len(row)}) is not equal to the table's headers number ({len(headers)}).")

        self.headers = headers
        self.rows = rows

    def add_row(self, row: list[str]):
        if len(row) != len(self.headers):
            raise ValueError(f"The number of items in the provided row ({len(row)}) does not match the number of headers ({len(self.headers)})")
        self.rows.append(row)

