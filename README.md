# EBS-Automation-POC


<p> This project is using robot framework and WATS to automate oracle ebs instance </p>
<h1> Set Up </h1>

<p> To set up environment clone the repository (install python 3.9.1 or greater)
<ol>
<li><b> pip install virtualenv </b></li> 
<li><b> py -m venv rpaenv </b></li>
<li><b> pip install -r requirements </b></li>
<li><b> rpaenv\Scripts\activate  (To activate the virtual env) </b> (skip step 1, 2 and 4 to use default python)</li>
</ol>
</p>


<h2> Changes to Make To Use The Locators </h2>
<h3> RPA.JavaAccessBridge.py </h3>
change the "role:" --> "role|", "name:" --> "name|" and cond.split(":", 1) --> cond.split("|", 1),

index and len(elements) > (index + 1)   -->    index and len(elements) < (index + 1)
(add time.sleep(3) just before the above line)

"""self.desktop.press_keys("ctrl", "a") --> """self.desktop.press_keys("ctrl", "a")
    self.desktop.press_keys("delete")"""    self.desktop.press_keys("ctrl","shift","right")
                                            self.desktop.press_keys("ctrl","shift","right")
                                            self.desktop.press_keys("delete")"""

