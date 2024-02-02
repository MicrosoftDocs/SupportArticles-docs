---
title: Not enough storage is available
description: Describes a problem that occurs when you try to join a client computer to a domain. Event ID 6 is logged in the System log on the client computer.
ms.date: 10/09/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika, okang
ms.custom: sap:kerberos-authentication, csstroubleshoot
ms.subservice: windows-security
---
# "Not enough storage is available to complete this operation" error message when you use a domain controller to join a computer to a domain

This article provides a resolution for the error "Not enough storage is available to complete this operation", when you use a domain controller to join a computer to a domain.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 935744

## Symptoms

When you use a Microsoft Windows Server 2003 or later version domain controller to join a Microsoft Windows XP or later version client computer to a domain, you may receive an error message that resembles the following on the client computer:
>The following error occurred attempting to join the domain "**domain_name.com**": Not enough storage is available to complete this operation.  

Additionally, the following Warning message may be logged in the System log on the client computer:

## Cause

This problem occurs because the Kerberos token that is generated during authentication is more than the fixed maximum size. In the original release version of Microsoft Windows 2000, the default value of the MaxTokenSize registry entry was 8,000 bytes. In Windows 2000 with Service Pack 2 (SP2) and in later versions of Windows, the default value of the MaxTokenSize registry entry is 12,000 bytes.

For example, if a user is a member of a group either directly or by membership in another group, the security ID (SID) for that group is added to the user's token. For a SID to be added to the user's token, the SID information must be communicated by using the Kerberos token. If the required SID information exceeds the size of the token, authentication is unsuccessful.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

To resolve this problem, increase the Kerberos token size. Follow these steps on the client computer that logs the Kerberos event.  

1. Click **Start**, click **Run**, type regedit, and then click **OK**.
2. Locate and then click the following registry subkey:  `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\Kerberos\Parameters`  

    > [!NOTE]
    > If the **Parameters** key is not present, create the key. To do this, follow these steps:  
     >
     > 1. Locate and then click the following registry subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\Kerberos`  
     >2. On the **Edit** menu, point to **New**, and then click **Key**.
     >3. Type Parameters , and then press ENTER.  

3. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
4. Type MaxTokenSize, and then press ENTER.
5. On the **Edit** menu, click **Modify**.
6. In the **Base** area, click **Decimal**, type 65535 in the **Value data** box, and then click **OK**.

    > [!NOTE]
    > The default value for the MaxTokenSize registry entry is a decimal value of 12,000. We recommend that you set this registry entry value to a decimal value of 65,535. If you incorrectly set this registry entry value to a hexadecimal value of 65,535, Kerberos authentication operations may fail. Additionally, programs may return errors.

7. Exit Registry Editor.
8. Restart the computer.

## More information

For more information, click the following article numbers to view the articles in the Microsoft Knowledge Base:  

[327825](https://support.microsoft.com/help/327825) New resolution for problems with Kerberos authentication when users belong to many groups  
