const onCreateDatabase = [
  """create table if not EXISTS drink_history (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	date DATETIME not NULL,
    amount NUMERIC not NULL,
    type INTEGER not NULL
);"""
];
