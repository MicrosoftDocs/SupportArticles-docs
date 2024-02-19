---
title: User Account Control and remote restrictions
description: Describes User Account Control (UAC) and remote restrictions in Windows Vista.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:permissions-access-control-and-auditing, csstroubleshoot
---
# Description of User Account Control and remote restrictions in Windows Vista

This article describes User Account Control (UAC) and remote restrictions.

_Applies to:_ &nbsp; Windows Vista  
_Original KB number:_ &nbsp; 951016

## Introduction

User Account Control (UAC) is a new security component of Windows Vista. UAC enables users to perform common day-to-day tasks as non-administrators. These users are called _standard users_ in Windows Vista. User accounts that are members of the local Administrators group will run most applications by using the principle of _least privilege_. In this scenario, least-privileged users have rights that resemble the rights of a standard user account. However, when a member of the local Administrators group has to perform a task that requires administrator rights, Windows Vista automatically prompts the user for approval.

## How UAC remote restrictions work

To better protect those users who are members of the local Administrators group, we implement UAC restrictions on the network. This mechanism helps prevent against _loopback_ attacks. This mechanism also helps prevent local malicious software from running remotely with administrative rights.

### Local user accounts (Security Account Manager user account)

When a user who is a member of the local Administrators group on the target remote computer establishes a remote administrative connection by using the net use `*\\remotecomputer\Share$` command, for example, they won't connect as a full administrator. The user has no elevation potential on the remote computer, and the user cannot perform administrative tasks. If the user wants to administer the workstation with a Security Account Manager (SAM) account, the user must interactively log on to the computer that is to be administered with Remote Assistance or Remote Desktop, if these services are available.

### Domain user accounts (Active Directory user account)

A user who has a domain user account logs on remotely to a Windows Vista computer. And, the domain user is a member of the Administrators group. In this case, the domain user will run with a full administrator access token on the remote computer, and UAC won't be in effect.

> [!NOTE]
> This behavior is not different from the behavior in Windows XP.

## How to disable UAC remote restrictions

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To disable UAC remote restrictions, follow these steps:

1. Click **Start**, click **Run**, type _regedit_, and then press ENTER.

2. Locate and then click the following registry subkey:

    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System`

3. If the **`LocalAccountTokenFilterPolicy`** registry entry doesn't exist, follow these steps:

    1. On the **Edit** menu, point to **New**, and then select **DWORD Value**.
    2. Type _LocalAccountTokenFilterPolicy_, and then press ENTER.

4. Right-click **LocalAccountTokenFilterPolicy**, and then select **Modify**.
5. In the **Value data** box, type _1_, and then select **OK**.
6. Exit Registry Editor.

### Did this fix the problem

Check whether the problem is fixed. If the problem isn't fixed, [contact support](https://support.microsoft.com/contactus/).

## UAC remote settings

The **LocalAccountTokenFilterPolicy** registry entry can have a value of 0 or 1. These values change the behavior of the registry entry to the one described in the following table.

|Value|Description|
|---|---|
|0|This value builds a filtered token. It's the default value. The administrator credentials are removed.|
|1|This value builds an elevated token.|
  
