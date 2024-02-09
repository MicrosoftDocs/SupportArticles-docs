---
title: Event ID 1053 is logged when you use the gpupdate command
description: Provides a resolution for the issue that Event ID 1053 is logged when you use the Gpupdate /force command, or you restart a domain controller
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, Rajsin
ms.custom: sap:problems-applying-group-policy-objects-to-users-or-computers, csstroubleshoot
---
# Event ID 1053 is logged when you use the Gpupdate /force command, or you restart a domain controller

This article provides a resolution for the issue that Event ID 1053 is logged when you use the `Gpupdate /force` command, or you restart a domain controller.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 937535

## Symptoms

When you use the `Gpupdate /force` command on a Microsoft Windows Server 2003-based domain controller, or you restart a Windows Server 2003-based domain controller, the following error message may be logged in the Application log:  
> Event Type: Error  
 Event Source: Userenv  
 Event Category: None  
 Event ID: 1053  
 Date: **Date**  
 Time: **Time**  
 User: NT AUTHORITY\\SYSTEM  
 Computer: **Computername**  
 Description:  
Windows cannot determine the user or computer name. (Not enough storage is available to complete this operation. ). Group Policy processing aborted. For more information, see [Help and Support Center](https://go.microsoft.com/fwlink/events.asp).  

Additionally, if you enable USERENV logging, the following entries may be logged in the Userenv.log file:  
> USERENV(1b4.eb4) *\<DateTime>* MyGetUserName: GetUserNameEx failed with 14.  
USERENV(1b4.eb4) *\<DateTime>* MyGetUserName: Retrying call to GetUserNameEx in 1/2 second.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

To resolve this problem, add the MaxTokenSize registry entry and the MaxUserPort registry entry on the affected domain controllers. To do this, follow these steps:

1. Click **Start**, click **Run**, type *regedit*, and then click **OK**.
2. Locate and then right-click the following registry subkey:
 `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa\Kerberos\Parameters`
   > [!NOTE]
   > If the **Parameters** key is not available, you must create it. To create the **Parameters** key, follow these steps:
   >
   >1. Click the following registry subkey: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa\Kerberos`  
   >2. On the **Edit** menu, click **New**, and then click **Key**.
   >3. Type *Parameters*, and then press ENTER.

3. Click the **Parameters** key, click **New** on the **Edit** Menu, and then click **DWORD Value**.
4. Type *MaxTokenSize*, and then press ENTER.
5. Right-click **MaxTokenSize**, and then click **Modify**.
6. In the Value data box, type *65535*, click **Decimal**, and then click **OK**.
7. Locate and then right-click the following registry subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters`

8. On the **Edit** menu, click **New**, click **DWORD Value**, type *MaxUserPort*, and then press ENTER.
9. In the **Value data** box, type a value between 5000 and 65534, click **Decimal**, and then click **OK**.

    > [!NOTE]
    > The default value for the MaxUserPort registry entry is 5000.
10. Exit Registry Editor.
11. Restart the computer.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Group Policy issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-group-policy.md).
