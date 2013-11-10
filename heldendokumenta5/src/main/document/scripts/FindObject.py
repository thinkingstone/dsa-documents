#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Dieses Script von Michael Binder <mb@thinkingstone.de> ist unter einer Creative Commons Lizenz vom Typ Namensnennung - Weitergabe unter gleichen Bedingungen 3.0 Deutschland zugänglich. Um eine Kopie dieser Lizenz einzusehen, konsultieren Sie http://creativecommons.org/licenses/by-sa/3.0/de/ oder wenden Sie sich brieflich an Creative Commons, 444 Castro Street, Suite 900, Mountain View, California, 94041, USA.

"""Scribus Script

This script searches for a named object and marks the finding in yellow. """

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

defaultsearchfor = ""
searchfor = scribus.valueDialog("Search", "Search for this object.\nThe color of the found object will be changed to yellow.\n\nName:", defaultsearchfor)

scribus.deselectAll()
scribus.selectObject(searchfor)
scribus.setFillColor("Yellow", searchfor)
 
scribus.setRedraw(True)
scribus.docChanged(True)