---
title: NTLM network authentication changes
description: Describes new behavior in Windows Server 2003 SP1 that affects NTLM password changes. After you install the service pack, domain users can change a password and still use their old password to authenticate. This setting can be changed in the registry.
ms.date: 04/11/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, maotori
ms.custom:
- sap:windows security technologies\legacy authentication (ntlm)
- pcy:WinComm Directory Services
---
# Setting in NTLM network authentication behavior allows use of previous password

This article describes a behavior that affects NTLM password changes and how to change this behavior by using a registry.

_Original KB number:_ &nbsp; 906305

## Introduction

There is an option in NTLM network authentication when a user password was changed. Domain users can use their old password to access the network for five minutes after the password is changed. Existing components that are designed to use Kerberos for authentication are not affected by this change.

The goal of this change is to allow background processes such as services to continue running for some time until an administrator has the opportunity to update the credentials for the new password.

## NTLM network authentication behavior

To reliably support network access for NTLM network authentication in distributed environments, the NTLM network authentication behavior is as follows:

- After a domain user successfully changes a password by using NTLM, the old password can still be used for network access for a user-definable time period. This behavior allows accounts, such as service accounts, that are logged on to multiple computers to access the network while the password change propagates.
- The extension of the password lifetime period applies only to network access by using NTLM. Interactive logon behavior is unchanged. This behavior does not apply to accounts that are hosted on stand-alone servers or on member servers. Only domain users are affected by this behavior.
- The lifetime period of the old password can be configured by editing the registry on a domain controller. No restart is required for this registry change to take effect.

## Change the lifetime period of an old password

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).  

To change the lifetime period of an old password, add a DWORD entry that is named *OldPasswordAllowedPeriod* to the following registry subkey on a domain controller:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa`  

To do this, follow these steps:

1. Click **Start**, click **Run**, type regedit, and then click **OK**.
2. Locate and then click the following registry subkey:

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa`  

3. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
4. Type *OldPasswordAllowedPeriod* as the name of the DWORD, and then press ENTER.
5. Right-click **OldPasswordAllowedPeriod**, and then click **Modify**.
6. In the **Value data** box, type the value in minutes that you want to use, and then click **OK**.

    > [!NOTE]
    > The lifetime period is set in minutes. If this registry value is not set, the default lifetime period for an old password is five minutes.

7. Quit Registry Editor.

> [!NOTE]
> This registry setting does not require a restart to take effect.
>
> This behavior does not cause a security weakness. As long as only one user knows both passwords, the user is still securely authenticated by using either password.

If a user's password is known to be compromised, the administrator should reset the password for that user. The administrator should ask the user to change the password at the next logon to invalidate the old password as soon as possible.

To reset a user's password, follow these steps:

1. Start Active Directory Users and Computers.
2. Locate the user account whose password must be reset.
3. Right-click the user object, and then click **Reset Password**.
4. Type the new password in the **New password** box and in the **Confirm password** box.
5. Click to select the **User must change password at next logon** check box, and then click **OK**.

> [!NOTE]
> The behavior that is described in this article occurs only if the effective password policy on the domain controllers has **Enforce Password History** set to a value that specifies that two or more passwords will be remembered. The password policy should be set at the domain level. You can determine whether the policy has taken effect on the domain controllers by using the Secpol.msc snap-in.
