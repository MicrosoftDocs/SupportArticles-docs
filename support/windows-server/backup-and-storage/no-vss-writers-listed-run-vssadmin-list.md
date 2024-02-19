---
title: No VSS writers are listed
description: Provides a resolution for the issue that no VSS writers are listed when you run vssadmin list writers.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:volume-shadow-copy-service-vss, csstroubleshoot
---
# No VSS writers are listed when you run vssadmin list writers

This article provides a resolution for the issue that no VSS writers are listed when you run vssadmin list writers.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2009533

## Symptoms

When you run vssadmin list writers on Windows Server 2008, no VSS writers are listed.  
In the Application event log, the following events are logged:  

>Log Name: Application  
Source: VSS  
Event ID: 34  
Level: Error  
Description:  
Volume Shadow Copy Service error: The VSS event class is not registered.  This will prevent any VSS writers from receiving events.  This may be caused due to a setup failure or as a result of an application's installer or uninstaller.  
>
>Log Name: Application  
Source: VSS  
Event ID: 8193  
Level: Error  
Description:  
Volume Shadow Copy Service error: Unexpected error calling routine CoCreateInstance.  hr = 0x80040154.  
>
>Log Name: Application  
Source: VSS  
Event ID: 13  
Level: Error  
Description:  
Volume Shadow Copy Service information: The COM Server with CLSID {faf53cc4-bd73-4e36-83f1-2b23f46e513e} and name  
VSSEvent cannot be started. [0x80070057]  
Log Name: Application  
Source: VSS  
Event ID: 8193  
Level: Error  
Description:  
Volume Shadow Copy Service error: Unexpected error calling routine CoCreateInstance.  hr = 0x80070057.  

If you open the Windows Server Backup snap-in, the following error occurs:  

>A fatal error occurred during a Windows Server Backup snap-in operation.  
Error details:  
Catastrophic failure.  
Close Windows Server Backup and then restart it.  

## Cause

This issue occurs because the registry path to Eventcls.dll is incorrect or because the registry data type for the TypeLib setting is incorrect.

## Resolution

To resolve this issue, perform the following steps.  

>[!Important]
>This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[322756](https://support.microsoft.com/kb/322756/)   How to back up and restore the registry in Windows  

1. Click Start, type regedit in the Start Search box, and then press ENTER.  
2. Locate and then click the following registry key:  
 `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\EventSystem\{26c409cc-ae86-11d1-b616-00805fc79216}\EventClasses\{FAF53CC4-BD73-4E36-83F1-2B23F46E513E}-{00000000-0000-0000-0000-000000000000}-{00000000-0000-0000-0000-000000000000}`  
3. Locate the **TypeLib** registry value.  

>[!NOTE]
>The registry type of **TypeLib** should be shown as **REG_EXPAND_SZ**. If that is not the case, you have to delete the key, and then you have to recreate the key. To do this, follow these two steps:  
>a. Select the **TypeLib** registry value, and then delete it.
>
>b. Create a new **Expandable String Value**, and then name it **TypeLib**.  

4. Double-click the **TypeLib** registry value. In the Value Data box, type **%systemroot%\system32\EVENTCLS.DLL**, and then click OK.  
5. Close Regedit.  
6. Click Start, type services.msc in the Start Search box, and hit Enter.  
7. Right-click the following services one at a time and click Restart:  

- COM+ Event System  
- Volume Shadow Copy  

8. Close the Services snap-in.  
9. Open an elevated command prompt, type **vssadmin list writers**, and then hit ENTER.  
10. Verify that the VSS writers are now listed.
