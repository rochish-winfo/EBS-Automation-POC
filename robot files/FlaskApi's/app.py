import os
from flask import Flask, request, json  # import flask
app = Flask(__name__)             # create an app instance


def get_file_status(path):
    try:
        f = open(f"{path}\\Result\\result.txt", "r")
        text = f.read()
        print("Printint Text From Result File ",text)
        f.close()
        arr = text.split(',')
        dict_ = {}
        for _ in arr:
            dict_[_.split('=')[0]] = _.split('=')[-1]

        return json.dumps(dict_)
    except :
        return json.dumps({"status" : "api failed"})


@app.route("/startebsrobot", methods=['POST'])      # at the end point /
def startebsrobot():
    from subprocess import call
    import pandas as pd

    data = json.loads(request.data, strict=False)
    inputData = pd.DataFrame(data["Data"])
    print(data, inputData)
    sub = inputData.loc[inputData.index[0],'SUBJECT']  #invoiceDesktop
    path = inputData.loc[inputData.index[0],'PATH']
    try:
        os.remove(f"{path}\\Result\\result.txt")
        print("result file removed")
    except:
        pass
    args = "C:\\EBS-Automation\\EBS Automation-POC\\robot files\\"+sub+".robot"
    print(args)
    call(["robot",args])
    print(path)
    return get_file_status(path)
    # return  "api call success"

if __name__ == "__main__":        # on running python app.py
    app.run(host="localhost", port=8000, debug=True)                 # run the flask app

