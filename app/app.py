from flask import Flask
from flask import jsonify
import glob

app = Flask(__name__)

# list all public keys in the app folder
@app.route('/')
def keys():
    output = dict()
    for file in list(glob.glob("**/*.pub")): 
        output[file] =  open(file, 'r').readline().rstrip()
    return jsonify(output)

# confirm the app is online
@app.route('/healthcheck')
def health_check():
    return jsonify({'status': 'OK'})

if __name__ == '__main__':
    app.run('0.0.0.0', 80)
