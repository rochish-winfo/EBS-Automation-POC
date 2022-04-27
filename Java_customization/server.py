import os
from flask import Flask, request, json 
import pandas as pd
app = Flask(__name__) 

response  = {
        "scriptParamId":"",
        "message":"",
        "success": True}

@app.route('/updateScriptParamStatus',methods=['POST'])
def startebs():
    
    return response

if __name__ == "__main__":        # on running python app.py
    app.run(host="localhost", port=8000, debug=True) 