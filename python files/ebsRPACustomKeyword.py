from robot.api.deco import keyword
import win32api as win32
import win32gui as win32gui
import win32con as win32con


@keyword
def is_wait_cursor_complete() :
    bool = 'False'
    while bool == 'False':
        hCursor = win32gui.SetCursor(win32gui.LoadCursor(0, win32con.IDC_WAIT))
        hCursor = win32gui.SetCursor(win32gui.LoadCursor(0, win32con.IDC_ARROW))
        currCur = win32gui.GetCursorInfo()[1]
        if hCursor !=currCur:
            bool = 'True'
        print('Still inside While loop')
    print('Completed While loop')
    
    

# is_wait_cursor_complete()
