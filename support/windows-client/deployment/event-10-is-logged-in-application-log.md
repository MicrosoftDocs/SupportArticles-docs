---
title: Event ID 10 is logged in Application log
description: Event ID 10 is logged after you install Service Pack 1 for Windows 7 or Windows Server 2008 R2. Provides a resolution.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, jamirc
ms.custom: sap:setup, csstroubleshoot
---
# Event ID 10 is logged in the Application log after you install Service Pack 1 for Windows 7 or Windows Server 2008 R2

This article provides a script to solve the event ID 10 that's logged after you install Service Pack 1 for Windows 7 or Windows Server 2008 R2.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2545227

## Symptoms

After you install Windows 7 Service Pack 1 (SP1) or Windows Server 2008 R2 SP1 using integrated media, the following WMI error is logged in the application log after every reboot:

```output
Log Name - Application  
Source - WMI  
EventID - 10  
Level - Error  
User - N/A  
OpCode - Info  
Task Cat - None  
Keywords - Classic  
Details - Event filter with query "SELECT * FROM __InstanceModificationEvent WITHIN 60 WHERE TargetInstance ISA "Win32_Processor" AND TargetInstance.LoadPercentage > 99" could not be reactivated in namespace "//./root/CIMV2" because of error 0x80041003. Events cannot be delivered through this filter until the problem is corrected.
```

## Cause

This issue originated in the Windows 7 SP1 DVD/ISO creation process. There was an issue in the creation process that caused a WMI registration to remain in the DVD/ISO. Since the registration is designed to work only during the DVD/ISO creation process, it fails to run on a live system and causes these events. These events aren't indicative of any issue in the system and can be safely ignored. If you want to prevent these events from getting generated and want to remove this specific WMI registration manually, run the workaround script.

## Resolution

To resolve the issue, run a script to stop the Event ID 10 messages. To run the script, follow these steps:

1. In Notepad, create a new document named *Workaround.txt*.
2. Copy the following script into notepad:

    ```vb
    strComputer = "."
    Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" _
    & strComputer & "\root\subscription")
    Set obj1 = objWMIService.ExecQuery("select * from __eventfilter where name='BVTFilter' and query='SELECT * FROM __InstanceModificationEvent WITHIN 60 WHERE TargetInstance ISA ""Win32_Processor"" AND TargetInstance.LoadPercentage > 99'")
    For Each obj1elem in obj1
    set obj2set = obj1elem.Associators_("__FilterToConsumerBinding")
    set obj3set = obj1elem.References_("__FilterToConsumerBinding")
    For each obj2 in obj2set
    WScript.echo "Deleting the object"
    WScript.echo obj2.GetObjectText_
    obj2.Delete_
    next
    For each obj3 in obj3set
    WScript.echo "Deleting the object"
    WScript.echo obj3.GetObjectText_
    obj3.Delete_
    next
    WScript.echo "Deleting the object"
    WScript.echo obj1elem.GetObjectText_
    obj1elem.Delete_
    Next
    ```

3. Save the text as *Workaround.vbs*.
4. Close Notepad.
5. Open an elevated command prompt:

    1. Select **Start**.
    2. Select **Programs**.
    3. Right-click on **Command Prompt**.
    4. Choose **run as administrator**.
6. Change Directory to the one containing *workaround.vbs*, for example, `CD c:\users\%username%`.

7. Run the script *workaround.vbs*.

After running the script, the Event ID 10 errors related to this event should stop occurring. This script doesn't remove any of the existing entries in the Event log, they would need to be manually cleared out of the application event log.

> [!NOTE]
> There can be other reasons for Event ID 10 error messages. This workaround only prevents the error message listed above from occurring.

## More information

This particular Event ID 10 error message listed above can be safely ignored. It isn't indicative of a problem with the Service Pack or with the operating system.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
