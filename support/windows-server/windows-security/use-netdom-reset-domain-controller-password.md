---
title: Reset domain controller's password with Netdom.exe
description: This article explains how to use Netdom.exe to reset machine account passwords of a domain controller in Windows Server.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:secure-channel-issues, csstroubleshoot
ms.technology: windows-server-security
---
# Use Netdom.exe to reset machine account passwords of a Windows Server domain controller

This step-by-step article describes how to use Netdom.exe to reset machine account passwords of a domain controller in Windows Server.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 325850

## Summary

Each Windows-based computer maintains a machine account password history that contains the current and previous passwords that are used for the account. When two computers try to authenticate with each other and a change to the current password isn't yet received, Windows relies on the previous password. If the sequence of password changes exceeds two changes, the computers involved may not be able to communicate, and you may receive error messages. For example, you receive **Access Denied** error messages when Active Directory replication occurs.

This behavior also applies to replication between domain controllers of the same domain. If the domain controllers that aren't replicating reside in two different domains, look at the trust relationship more closely.

You can't change the machine account password by using the Active Directory Users and Computers snap-in. But you can reset the password by using the Netdom.exe tool. The Netdom.exe tool is included in the Windows Support Tools for Windows Server 2003, in Windows Server 2008 R2, and in Windows Server 2008.

The Netdom.exe tool resets the account password on the computer locally (known as a *local secret*). It writes this change to the computer's computer account object on a Windows domain controller that's in the same domain. Simultaneously writing the new password to both places ensures that at least the two computers involved in the operation are synchronized. And starting Active Directory replication ensures that other domain controllers receive the change.

The following procedure describes how to use the netdom command to reset a machine account password. This procedure is most frequently used on domain controllers, but also applies to any Windows machine account.

You must run the tool locally from the Windows-based computer whose password you want to change. Additionally, you must have administrative permissions locally and on the computer account's object in Active Directory to run Netdom.exe.

## Use Netdom.exe to reset a machine account password

1. Install the Windows Server 2003 Support Tools on the domain controller whose password you want to reset. These tools are located in the `Support\Tools` folder on the Windows Server 2003 CD-ROM. To install these tools, right-click the Suptools.msi file in the `Support\Tools` folder, and then select **Install**.

    > [!NOTE]
    > This step is not necessary in Windows Server 2008, Windows Server 2008 R2, or a later version because the Netdom.exe tool is included in these Windows editions.

2. If you want to reset the password for a Windows domain controller, you must stop the Kerberos Key Distribution Center service and set its startup type to **Manual**.

    > [!NOTE]
    >
    > - After you restart and verify that the password has been successfully reset, you can restart the Kerberos Key Distribution Center (KDC) service and set its startup type back to Automatic. This forces the domain controller that has the incorrect computer account password to contact another domain controller for a Kerberos ticket.
    > - You may have to disable the Kerberos Key Distribution Center service on all domain controllers except one. If you can, don't disable the domain controller that has the global catalog, unless it is experiencing problems.

3. Remove the Kerberos ticket cache on the domain controller where you receive the errors. You can do it by restarting the computer or by using the KLIST, Kerbtest, or KerbTray tools. KLIST is included in Windows Server 2008 and in Windows Server 2008 R2. For Windows Server 2003, KLIST is available as a free download in the Windows Server 2003 Resource Kit Tools.

4. At a command prompt, type the following command:

    ```console
    netdom resetpwd /s:<server> /ud:<domain\User> /pd:*
    ```
  
    A description of this command is:

    - `/s:<server>` is the name of the domain controller to use for setting the machine account password. It's the server where the KDC is running.
    - `/ud:<domain\User>` is the user account that makes the connection with the domain you specified in the `/s` parameter. It must be in domain\User format. If this parameter is omitted, the current user account is used.
    - `/pd:*` specifies the password of the user account that is specified in the `/ud` parameter. Use an asterisk (*) to be prompted for the password. For example, the local domain controller computer is Server1 and the peer Windows domain controller is Server2. If you run Netdom.exe on Server1 with the following parameters, the password is changed locally and is simultaneously written on Server2. And replication propagates the change to other domain controllers:

       ```console
       netdom resetpwd /s:server2 /ud:mydomain\administrator /pd:*  
       ```

5. Restart the server whose password was changed. In this example, it's Server1.
