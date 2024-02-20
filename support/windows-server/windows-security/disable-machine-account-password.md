---
title: Disable machine account password changes
description: Describes how an administrator can disable automatic machine account password changes.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, davidg
ms.custom: sap:legacy-authentication-ntlm, csstroubleshoot
---
# How to disable automatic machine account password changes

This article describes how an administrator can disable automatic machine account password changes.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 154501

## Summary

Machine account passwords are regularly changed for security purposes. By default, on Windows NT-based computers, the machine account password automatically changes every seven days. Starting with Windows 2000-based computers, the machine account password automatically changes every 30 days.

> [!WARNING]
> If you disable machine account password changes, there are security risks because the security channel is used for pass-through authentication. If someone discovers a password, he or she can potentially perform pass-through authentication to the domain controller.

## More information

You may want to disable the default automatic machine account password changes for any one of the following reasons:

- You want to reduce replication occurrences. As a side effect of automatic machine account password changes, a domain with many client computers and domain controllers can cause replication to occur on a frequent basis. You can disable automatic machine account password changes to reduce replication occurrences.

- You have two separate installations of Windows NT or Windows 2000 on the same computer in a dual-boot configuration. In this case, the only way to share the same machine account between the two installations of Windows NT or Windows 2000 is to use the default machine account password that is created when you join the domain.

- If you frequently do a clean installation of Windows NT or Windows 2000, you must have an administrator on the domain that can create the machine account on the domain. If that is a problem, you can leave the password of the machine account as the default.

You can disable the machine account password changes on a workstation by setting the **DisablePasswordChange** registry entry to a value of **1**. To do so, follow these steps.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

1. Start **Registry Editor**. To do so, select **Start**, select **Run**, type *regedit* in the **Open** box, and then select **OK**.
2. Locate and then select the following registry subkey:
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters`

3. In the right pane, select the **DisablePasswordChange** entry.
4. On the **Edit** menu, select **Modify**.
5. In the **Value data** box, type a value of **1**, and then select **OK**.
6. Quit **Registry Editor**.

In Windows NT version 4.0 and Windows 2000, Windows Server 2003, Windows Server 2008, and Windows Server 2008 R2, you can disable the machine account password change by setting the **RefusePasswordChange** registry entry to a value of **1** on all domain controllers in the domain instead of on all workstations. To do so, follow these steps.

> [!NOTE]
> On Windows NT 4.0 domain controllers, you must change the **RefusePasswordChange** registry entry to a value of **1** on all backup domain controllers (BDCs) in the domain before you make the change on the primary domain controller (PDC). Failure to follow this order will cause event ID 5722 to be logged in the event log of the PDC.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

1. Start Registry Editor. To do so, select **Start**, select **Run**, type regedit in the **Open** box, and then select **OK**.
2. Locate and then select the following registry subkey:
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters`

3. On the **Edit** menu, point to **New**, and then select **DWORD Value**.
4. Type RefusePasswordChange as the registry entry name, and then press **ENTER**.
5. On the **Edit** menu, select **Modify**.
6. In the **Value data** box, type a value of 1, and then select **OK**.
7. Quit Registry Editor.

> [!NOTE]
> The **RefusePasswordChange** registry entry causes the domain controller to refuse password change requests only from workstations or member servers that run Windows NT version 4.0 or later.

If you set the **RefusePasswordChange** registry entry to a value of **1**, after the workstation or member server first tries to change its machine account password, future attempts to change the password are prevented (by returning a distinct status code). A Windows NT 4.0-based computer will try to change its machine account password again in seven days, and a Windows 2000-based computer will try again in 30 days. If you set the **RefusePasswordChange** registry entry to a value of **1**, the replication traffic will stop, but not the client traffic. If you set the **DisablePasswordChange** registry entry to a value of **1**, both client and replication traffic will stop.

If you disable automatic machine account password changes, you can set up two (or more) installations of Windows NT or Windows 2000 on the same computer that use the same machine account. Another possible use for this facility is virtual guests where you bring back older snapshots or disk images and you want to avoid having to rejoin the machine to a domain.
