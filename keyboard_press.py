from RPA.Desktop.keywords import LibraryContext
from RPA.Desktop.keywords import KeyboardKeywords
from pynput_robocorp.keyboard import Key, KeyCode



def to_key(key: str, escaped=False):
    """Convert key string to correct enum value."""
    # pylint: disable=C0415
    from pynput_robocorp.keyboard import Key, KeyCode

    if isinstance(key, (Key, KeyCode)):
        return key

    value = str(key).lower().strip()

    # Check for modifier or function key, e.g. ctrl or f4
    try:
        return Key[value]
    except KeyError:
        pass

    # Check for individual character
    if len(value) == 1:
        try:
            return KeyCode.from_char(value, escaped=escaped)
        except ValueError:
            pass

    raise ValueError(f"Invalid key: {key}")

def ebsPressKeys(keys):
    try:
        keyboard = KeyboardKeywords(LibraryContext)
        keys = keys.split('>')
        
        keys = [to_key(key, True) for key in keys]

        for key in keys:
            keyboard._keyboard.press(key)
    
        for key in keys:
            keyboard._keyboard.release(key)
            
    except Exception as e :
        raise Exception('Invalid Key Provided', keys)

		
# ebsPressKeys('alt>f4')
ebsPressKeys('ctrl>f')
ebsPressKeys('ctrl>b')
# ebsPressKeys('cs>fs')