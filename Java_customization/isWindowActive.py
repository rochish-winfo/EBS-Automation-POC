from RPA.Desktop import Desktop
import pygetwindow as pg
desktop = Desktop()
import time

start_time = time.time()
def _wait_until_popup(name):
    isFound = False
    st = time.time()
    while not isFound :
        windows = pg.getAllTitles()
        for window in windows :
            if name in window:
                print(window)
                isFound = True
                if name == 'Downloads' and isFound:
                    desktop.press_keys('ctrl', 'w')
                return
        
        if name =='Security Warning' and not isFound:
            print('Pressing Enter')

            desktop.press_keys('enter')
            time.sleep(2)
            

        if time.time() - st > 60 :
            print("winodw did not appear")
            return 


_wait_until_popup('Downloads')


end_time = time.time()
print(f"it took {int(end_time - start_time)} seconds")

def setResponse(scriptParamId, message, success, copy = None):
    response['scriptParamId'] = scriptParamId
    response['message'] = message
    response['success'] = success
    response['result'] = copy
	if response['result'] is not None:
	    print("The response from copied --->",response)
