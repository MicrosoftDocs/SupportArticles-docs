---
title: How to use the BitLocker Recovery Password Viewer to view recovery passwords for Windows Vista
description: Describes a tool that you can use to locate and to view BitLocker recovery passwords.
ms.date: 03/24/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:bitlocker, csstroubleshoot
ms.subservice: windows-security
---
# How to use the BitLocker Recovery Password Viewer for Active Directory Users and Computers tool to view recovery passwords for Windows Vista

This article describes a tool that you can use to locate and view BitLocker recovery passwords.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 928202

Support for Windows Vista without any service packs installed ended on April 13, 2010. To continue receiving security updates for Windows, make sure you're running Windows Vista with Service Pack 2 (SP2). For more information, see this Microsoft web page: [Support is ending for some versions of Windows](https://windows.microsoft.com/windows/help/end-support-windows-xp-sp2-windows-vista-without-service-packs).

## Summary

This article describes how to use the BitLocker Recovery Password Viewer for Active Directory Users and Computers tool. The BitLocker Drive Encryption feature is a data protection feature that's included with the following versions of Windows Vista:

- Windows Vista Ultimate
- Windows Vista Enterprise

> [!NOTE]
> This article also provides information about optional use of the BitLocker Recovery Password Viewer for XP-based computers.  
If you want to obtain the BitLocker Recovery Password Viewer tool for Windows XP/Windows Server 2003, please contact a Microsoft Support Professional.

You can use this tool to help locate BitLocker Drive Encryption recovery passwords for Windows Vista-based computers in Active Directory Domain Services (AD DS). The Active Directory Users and Computers Microsoft Management Console (MMC) snap-in must be installed via the Remote Server Administrator Tools (RSAT).

> [!NOTE]
> To use this tool to retrieve BitLocker Drive Encryption passwords, you must use an account that has sufficient rights. You must be a domain administrator, or you must be granted sufficient rights by a domain administrator.

## Overview

The BitLocker Recovery Password Viewer lets you locate and view BitLocker recovery passwords that are stored in AD DS. You can use this tool to help recover data that's stored on a volume that has been encrypted by using BitLocker. The BitLocker Recovery Password Viewer tool is an extension for the Active Directory Users and Computers MMC snap-in. After you install this tool, you can examine the Properties dialog box of a computer object to view the corresponding BitLocker recovery passwords. Additionally, you can right-click a domain container and then search for a BitLocker recovery password across all the domains in the Active Directory _forest_ (multiple domains).

Before you can use the BitLocker Recovery Password Viewer tool to view BitLocker recovery passwords, the following conditions must be true:

- The domain must be configured to store BitLocker recovery information.
- Windows Vista-based computers must be joined to the domain.
- BitLocker Drive Encryption must have been enabled on the Windows Vista-based computers.

## How to obtain the BitLocker Recovery Password Viewer tool for Windows XP

To obtain the BitLocker Recovery Password Viewer tool for Windows XP/Windows Server 2003, contact a Microsoft Support Professional.

To install the BitLocker Recovery Password Viewer tool on a Windows XP-based computer, you must first install the latest version of the Windows Server 2003 Administration Tools.

## Installation rights for the BitLocker Recovery Password Viewer tool

To install the BitLocker Recovery Password Viewer tool successfully, the installation program must update the Active Directory configuration database.
The installation program adds the following two attributes to AD DS if these two attributes aren't already present.

| Object type| Object value |
|---|---|
|Object| **CN=computer-Display** |
|Container| **CN=**LanguageID**,CN=**DisplaySpecifier**,CN=Configuration,DC=example,DC=com** |
|Attribute name| **adminPropertyPages** |
|Attribute value| ****Password Viewer's GUID**** |
  
| Object type| Object value |
|---|---|
|Object| **CN=domainDNS-Display** |
|Container| **CN=**LanguageID**,CN=**DisplaySpecifier**,CN=Configuration,DC=example,DC=com** |
|Attribute name| **adminContextMenu** |
|Attribute value| ****Password Viewer's GUID**** |

> [!NOTE]
> These tables use the following values:
>
> - **Password Viewer's GUID** is 2FB1B669-59EA-4F64-B728-05309F2C11C8.
> - **LanguageID** for English is 409. The installation program updates all language IDs to let you run the BitLocker Recovery Password Viewer tool under all available languages.

These changes to AD DS affect every domain in the forest. You must have Enterprise Administrator rights to modify the Active Directory configuration database. However, after the BitLocker Recovery Password Viewer tool has been installed in a forest, you only have to have Read permissions to the Active Directory configuration database for later installations of the BitLocker Recovery Password Viewer tool. By default, all domain users have Read permissions for the Active Directory configuration database.

To summarize, you must have the following rights to install the BitLocker Recovery Password Viewer tool:

- When you first install the BitLocker Recovery Password Viewer tool, you must have Enterprise Administrator rights. These rights let you modify the Active Directory configuration database.
- When you next install the BitLocker Recovery Password Viewer tool, you must have the rights of a domain user together with local Administrator rights to the computer on which you want to install the BitLocker Recovery Password Viewer tool.

## Registry information

Before you run this tool on the domain for the first time, run the following command from your Windows system folder as an Enterprise Administrator:

```console
regsvr32.exe BdeAducExt.dll
```

When you later use the tool on the domain, you won't have to run Regsvr32.exe.

## Installation troubleshooting information

The installation rights are the same for Windows XP and Windows Vista. Use the following information to help troubleshoot installation error messages that you may receive when you install the BitLocker Recovery Password Viewer tool:

### Error message 1

> Not enough storage is available to process this command.

You receive this error message if you installed the Windows XP version of the BitLocker Recovery Password Viewer tool on a Windows Vista-based computer. You must install the Windows Vista-based version of the tool on Windows Vista-based computers.

### Error message 2

> You do not have permission to update Windows XP. Please contact your system administrator.

You receive this error message if you don't have sufficient rights to install the BitLocker Recovery Password Viewer tool on a Windows XP-based computer. You must have local Administrator rights to install this tool.

### Error message 3

> Cannot connect to the domain controller. You must be logged in as a domain user with a connection to the network.

You receive this error message if one of the following conditions is true:

- The computer isn't connected to the network, or the computer can't communicate with the domain.
- You aren't logged on to the computer as a domain user.

### Error message 4

> You do not have permissions to perform this install. Enterprise administrative rights are required.

You may receive this error message when you try to install the first instance of the BitLocker Recovery Password Viewer tool in a forest. For the first installation of this tool, you must have Read and Write permissions to the computer-Display object and to the domainDNS-Display object in AD DS. Also, you must have Read and Write permissions to the parent containers of these objects in the Active Directory configuration database. By default, members of the Enterprise Administrators group have Read and Write permissions to these objects.

### Error message 5

> Installation failed with error code: 0x8007200A

You may receive this error message when you try to perform a second or later installation of the BitLocker Recovery Password Viewer tool in a domain. To perform a second or later installation of this tool, you must have at least Read permissions to the computer-Display object and to the domainDNS-Display object in AD DS. Also, you must have at least Read permissions to the parent containers of these objects in the Active Directory configuration database.

## To remove the BitLocker Recovery Password Viewer tool

To remove the BitLocker Recovery tool, follow these steps:

1. Click **Start** > **Run**, type _appwiz.cpl_, and then click **OK**.
2. In the **Add or Remove Programs** dialog box, click to select the **Show updates** check box.
3. In the **Currently installed programs** list, click **BitLocker Recovery Password Viewer (for Active Directory Users and Computers)** > **Remove**.
4. If you receive a message that states that other programs may not run correctly if you remove this update, click **Yes** to confirm the removal of this update.
    > [!NOTE]
    > The removal of the BitLocker Recovery Password Viewer tool does not prevent other programs from running correctly.
5. Follow the remaining steps in the wizard to remove the BitLocker Recovery Password Viewer tool.

## Usage information

The BitLocker Recovery Password Viewer tool extends the Active Directory Users and Computers MMC snap-in. To start Active Directory Users and Computers, click **Start** > **Run**, type _dsa.msc_, and then click **OK**.

The following information describes how to use the BitLocker Recovery Password Viewer tool.

### To view the recovery passwords for a computer

1. In Active Directory Users and Computers, locate and then click the container in which the computer is located. For example, click the **Computers** container.

    For more information about how to create a saved query, visit the following Microsoft Web site:

    [Create a saved query](https://technet.microsoft.com/library/cc757566.aspx)
2. Right-click the computer object, and then click **Properties**.
3. In the **ComputerName Properties** dialog box, click the **BitLocker Recovery** tab to view the BitLocker recovery passwords that are associated with the particular computer.

### To copy the recovery passwords for a computer

1. Follow the steps in the "To view the recovery passwords for a computer" section to view the BitLocker recovery passwords.
2. On the **BitLocker Recovery** tab of the **ComputerName Properties** dialog box, right-click the BitLocker recovery password that you want to copy, and then click **Copy Details**.
3. Paste the copied text to a destination location.

### To locate a recovery password

1. In Active Directory Users and Computers, right-click the domain container, and then click **Find BitLocker Recovery Password**.
2. In the **Find BitLocker Recovery Password** dialog box, type the first eight characters of the recovery password in the **Password ID (first 8 characters)** box, and then click **Search**.

    :::image type="content" source="media/bitlocker-recovery-password-viewer-tool/find-bitlocker-recover-pwd.png" alt-text="Screenshot of the Active Directory Users and Computers window with Find BitLocker Recovery Password selected.":::

## Frequently asked questions about the BitLocker Recovery Password Viewer tool

Q1: How can the BitLocker Recovery Password Viewer tool help unlock an encrypted volume?

A1: When you start the computer to the BitLocker Recovery screen, Windows Vista gives you a drive label and a password ID. You can use this information together with the BitLocker Recovery Password Viewer tool to locate the matching BitLocker recovery password that is stored in AD DS.

Q2: Can anybody use the BitLocker Recovery Password Viewer tool to locate recovery passwords?

A2: No. To view recovery passwords, you must be a domain administrator, or you must have been delegated permissions by a domain administrator.

If a user who doesn't have sufficient rights installs the BitLocker Recovery Password Viewer tool, that user can't locate any recovery passwords for any computer. Also, if you use the BitLocker Recovery Password Viewer tool to search for recovery passwords among all the domains in a forest, results are returned only from the domains in which you have sufficient rights.

> [!NOTE]
> The BitLocker Recovery Password Viewer tool cannot distinguish between a situation in which no recovery passwords exist for a particular computer and a situation in which you do not have sufficient rights to view the recovery password for a particular computer.

Q3: What if a stored recovery password doesn't appear on the "BitLocker Recovery" tab of a computer's "**ComputerName Properties**" dialog box?

A3: Usually, the BitLocker recovery passwords for a particular computer appear on the **BitLocker Recovery** tab of the **ComputerName Properties** dialog box for that computer. However, if a computer is renamed, you may be unable to locate the correct computer. This is because the drive label information still contains the original computer name. In this situation, you must use the password ID information to search for the recovery password.

Q4: Why are only the first eight characters of the password ID used to search for the location of a recovery password?

A4: This is a design decision that's intended to help simplify searching for recovery passwords without sacrificing the accuracy of the search operation. Tests that randomly generated over one million password IDs typically yielded only 100 duplicates for the first eight characters of the password ID. So even if you have one million recovery passwords in a search domain, it's unlikely that two recovery passwords will be returned by a single search operation. Additionally, it's even more unlikely that more than two recovery passwords will be returned in the same search.

> [!NOTE]
> We recommend that you examine the returned recovery password to make sure that it matches the whole password ID that you used to perform the search. This is to verify that you have obtained the unique recovery password.

Q5: How long does it take to search for a recovery password across all domains?

A5: Generally, it takes no more than several seconds to search for a password ID across all the domains of a forest. However, you may experience decreased performance if the following conditions are true:

- A global catalog server locates a recovery password in a domain.
- The global catalog server can't connect to that particular domain.

Q6: How do I troubleshoot problems that I may experience when I use the BitLocker Recovery Password Viewer tool?

A6: Use the following information to help troubleshoot issues that you experience when you use the BitLocker Recovery Password Viewer tool:

- If you can't locate a recovery password when you expect to locate one, verify that you have sufficient rights to view recovery passwords.
- If you receive a "Cannot retrieve recovery password information" error message when you search for a recovery password, verify that the global catalog servers and other domain controllers can communicate correctly.

For more information about the BitLocker Repair Tool, visit the following Microsoft Web site:

[928201](https://support.microsoft.com/help/928201) How to use the BitLocker Repair Tool to help recover data from an encrypted volume in Windows Vista or in Windows Server 2008
