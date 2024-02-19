---
title: Configure remote access client account lockout
description: This step-by-step article describes how to configure the remote access client account lockout feature.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:remote-access, csstroubleshoot
---
# Configure remote access client account lockout

This article describes how to configure the remote access client account lockout feature.

_Applies to:_ &nbsp; Windows Server 2019, Windows 10 - all editions  
_Original KB number:_ &nbsp; 816118

> [!IMPORTANT]
> This article contains information about modifying the registry. Before you modify the registry, make sure to back it up and make sure that you understand how to restore the registry if a problem occurs. For information about how to back up, restore, and edit the registry, see [Windows registry information for advanced users](https://support.microsoft.com/help/256986).

## Summary

Remote access clients include direct dial-in and virtual private network (VPN) clients.

You can use the remote access account lockout feature to specify the following setting:

How many times a remote access authentication has to fail against a valid user account before the user is denied access.

An attacker can try to access an organization through remote access by sending credentials (valid user name, guessed password) during the VPN connection authentication process. During a dictionary attack, the attacker sends hundreds or thousands of credentials. The attacker does so by using a list of passwords based on common words or phrases.

The advantage of activating account lockout is that brute force attacks, such as a dictionary attack, are unlikely to be successful. It's because statistically at least, the account is locked out long before a randomly issued password is likely to be correct. An attacker can still create a denial of service condition that intentionally locks out user accounts.

## Configure remote access client account lockout feature

The remote access account lockout feature is managed separately from the account lockout settings. The account lockout settings are maintained in Active Directory Users and Computers. Remote access lockout settings are controlled by manually editing the registry. These settings don't distinguish between a legitimate user who mistypes a password and an attacker who tries to crack an account.

Remote access server administrators control two features of remote access lockout:

- The number of failed attempts before future attempts are denied.
- How frequently the failed attempts counter is reset.

If you use Windows Authentication on the remote access server, configure the registry on the remote access server. If you use RADIUS for remote access authentication, configure the registry on the Internet Authentication Server (IAS).

## Activate remote access client account lockout

> [!WARNING]
> If you use Registry Editor incorrectly, you may cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that you can solve problems that result from using Registry Editor incorrectly. Use Registry Editor at your own risk.

The failed attempts counter is periodically reset to zero (0). It's automatically reset to zero after the reset time in the following situation:

An account is locked out after the maximum number of failed attempts.

To activate remote access client account lockout and reset time, follow these steps:

1. Select **Start** > **Run**, type *`regedit`* in the **Open** box, and then press ENTER.

2. Locate and then select the following registry key:

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RemoteAccess\Parameters\AccountLockout`

3. Double-click the **MaxDenials** value.

    The default value is zero. It indicates that account lockout is turned off. Type the number of failed attempts before you want the account to be locked out.

4. Select **OK**.
5. Double-click the **ResetTime (mins)** value.

    The default value is **0xb40** that is hexadecimal for 2,880 minutes (two days). Modify this value to meet your network security requirements.

6. Select **OK**.

7. Quit Registry Editor.

## Manually unlock a remote access client

If the account is locked out, the user can try to log on again after the lockout timer has run out. Or, you can delete the
 **DomainName:UserName** value in the following registry key:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RemoteAccess\Parameters\AccountLockout`

To manually unlock an account, follow these steps:

1. Select **Start** > **Run**, type `regedit` in the **Open** box, and then press ENTER.

2. Locate and then select the following registry key:

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RemoteAccess\Parameters\AccountLockout`

3. Find the **Domain Name:User Name** value, and then delete the entry.

4. Quit Registry Editor.

5. Test the account to confirm that it's no longer locked out.

## References

For more information about the remote access client lockout feature, see [Account Lockout Policy](/windows/security/threat-protection/security-policy-settings/account-lockout-policy).
