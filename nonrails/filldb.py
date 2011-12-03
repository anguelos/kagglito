#!/usr/bin/env  python
import sqlite3
import sys
if len(sys.argv)==1:
	sqlfname='./db/development.sqlite3'
	datasetfname='../hdibco2010.zip'

con=sqlite3.connect(sqlfname)
cur=con.cursor();
emails=['admin1@example.com','admin2@example.com','admin3@example.com','user1@example.com','user2@example.com','user3@example.com']
isadmin=[1,1,1,0,0,0]
for k in range(6):
	cur.execute('INSERT INTO users(email,isadmin,password) VALUES("'+str(emails[k])+'",	'+str(isadmin[k])+',"secret");')
	con.commit()
cur.close()
