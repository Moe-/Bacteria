__author__ = 'rene'

import SocketServer
import sqlite3
import re
class HighScoreServer(SocketServer.BaseRequestHandler):

    def processScore(self, params):
        print "Processing Score"
        print params
        match = re.search('^"([^"]*)",(\d*)$', params)
        if match:
            user = match.group(1)
            score = match.group(2)
            global db
            c = db.cursor()
            c.execute("Insert INTO highscores values (?, ?)", (user, score))
            db.commit()
        print self.socket

    def processGetList(self, params):
        print "Get List"

    def handle(self):

        data = self.request[0].strip()
        self.socket = self.request[1]
        match = re.search('^([^(]*)\(([^)]*)\)$', data)
        if match:
            if match.group(1) == 'sendScore':
                self.processScore(match.group(2))
            if match.group(2) == 'getList':
                self.processScore(match.group(2))


if __name__ == "__main__":

    db = sqlite3.connect('database.db')
    c = db.cursor()
    if c.execute("SELECT name FROM sqlite_master WHERE type='table' AND name='highscores'").fetchone() != None:
        print "Ja"
    else:
        c.execute("CREATE TABLE highscores (name CHAR(20) NOT NULL, score INT NOT NULL)")
    db.commit()

    HOST, PORT = "localhost", 9999

    server = SocketServer.UDPServer((HOST, PORT), HighScoreServer)
    server.serve_forever()
