---
title: Cannot change recent places
description: Describes an issue where you cannot change the number of places to list in Recent Places in Word 2010, in Excel 2010, or in PowerPoint 2010.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: kemille
appliesto: 
  - Word 2010
  - Excel 2010
  - PowerPoint 2010
ms.date: 03/31/2022
---

# Cannot change the number of places to list in Recent Places in Word 2010, in Excel 2010, or in PowerPoint 2010

## Symptoms

When you view the list of Recent Places in Backstage view in Microsoft Word 2010, in Microsoft Excel 2010, or in Microsoft PowerPoint 2010, you cannot change the number of places to list in Recent Places.

**Note** To access Backstage view, click the **File** tab.

## Workaround

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To work around this issue, you must change the registry to indicate the number of places to list in Recent Places.

To do this, follow these steps:

1. Exit all Office programs.   
2. Click **Start**, click **Run**, type regedit, and then click **OK**.   
3. Locate and then click to select one of the following registry subkeys:     

    **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Word\Place MRU**

    **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Excel\Place MRU**

    **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\PowerPoint\Place MRU**

4. After you select the subkey that is specified in step 3, right-click **Max Display**, and then click **Modify**.   
5. Click **Decimal**, and in the **Value data** box, type a number to represent the number of places that you want to list in Recent Places, and then click **OK**.

    Note By default, **Max Display** is set to 25.   
6. Repeat steps 3 through 5 for each Office program for which you want to change the number of places that you want to list in Recent Places.   
7. On the **File** menu, click **Exit** to exit Registry Editor.   

### Did this fix the problem?

Check whether the problem is fixed. If the problem is fixed, you are finished with this section. If the problem is not fixed, you can [contact support](https://support.microsoft.com/contactus).   


## More Information

For more information about Backstage view, see [Changes in Word 2010](https://technet.microsoft.com/library/cc179199.aspx).
