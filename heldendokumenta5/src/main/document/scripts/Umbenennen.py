#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Dieses Script von Michael Binder <mb@thinkingstone.de> ist unter einer Creative Commons Lizenz vom Typ Namensnennung - Weitergabe unter gleichen Bedingungen 3.0 Deutschland zugänglich. Um eine Kopie dieser Lizenz einzusehen, konsultieren Sie http://creativecommons.org/licenses/by-sa/3.0/de/ oder wenden Sie sich brieflich an Creative Commons, 444 Castro Street, Suite 900, Mountain View, California, 94041, USA.

"""Scribus Script

Changes the name of the selected objects. """

try:
    import scribus
except ImportError:
    print "This script can only be run as an extension script from Scribus"
    sys.exit(1) 

# check opened document
if not scribus.haveDoc():
       scribus.messageBox('Scribus - Script Error', "No document open", scribus.ICON_WARNING, scribus.BUTTON_OK)
       sys.exit(1)

scribus.setRedraw(False)

defaultnewname = "blub_<idx0>_bla_<idx1>"
newname = scribus.valueDialog("New Name", "Define the new name.\n\nThe String <idx0> and <idx1> will be replaced by the current index and the current index + 1.", defaultnewname)

selectionCount = scribus.selectionCount()
# str('Selected: ' + str(selectionCount))

selected = []

for index in range(0, selectionCount):
  # str(index)
  selectedObject = scribus.getSelectedObject(index)
  # str(selectedObject)
  selected.append(selectedObject)
  
scribus.deselectAll()
  
for index, obj in enumerate(selected):
  str(obj)
  scribus.selectObject(obj)
  localnewname = newname.replace("<idx0>", str(index)).replace("<idx1>", str(index + 1)).replace("<idx23>", str(index + 23)).replace("<idx35>", str(index + 35))
  # scribus.setText(localnewname, obj)
  scribus.setNewName(localnewname, obj)
  scribus.deselectAll()
 
scribus.setRedraw(True)
scribus.docChanged(True)