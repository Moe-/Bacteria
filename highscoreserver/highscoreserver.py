__author__ = 'rene'

import SocketServer
import sqlite3
import re
class HighScoreServer(SocketServer.BaseRequestHandler):

    def processScore(self, params):
        print params
        match = re.search('^"([^"]*)",(\d*)$', params)
        if match:
            user = match.group(1)
            score = match.group(2)
            global db
            c = db.cursor()
            c.execute("Insert INTO highscores values (?, ?)", (user, score))
            db.commit()


    def processGetList(self, params):
        print "GetList"
        global db
        c = db.cursor()
        count = 0
        answer = ""
        for row in c.execute("SELECT name, score from highscores order by score DESC LIMIT 10"):
            count = count + 1
            answer = "{}{}|{}|{}&".format(answer, count, row[0], row[1])

        self.socket.sendto(answer, self.client_address)


    def handle(self):

        data = self.request[0].strip()
        self.socket = self.request[1]
        match = re.search('^([^(]*)\(([^)]*)\)$', data)
        if match:
            if match.group(1) == 'sendScore':
                self.processScore(match.group(2))
            elif match.group(1) == 'getScores':
                self.processGetList(match.group(2))


if __name__ == "__main__":

    db = sqlite3.connect('database.db')
    c = db.cursor()
    if c.execute("SELECT name FROM sqlite_master WHERE type='table' AND name='highscores'").fetchone() == None:
        c.execute("CREATE TABLE highscores (name CHAR(20) NOT NULL, score INT NOT NULL)")
    db.commit()

    HOST, PORT = "localhost", 80

    server = SocketServer.UDPServer((HOST, PORT), HighScoreServer)
    server.serve_forever()
