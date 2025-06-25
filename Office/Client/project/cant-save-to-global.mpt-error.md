---
title: Cannot save to Global.mpt error when exiting Microsoft Project
description: Fixes an error that occurs when you exit Project together with Global.mpt template is opened as read-only.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: andyra
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Microsoft Office Project Professional 2003
  - Microsoft Office Project Standard 2003
  - Project Professional 2010
  - Project Standard 2010
  - Project Professional 2013
  - Project 2013 Standard
ms.date: 05/26/2025
---

# "Cannot save to Global.mpt" when exiting Microsoft Project

## Symptoms

When you exit Microsoft Project while the Global.mpt template is opened as read-only, you receive the following error message:

> Cannot save to 'Global.mpt'. This is a read-only file. You can view and copy information but you cannot save changes to this file under its current name. If you want to save changes to the file, choose Save As and rename the file.

## Cause

This error message occurs when the Global.mpt file that Microsoft Project is using is read-only and when you've changed formatting options or macros.

Note This file is a template. It does not contain any data from the project that you are working on.

## Workaround

If you have changed formatting options (views, tables, filters, group, reports) or macros, then save the file as Global.mpt to a folder where you have read-write permissions. If you do not want to save any changes, click Cancel in the dialog box. This does not cause loss of project data.

## More information

The Global.mpt file has read-only permissions when any of the following conditions are true:

- The Global.mpt file is stored on a network share where another user is using the file.
- The Global.mpt file is stored in a read-only network location.
- The Global.mpt file is read-only.

Project searches for the Global.mpt file in the following locations:

- The current folder

  If the user has a shortcut that specifies the "Start In" folder, and if a Global.mpt file resides there, Project opens that Global.mpt file. If the user double-clicks a project in Windows Explorer when Project is not already open, Project uses the Global.mpt file if it is saved in that particular folder.

- The user's profile folder

  Project looks in the "Application Data" folder under the user's profile. For example, on a computer that is running Microsoft Windows 98 with User Profiles turned on, this location is as follows:

  > \Users\Username\Application Data\Microsoft\MS Project

- The user's profile language folder

  This folder is the language ID subfolder in the "Application Data" folder for the user profile. For example, on a computer that is running Windows 98 with User Profiles turned on, this folder is typically found in the following location if the user's language is English:

  > \Users\Username\Application Data\Microsoft\MS Project\1033

- The folder where the Winproj.exe file is located

  By default, the Project application is installed in the following folder:

  > \program files\Microsoft Office\Office

- The Winproj.exe language folder

  By default, this folder is found in the following location:

  > \program files\Microsoft Office\Office\1033

  If Project opens the Global.mpt file from this location, Project does not save changes to this copy. Instead, Project saves them to the profile language folder. By default, Project opens the Global.mpt file from this location the first-time Project is started.

- If the Global file is not found in any of these locations, Windows Installer starts and tries to restore a copy to the Winproj.exe language folder.

- If Windows Installer is unable to restore a copy of the Global.mpt file, Project displays a message that states that it will create a new Global.mpt file that may be missing some items.
