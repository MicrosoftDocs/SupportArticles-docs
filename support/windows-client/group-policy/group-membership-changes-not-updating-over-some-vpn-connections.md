---
title: Group membership changes do not update over some VPN connections
description: Describes a situation in which VPN users might experience resource access or configuration problems after their group membership changes.
ms.date: 03/19/2020
author: Teresa-Motiv
ms.author: v-tea
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
ms.technology: windows-client-group-policy
ms.prod-support-area-path: Problems applying Group Policy objects to users or computers
ms.reviewer: kaushika
localization_priority: medium
keywords: 
---

# Group membership changes don't update over some VPN connections

This article describes a situation in which VPN users might experience resource access or configuration problems after their group membership changes.

_Applies to:_ &nbsp; Windows 10, all SACs

## Symptoms

In response two the Covid-19 pandemic, an increasing number of users now work, learn, and socialize from home. They connect to the workplace by using VPN connections. These VPN users report that when they are added to or removed from security groups, the changes might not take effect as expected. They report symptoms such as the following:

- Changes to network resource access do not take effect.
- Group Policies that target specific security groups don't apply correctly.
- Folder Redirection policy is not applied correctly.
- Applocker rules that target specific security groups don't work.
- Logon scripts that create mapped drives, including user home folder or GPP drive maps, don't work.
- The `whoami /groups` command (run by using a Command Prompt window) reports an out-of-date list of group memberships for the user's local security context.
- The `gpresult /r` command (run from a command prompt) reports an out of date list of group memberships.

If the user locks and then unlocks Windows while the client remains connected to the VPN, some of these symptoms resolve. For example, some resource access changes take effect. Subsequently, if the user signs out of Windows and then signs back in (closing all sessions that use network resources), more of the symptoms resolve. However, logon scripts might not function correctly and the `gpresult /r` command may still not reflect group membership changes.

The user cannot work around the problem by using the `runas` command to start a new Windows session on the client. This command simply uses the same credential information to start the new session.

## Cause

In an office environment, it's common for a user to sign out of Windows at the end of the work day. When the user signs in the next day, the client is already connected to the network and has direct access to a domain controller. Under these conditions, changes to group membership appear to take effect quickly. The user has the correct access levels the next day (the next time the user signs in). Similarly, changes to Group Policy appear to take effect within a day or two (after the user signs in once or twice, depending on the change).

In a home environment, the user probably disconnects from the VPN at the end of the work day and locks Windows, and may not sign out. When the user unlocks Windows (or signs in) the next morning, the client doesn't connect to the VPN (and doesn't have access to a domain controller) until after the user has unlocked Windows or signed in. The client signs the user in to Windows by using cached credentials instead of by contacting the domain controller for fresh credentials. Windows builds a security context for the user that is based on the cached information. Windows also applies Group Policy asynchronously, based on the local Group Policy cache.

- The user may have access to resources they shouldn't have, and may not have access to resources that they should have.
- Group Policy may not be applied as expected, or the Group Policy settings may be out of date.

This behavior occurs because Windows uses cached information to improve performance when users sign in, and to sign in users on domain-joined clients that are not connected to the network. The unexpected consequences arise when the client exclusively uses a VPN to connect to the network, and the client cannot establish the VPN connection until *after* the user signs in.

> [!IMPORTANT]  
> This behavior is relevant only in the interactive logon scenario. Otherwise, access to network resources works as expected because there's no need for logon optimization. Therefore, cached group membership isn't used. The DC is contacted to create the new ticket by using the freshest AMA group membership information.​

### Effects on the user security context and access control

If the client cannot connect to a domain controller when the user signs in, Windows bases the user security context on cached information. If the user's group memberships have changed in the domain, the effects of the cached information on the user's access to resources depend on the following factors:

- Whether the resources are on the client or on the network.
- Whether those resources use Kerberos tickets or other technologies (such as NTLM access tokens) to authenticate and authorize users.
- Whether the user locks and unlocks the client while connected to the VPN.
- Whether the user signs out of the client while connected to the VPN, and then signs in again.

#### Resources that rely on NTLM access tokens

After Windows creates the user security context, it does not update it until the next time that the user signs in.
Any sessions that the user starts by using resources that rely on NTLM access tokens continue to use the cached information. This category of resources includes the following:

- The user session on the client.
- Any resource sessions on the client that rely on NTLM access tokens
- Any resource sessions on the network that rely on NTLM access tokens

If the user opens a Command Prompt window and then runs the 'whoami /groups' command, the list of groups is out of date. If the user locks the client while connected to the VPN and then unlocks it, the client updates its cache of user information. Now, if the user runs `whoami /groups`, the list of groups is correct. However, this change does not affect any existing sessions, including the current user session on the client. Any NTLM-secured resource sessions that were running when the user locked the client continue to run. Further, when the user starts a new NTLM-secured resource session, Windows still provides an access token that is based on the older cached information. This behavior occurs whether the resource is on the client or on the network.

The next time the user fully signs out of Windows and then signs in again, Windows constructs the user security context by using the updated group information. After that, all of the access tokens that Windows creates use the correct information.

#### Resources that rely on Kerberos tickets

After the user signs in, Windows uses cached information to create a deferred Kerberos logon session. This session uses cached information to allow the user to access any local resources that require Kerberos tickets.

> [!NOTE]  
> Any local resource sessions that the user starts during the deferred Kerberos logon session are not affected by subsequent Kerberos transactions. They continue to run based on the cached information until the user ends them or signs out of Windows.

This Kerberos session only lasts until the user connects to the VPN and attempts to access a network resource that relies on Kerberos tickets. At that point, the Kerberos Key Distribution Center (KDC) gets the user's information from Active Directory to authenticate the user and create a ticket-getting-ticket (TGT), which Windows uses to get a session ticket for the requested resource. As a result, the group membership information in the TGT is up-to-date at the time the TGT is created. The session ticket, in turn, uses the group information from the TGT.

The client caches the TGT and continues to use it each time the user starts a new resource session, whether local or on the network. The client also caches session tickets, but each session ticket is only used one time (to start one resource session).

> [!IMPORTANT]  
> If the user's group membership changes after the user has started resource sessions, the user's access is not affected right away.  
>  
> - A change in group membership does not affect existing sessions. Existing sessions continue until the user signs out or otherwise ends them.
> - A change in group membership does not affect the current TGT, or any session tickets that are created for that TGT. The ticket granting service (TGS) uses the group information from the TGT to create a session ticket instead of querying Active Directory itself. The TGT isn't renewed until the user locks the client, signs out, or until the TGT expires (usually 10 hours).

You can use the [`klist` command](/windows-server/administration/windows-commands/klist) to manually purge a user's ticket cache. If the users are admin-enabled, remember to purge both administrative and non-administrative sessions.

### Effects on start-up and sign-in processes

The Group Policy service is optimized to speed up the application of group policy, or to have it run asynchronously when the user signs in, and to reduce adverse effects on client performance. [Understand the Effect of Fast Logon Optimization and Fast Startup on Group Policy](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/jj573586(v=ws.11)) provides an in-depth explanation of how Group Policy interacts with start-up and sign-in processes:

> For [client-side extensions (CSEs)] such as Folder Redirection, Software Installation, and Drive Maps preference extension...the CSE is designed to require synchronous processing to apply the new settings. During asynchronous processing, the CSE signals the system to indicate that a synchronous application of Group Policy is required. A synchronous application of Group Policy occurs at the next startup (if it is signaled during the computer Group Policy refresh) or at the user’s next sign-in (if it is signaled during the user Group Policy refresh).

This design works effectively in an office environment. However, in a working-at-home environment, the user might not sign out and back in while connected to the domain. The circumstances for the Group Policy to apply do not occur on a predictable schedule. The following table summarizes the events that trigger foreground or background processing, and whether the processing is synchronous or asynchronous.

|Trigger |Synchronous or Asynchronous |Foreground or background |
| --- | --- | --- |
|Computer startup or shutdown |Synchronous or asynchronous |Foreground |
|User sign-in or sign-out |Synchronous or asynchronous |Foreground |
|Scheduled (during the user session) |Asynchronous |Background |
|User action (`gpupdate /force`) |Asynchronous |Background |

### Effects on Group Policy reporting

The Group Policy service maintains group membership information on the client, in Windows Management Instrumentation (WMI) and in the registry. The WMI store is purely for use in the Resultant Set of Policy report (produced by using `gpresult /r`).

> [!NOTE]  
> You can turn off the Resultant Set of Policy reporting function by enabling the [Turn off Resultant Set of Policy logging](https://gpsearch.azurewebsites.net/#347) policy.

However, the Group Policy service does not update the group information in WMI under the following circumstances:

- When Group Policy runs in the background, such as during periodic refreshes after the computer has started or a user has signed in. This also applies if a user runs the `gpupdate /force` command to refresh Group Policy.
- When Group Policy runs from the group policy cache, such as when the user signs in while the client does not have access to a domain controller.

Effectively, the group list on a VPN-only client might always be stale. When Group Policy runs and does not update the group information in WMI, the Group Policy service log might record an event that resembles the following:

> GPSVC(231c.2d14) 11:56:10:651 CSessionLogger::Log: restoring old security grps​

You can only be certain that WMI and the output of `gpresult /r` is updated when this line is present in the Group Policy service log for the account of interest:

> GPSVC(231c.2d14) 11:56:10:651 CSessionLogger::Log: logging new security grps

## Resolution

To resolve this problem, use a VPN solution that can establish a VPN connection to a client before the user signs in.

## Workarounds

If you cannot use a VPN that establishes a client connection before the user signs in, these workarounds can mitigate this problem.

### Workaround for changes in group membership

After you add a user to a group or remove a user from a group, provide the following steps to the user. This procedure provides the only supported workaround that refreshes the user security context on clients that do not connect to the VPN before the user signs in.

> [!IMPORTANT]  
> Allow enough time for the membership change to replicate among the domain controllers before you have the user start this procedure.

1. Sign in to the client computer, and then connect to the VPN (as you normally would).
2. When you are sure that the client computer is connected to the VPN, lock it.
3. Unlock the client computer, and then sign out of Windows.
4. Sign in to Windows again. The group membership information (and resource access) is now up to date.

> [!NOTE]  
> You can use the following Windows Powershell script to automate the lock and unlock steps of this procedure. The user has to sign in as part of this process, and still has to sign out of Windows after the script runs.
>  
> ```powershell
> $fullname = $env:userdnsdomain + "\" + "$env:username" > $MyCred = Get-Credential -Username $fullname -Message "Update Logon Credentials"
> Start-Process C:\Windows\System32\cmd.exe -ArgumentList ("/C", "exit 0") -Credential $MyCred -WindowStyle Hidden -PassThru -Wait
> ```

### Workarounds for sign-in processes, including Group Policy

You can mitigate some problems by making configuration changes manually, by making script changes so that scripts can run after the user signs in, or by having the user connect to the VPN and then sign out of Windows. You may have to combine these approaches. For Group Policy, in particular, the key is to understanding when and how Group Policy can function.

For example, a change in Folder Redirection requires synchronous processing, which typically occurs during sign-in. In fact, such a can involve two sign-ins. During the first sign-in, the Group Policy service on the client detects the need for a change, and during the second sign-in, the service makes the change. However, the service has to connect to the domain controllers and the file servers during sign-in. Mapped drive connections have similar issues.

For a detailed list of the processing requirements of Group Policy CSEs, see [Understand the Effect of Fast Logon Optimization and Fast Startup on Group Policy](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/jj573586(v=ws.11)).
