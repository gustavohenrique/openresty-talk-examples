# -*- coding: utf-8 -*-
import os
from flask import Flask, Response, request, json, render_template

template_dir = os.path.join(os.path.join(os.path.dirname(__file__)), 'templates')
app = Flask(__name__, template_folder=template_dir)


def response(**kwargs):
    mimetype = kwargs.get('mimetype', 'application/json')
    status = kwargs.get('status', 200)
    resp = Response(None, status=status, mimetype=mimetype)
    result = {
        'data': kwargs.get('data')
    }
    data = json.dumps(result)
    resp.data = data
    return resp


def ok(**kwargs):
    status = kwargs.get('status', 200)
    resp = Response(None, status=status, mimetype='text/html')
    seconds = 5
    resp.headers.add('Cache-Control', 'public,max-age=%d' % seconds)
    resp.data = kwargs.get('message')
    return resp


@app.route("/")
def index():
    return ok(message='Python in 9002')


@app.route('/api/v1', methods=['POST'])
def create():
    try:
        item = json.loads(request.data)
        return response(data={'name': 'Gustavo'})
    except Exception as e:
        return response(status=500, data=str(e))


@app.route('/now', methods=['GET'])
def fetch():
    from datetime import datetime
    now = datetime.now()
    data = now.strftime('%d/%m/%Y %H:%M:%S')
    return ok(message=data)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port='9002')
