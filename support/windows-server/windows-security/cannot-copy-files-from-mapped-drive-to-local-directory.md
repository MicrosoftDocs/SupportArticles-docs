---
title: Cannot copy files from mapped drive to local directory
description: You receive the Location is not available error when you try to copy files from a mapped drive to a local directory.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, jkuehler, pleblanc, arrenc
ms.prod-support-area-path: Permissions, access control, and auditing
ms.technology: windows-server-security
---
# Copying files from a mapped drive to a local directory fails with error (Location is not available) if UAC is enabled

This article provides a resolution to solve the **Location is not available** error that occurs when you try to copy files from a mapped drive.

_Original product version:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2019185

## Symptoms

With User Account Control (UAC) enabled, you may receive the following error when attempting to copy a file from a mapped drive to a local directory:

> Location is not available  
\<mapped drive letter>\ refers to a location that is unavailable. It could be on a hard drive on this computer, or on a network. Check to make sure that the disk is properly inserted, or that you are connected to the Internet or your network, and then try again. If it still cannot be located, the information might have been moved to a different location.

## Cause

The underlying cause is UAC and the interaction with split token. When an administrator signs in to a machine with Admin Approval Mode enabled (AAM), the user is granted two access tokens: a full administrator access token and a filtered standard user access token. By default, when a member of the local Administrators group signs in to, the administrative Windows privileges are disabled and elevated user rights are removed, resulting in the standard user access token. The standard user access token is then used to launch the desktop (Explorer.exe). Explorer.exe is the parent process from which all other user-initiated processes inherit their access token. As a result, all applications run as a standard user by default unless a user provides consent or credentials to approve an application to use a full administrative access token. Contrasting with this process, when a standard user signs in to, only a standard user access token is created. This standard user access token is then used to launch the desktop.

The following conditions must be in place for the error to occur:

1. UAC is enabled with AAM.
2. The user is not logged on as an administrator of the local computer or with domain administrator account credentials.
3. A drive is mapped using standard user security context.
4. Users do not have Create/Write NTFS permissions on the target directory.

The user has mapped a drive using either the **Map Network Drive** option in Windows Explorer or by running the `net use` command in a non-elevated command prompt. Mapped drives can be seen by running net use as a standard user from a non-elevated command prompt. In this case, the drive was mapped as a standard user.

```console
C:\Users\johnsmith>net use
New connections will be remembered.
Status      Local     Remote                    Network
-------------------------------------------------------------------------------
OK          X: [\\contoso-dc1\d$](file://contoso-dc1/d$)               Microsoft Windows Network
The command completed successfully.
```

Running the same command in an elevated command prompt (selecting **Run as Administrator**), there is no mapped drive listed.

```console
C:\Windows\system32>net use
New connections will be remembered.
There are no entries in the list.
```

This clearly shows that the elevated session does not see the standard user's mapped drive and therefore is unable to complete the copy operation. This behavior is by design.

> [!NOTE]
> By default, AAM is enabled for accounts that are members of the local Administrators group. The setting can be found in the **Security Options** node of **Local Policy**, under **Security Settings** and is configurable with the Local Group Policy Editor (secpol.msc) and with the Group Policy Management Console (GPMC) (gpedit.msc). For more information on UAC, see [User Account Control](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc772207(v=ws.10)).

## Resolution

1. Map the drive using an elevated process. Windows Explorer, however, will not see the elevated drive mapping. See the [More Information](#more-information) section for further details.

   [Inside Windows 7 User Account Control](/previous-versions/technet-magazine/dd822916(v=msdn.10))

2. Use a UNC path to connect to network resources, for example, \\\server\share.

3. Use Group Policy Preferences to map drives. This white paper referenced below introduces Group Policy Preferences, a new feature in Windows Server 2008, and describes how you can use Group Policy Preferences to better deploy and manage operating system and application settings. Group Policy Preferences allow you to configure, deploy, and manage operating system and application settings you were previously not able to manage using Group Policy. Examples include mapped drives, scheduled tasks, and Start menu settings. For many types of operating system and application settings, using Group Policy Preferences is a better alternative to configuring them in Windows images or using logon scripts.

   [Group Policy Preferences Overview](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn581922(v=ws.11))

4. Map drives using a logon script that utilizes the *launchapp.wsf* script to schedule the commands using the task scheduler. This document below helps you sort through the new and updated features available in Windows Vista, and it provides a number of best practices to help you deploy Group Policy.

   [Deploying Group Policy Using Windows Vista](/previous-versions/windows/it-pro/windows-vista/cc766208(v=ws.10))

5. The following article describes an unsupported method that reverts the security change described earlier by configuring the `EnableLinkedConnections` registry value. This value enables Windows Vista to share network connections between the filtered access token and the full administrator access token for a member of the Administrators group. After you configure this registry value, LSA checks whether there is another access token that is associated with the current user session if a network resource is mapped to an access token. If LSA determines that there is a linked access token, it adds the network share to the linked location.

   [Programs may be unable to access some network locations after you turn on User Account Control in Windows Vista or newer operating systems](https://support.microsoft.com/help/937624)

## More information

When the administrative user signs in to, Windows processes the logon scripts using the elevated token. The script actually works and maps the drive. However, Windows blocks the view of the mapped network drives because the desktop uses the filtered token while the drives were mapped using the elevated (full administrator) token.

Before Windows 2000 SP2, device names (for example, mapped drives) remained globally visible until explicitly removed or the system restarted. For security reasons, we modified this behavior starting with Windows 2000 SP2. From this point forward, all devices are associated with an authentication ID (LUID), which is an ID generated for each logon session. (A process running in LocalSystem context can create a device name in the Global device namespace, although local namespace objects can hide global namespace objects.)

Because these mapped drives are associated with LUID, and because elevated applications are using a different LUID generated during a separate login event, the elevated application will no longer see any mapped drives for this user. You'll notice the same behavior previously using `RunAs` or the `CreateProcessAsUser` API, but UAC dramatically increases the number of users who will be using these concepts.

The result is that if you elevate a command prompt, you'll no longer see any local namespace mapped drives created from your original login (whether created through a logon script, using the `WNetAddConnection` API, or otherwise). There is a mitigation in place for the scenario of launching from Windows Explorer. If you double-click on an executable that is either detected as an installation file or is manifested as requireAdministrator, Windows can detect that it was elevated and that there is an error indicating the path was not found, and copy that drive mapping over from the original LUID. However, that is the only scenario that is automated.
