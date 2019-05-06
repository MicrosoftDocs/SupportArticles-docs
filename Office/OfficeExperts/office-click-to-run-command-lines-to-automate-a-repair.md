---
title: Click-to-Run command to automate an online repair in Office 2013
description: The June 2014 release (build 15.0.4623.1003 and later versions) of Office Click-to-Run from Office 365 allows you to automate both a quick and online repair of Office 2013.
author: MaryQiu1987
manager: ericspli
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: ericspli
---

# Use Office Click-to-Run command lines to automate a Quick and Online repair in Office 2013

## Summary

The June 2014 release (build **15.0.4623.1003** and later versions) of Office Click-to-Run from Office 365 lets you automate both a quick and online repair of Office 2013.

## More Information

**OfficeClicktoRun.exe** is the executable that lets you automate a repair in Office 2013. This executable lives in one of the following locations based on the version of the Operating System:

- 64-bit OS: C:\Program Files\Microsoft Office 15\ClientX64
- 32-bit OS: C:\Program Files\Microsoft Office 15\ClientX86

Here is the list of variables that can be used with OfficeClickToRun.exe:

|Variable    |Possible values    |Description|
|----------|-----------|------------|
|scenario     |Repair       |This is mandatory.        |
|platform|x86 / x64   |You have to specify the platform version of Office. **x86** is for the 32-bit version of Office. **x64** is for the 64-bit version of Office. This variable is mandatory.|
|culture|*ll-cc*   |You have to specify the language identifier for the version of Office that is installed. If multiple languages are installed, just specify one of the languages and not all. For example, if English version of Office is installed the *ll-cc* value is en-us. See [here](https://technet.microsoft.com/en-us/library/cc179219%28v=office.15%29.aspx#BKMK_LanguageIdentifiers) for the full list of Office language identifiers. This variable is mandatory. |
|forceappshutdown|True / False   |If *forceappshutodwn* value is set to **True**, all Office applications are closed before you run the repair. If Office applications are open and if *forceappshutodwn* is not used or is set to **False**, the repair fails. This variable is optional.  |
|RepairType|QuickRepair / FullRepair   |This specifies if the user runs a Quick repair (**QuickRepair**) or an Online repair (**FullRepair**). **Note** If you run an Online repair, all Office applications are reinstalled and override any settings made in the configuration.xml file. This variable is optional.   |
|DisplayLevel|True /  False   |Setting the *DisplayLevel* value to **True** shows a full UI and setting it to **False** makes the UI silent. This variable is optional. |

For example, to do a silent Online repair, run the following command from an elevated command prompt:

```powershell
"C:\Program Files\Microsoft Office 15\ClientX64\OfficeClickToRun.exe" scenario=Repair platform=x86 culture=en-us RepairType=FullRepair DisplayLevel=False
```

## Reference

For more information about the build versions of Office 2013 Click-to-Run, see [Update history for Office 2013](https://docs.microsoft.com/officeupdates/update-history-office-2013?redirectSourcePath=%252farticle%252fupdate-history-for-office-2013-19214f38-85b7-4734-b2f8-a6a598bb0117).