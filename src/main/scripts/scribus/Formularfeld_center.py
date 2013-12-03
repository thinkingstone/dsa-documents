#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Dieses Script von Michael Binder <mb@thinkingstone.de> ist unter einer Creative Commons Lizenz vom Typ Namensnennung - Weitergabe unter gleichen Bedingungen 3.0 Deutschland zugänglich. Um eine Kopie dieser Lizenz einzusehen, konsultieren Sie http://creativecommons.org/licenses/by-sa/3.0/de/ oder wenden Sie sich brieflich an Creative Commons, 444 Castro Street, Suite 900, Mountain View, California, 94041, USA.

"""Scribus Script

Changes the paragraph style of each selected object to "Formularfeld_center". """

style = "Formularfeld_center"

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

selectionCount = scribus.selectionCount()
# str('Selected: ' + str(selectionCount))

selected = []

# remember all selected objects
for index in range(0, selectionCount):
  # str(index)
  selectedObject = scribus.getSelectedObject(index)
  # str(selectedObject)
  selected.append(selectedObject)

scribus.deselectAll()
 
# change style for each selected object
for obj in selected:
   # str(obj)
   scribus.selectObject(obj)
   scribus.selectText(0, scribus.getTextLength(obj), obj)
   scribus.setStyle(style, obj)
   scribus.deselectAll()
 
scribus.setRedraw(True)
scribus.docChanged(True)