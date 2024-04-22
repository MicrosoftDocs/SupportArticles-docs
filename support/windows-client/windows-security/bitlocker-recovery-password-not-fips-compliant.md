---
title: The recovery password for Windows BitLocker isn't available when FIPS compliant policy is set in Windows
description: Explains that the recovery password for Windows BitLocker isn't FIPS-compliant in Windows.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: scottvan, cochen, kaushika
ms.custom: sap:Windows Security Technologies\BitLocker, csstroubleshoot
---
# The recovery password for Windows BitLocker isn't available when FIPS compliant policy is set in Windows

This article discusses the issues that occur because the recovery password for Windows BitLocker isn't FIPS-compliant in Windows.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2008 R2  
_Original KB number:_ &nbsp; 947249

## Introduction

The key derivation algorithm used with the recovery password for Windows BitLocker Drive Encryption isn't Federal Information Processing Standards (FIPS)-compliant in Windows. Therefore, you may encounter the following issues when the **System cryptography: Use FIPS compliant algorithms for encryption, hashing, and signing** Group Policy setting is enabled.

### Issue 1

When you manually add a recovery password at a command prompt, you receive the following error message:

> The numerical password was not added. The FIPS Group Policy setting on the computer prevents recovery password creation.

### Issue 2

When you try to encrypt a drive on which BitLocker recovery passwords are required, you can't encrypt the drive as expected. Additionally, you receive the following error message:

> Cannot Encrypt Disk. Policy requires a password which is not allowed with the current security policy about use of FIPS algorithms.

### Issue 3

When you encrypt a drive, a recovery key is created, but no recovery password is created as a key protector.

### Issue 4

A recovery password isn't archived in the Active Directory directory service.

## More information

A BitLocker recovery password has 48 digits. This password is used in a key derivation algorithm that isn't FIPS-compliant. Therefore, if you enable the System cryptography: Use FIPS compliant algorithms for encryption, hashing, and signing  Group Policy setting, you can't create or unlock a drive by using a recovery password. In contrast, a BitLocker recovery key is an AES key that doesn't require a key derivation algorithm to be performed upon it and is FIPS-compliant. Therefore, a recovery key isn't affected by this Group Policy setting.

To disable the System cryptography: Use FIPS compliant algorithms for encryption, hashing, and signing Group Policy setting, follow these steps:

1. Click **Start**, type *gpedit.msc* in the **Start Search** box, and then click **OK**.

    > [!NOTE]
    > If you are prompted for an administrator password or for confirmation, type the password, or provide confirmation.
2. Expand **Computer Configuration**, expand **Windows Settings**, expand **Security Settings**, expand **Local Policies**, and then click **Security Options**.
3. In the details pane, double-click **System cryptography: Use FIPS compliant algorithms for encryption, hashing, and signing**, click **Disable**, and then, click **OK**.

> [!NOTE]
> This Group Policy setting may be configured by an administrator to be automatically applied from a domain controller. In this situation, you can't disable this setting locally.
