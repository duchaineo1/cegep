import os
from waitress import serve
from flask import Flask

app = Flask(__name__)


@app.route('/', methods=['POST'])
def unlock():
    return "Hello world !"



if __name__ == '__main__':
    port = int(os.environ.get('PORT', 3000))
    serve(app, host='0.0.0.0', port=port)