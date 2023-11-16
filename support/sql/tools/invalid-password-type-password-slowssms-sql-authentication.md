---
title: Invalid password error and slow response to typed password in SSMS
description: This article provides workarounds for the Invalid password error and slow response to typed password in SQL Server Management Studio.
ms.date: 11/22/2022
ms.custom: sap:Other tools
ms.reviewer: ramakoni1, v-jayaramanp
---

# "Invalid password" error and slow response to typed password in SSMS

This article describes an issue that occurs at password input in SQL Server Management Studio (SSMS) with SQL Server authentication.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 4038457

## Symptoms

Assume that you use SSMS 17.2 (or an older version of the program) to connect to any version of SQL Server by using SQL Server authentication. When you type the password, the visual response of the password box to your key presses on the keyboard is noticeably slow. Additionally, the login attempt fails, and an "invalid password" error message is shown, even if you entered the password correctly.

## Cause

This issue occurs because the Windows Data Protection API can't back up a MasterKey to a domain controller for the domain, which contains the Windows account that's used to start SSMS.

## Workaround

To work around this issue:

- Use Windows authentication instead of SQL authentication.
- Log in to Windows using a local account instead of a domain account.
- Follow the steps in the "Resolution" section in [DPAPI MasterKey backup failures when RWDC isn't available](../../windows-server/identity/dpapi-masterkey-backup-failures.md#resolution).

## Resolution

To fix this issue, identify and resolve the issue that's preventing backup of the Windows Data Protection API MasterKey.

## More information

The following steps describe what happens in this scenario:

1. When you type a character in the password box in SSMS, the [CryptProtectData](/windows/win32/api/dpapi/nf-dpapi-cryptprotectdata) Windows Data Protection API (DPAPI) function is called to encrypt the password.

1. DPAPI initially generates a strong key called a MasterKey (because there's no valid MasterKey to be used), which is protected by the user's logon credentials, and the backup process is invoked.

1. When this process fails (because there's no accessible writable Domain Controller (DC) for the user domain), an error is generated and thrown to the SSMS application.

1. In SSMS code, this error is caught and not handled. Since the code doesn't handle the situation, this error isn't shown to the user.

1. This causes the password that's sent to the SQL Server to be an empty string. When you encounter this issue, there are two symptoms:

      - Typing in the password box is noticeably slow due to the failed attempts to reach a writable domain controller.

      - The SQL Server reports an invalid password in its error log even when the correct password is entered.

Essentially, you have encountered the issue documented at the article [DPAPI MasterKey backup failures when RWDC isn't available](../../windows-server/identity/dpapi-masterkey-backup-failures.md). Microsoft has changed the SSMS code for the 17.3 and future releases. Therefore, if this issue is encountered, the system will report the exception that is thrown from DPAPI for much easier diagnosis.

## References

- [CryptProtectData function](/windows/win32/api/dpapi/nf-dpapi-cryptprotectdata)

- [Windows Data Protection](/previous-versions/ms995355(v=msdn.10))

- [DPAPI MasterKey backup failures when RWDC isn't available](../../windows-server/identity/dpapi-masterkey-backup-failures.md)