import os
import flask

app = flask.Flask(__name__)

@app.route("/run")
def run():
    # Dangerous: directly injecting user input into a shell command
    command = flask.request.args.get("command")
    os.system("echo " + command)
