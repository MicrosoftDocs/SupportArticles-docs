---
title: You receive an "access is denied" error message on a domain controller when you try to replicate the Active Directory directory service
description: Describes a problem that occurs when the value of the RestrictRemoteClients registry entry is 2. Explains how to resolve this problem by modifying the registry or by disabling the Restrictions for Unauthenticated RPC Clients GPO.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-database-issues-and-domain-controller-boot-failures, csstroubleshoot
---
# You receive an "access is denied" error message on a domain controller when you try to replicate the Active Directory directory service

This article helps to fix the error "access is denied" on a domain controller when you try to replicate the Active Directory directory service.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 895085

> [!IMPORTANT]
> This article contains information about modifying the registry. Before you modify the registry, make sure to back it up and make sure that you understand how to restore the registry if a problem occurs. For information about how to back up, restore, and edit the registry, click the following article number to view the article in the Microsoft Knowledge Base: [256986](https://support.microsoft.com/help/256986) Description of the Microsoft Windows Registry  

## Symptoms

When you try to replicate the Active Directory directory service to a domain controller that is running Microsoft Windows Server 2003 with Service Pack 1 (SP1) or an x64-based version of Microsoft Windows Server 2003, you receive the following error message on the destination domain controller:  
>access is denied

## Cause

This problem occurs when the value of the RestrictRemoteClients registry entry is 2.

Windows Server 2003 SP1 and x64-based versions of Windows Server 2003 read remote procedure call (RPC) settings from this entry. If the entry has a value of 2, RPC traffic must be authenticated. Therefore, Active Directory replication does not succeed. Other RPC services on the domain controller may also be affected.

## Resolution

> [!WARNING]
> If you use Registry Editor incorrectly, you may cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that you can solve problems that result from using Registry Editor incorrectly. Use Registry Editor at your own risk.  

To resolve this problem, enable port 135 on Windows Firewall, and then use one of the following methods:

- Set the value of the RestrictRemoteClients registry entry to 0 or 1.
- Disable the Restrictions for Unauthenticated RPC Clients Group Policy object.  

To do this, follow these steps.

> [!NOTE]
> By default, port 135 is blocked in Windows Server 2003 SP1 and in x64-based versions of Windows Server 2003.

1. Click **Start**, click **Run**, type *firewall.cpl*, and then click **OK**.
2. Click the **Exceptions** tab, and then click **Add Port**.
3. In the **Name** box, type a name for the port.

    For example, type *TCP 135*.
4. In the **Port number** box, type *135*.
5. Click **TCP**, and then click **OK**.

    The new port appears on the **Exceptions** tab.
6. Click to select the check box next to the new port, and then click **OK**.
7. Click **Start**, click **Run**, type *regedit*, and then click **OK**.
8. Use one of the following methods:  

- Set the value of the RestrictRemoteClients registry entry to 0 or 1. To do this, follow these steps:

    1. Locate and then click the following registry subkey: `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Rpc`  

    2. In the right pane, click the RestrictRemoteClients entry.

          > [!NOTE]
          > If this entry does not exist, follow these steps:  
          >
          > 1. On the **Edit** menu, point to **New**, and then click **DWORD Value**.  
          > 2. Type *RestrictRemoteClients* , and then press ENTER.  

    3. On the **Edit** menu, click **Modify**.
    4. In the **Value data** box, type 0 or 1, and then click **OK**.
    5. Quit Registry Editor.  

- Use Group Policy Object Editor to disable the Restrictions for Unauthenticated RPC Clients Group Policy object. To do this, follow these steps:

    1. Click **Start**, click **Run**, type **gpedit.msc**, and then click **OK**.
    2. In the console tree, double-click **Computer Configuration**, double-click **Administrative Templates**, double-click **System**, and then click **Remote Procedure Call**.
    3. Double-click **Restrictions for Unauthenticated RPC clients**, click **Disable**, and then click **OK**.
    4. Quit Group Policy Object Editor.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.  

## More information

For additional information about the RestrictRemoteClients registry entry, visit the following Microsoft Web site: [RestrictRemoteClients registry key is enabled](https://technet.microsoft.com/library/209d02c4-877c-4128-8e22-30bcd4aae6d3.aspx)  

## Technical support for Windows x64 editions

Your hardware manufacturer provides technical support and assistance for Microsoft Windows x64 editions. Your hardware manufacturer provides support because a Windows x64 edition was included with your hardware. Your hardware manufacturer might have customized the Windows x64 edition installation with unique components. Unique components might include specific device drivers or might include optional settings to maximize the performance of the hardware. Microsoft will provide reasonable-effort assistance if you need technical help with your Windows x64 edition. However, you might have to contact your manufacturer directly. Your manufacturer is best qualified to support the software that your manufacturer installed on the hardware.
