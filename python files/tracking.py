# import pygetwindow as gw

# arr = gw.getAllTitles()

# print(arr)

from cgitb import text
from pyjab.jabdriver import JABDriver

driver = JABDriver("Oracle Applications - EBSVIS")

entry = driver.find_elements_by_xpath("//text[@name=contains('PO Number')")

print(entry)
print("clicking clear")
clearBtn = driver.find_element_by_xpath("//push button[@name=contains('Tax Details')]")
# clearBtn.click()
# print("entering requisition number")
# driver.
# print("clicking findbtn")
# findBtn = driver.find_element_by_xpath("//push button[@name=contains('Find')")