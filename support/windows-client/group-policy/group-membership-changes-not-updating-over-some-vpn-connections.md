---
title: Group membership changes do not update over some VPN connections
description: Describes a situation in which VPN users might experience resource access or configuration problems after their group membership changes.
ms.date: 45286
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.custom: sap:problems-applying-group-policy-objects-to-users-or-computers, csstroubleshoot
ms.reviewer: kaushika, v-tappelgate
localization_priority: medium
keywords: group policy, group membership
---

# Group membership changes don't update over some VPN connections

This article describes a situation in which VPN users might experience resource access or configuration problems after their group membership changes.

_Applies to:_ &nbsp; Windows 10, all SACs

## Symptoms

In response to the Covid-19 pandemic, an increasing number of users now work, learn, and socialize from home. They connect to the workplace by using VPN connections. These VPN users report that when they are added to or removed from security groups, the changes might not take effect as expected. They report symptoms such as the following:

- Changes to network resource access don't take effect.
- Group Policy Objects (GPOs) that target specific security groups don't apply correctly.
- Folder Redirection policy isn't applied correctly.
- Applocker rules that target specific security groups don't work.
- Logon scripts that create mapped drives, including user home folder or GPP drive maps, don't work.
- The `whoami /groups` command (run at a command prompt) reports an out-of-date list of group memberships for the user's local security context.
- The `gpresult /r` command (run at a command prompt) reports an out-of-date list of group memberships.

If the user locks and then unlocks Windows while the client remains connected to the VPN, some of these symptoms resolve themselves. For example, some resource access changes take effect. Subsequently, if the user signs out of Windows and then signs back in (closing all sessions that use network resources), more of the symptoms resolve. However, logon scripts might not function correctly, and the `gpresult /r` command might still not reflect group membership changes. The user cannot work around the problem by using the `runas` command to start a new Windows session on the client. This command just uses the same credential information to start the new session.

The scope of this article includes environments that have implemented Authentication Mechanism Assurance (AMA) in the domain, and in which users have to authenticate by using a Smart Card to access network resources. For more information, see [Description of AMA usage in interactive logon scenarios in Windows](https://support.microsoft.com/topic/description-of-ama-usage-in-interactive-logon-scenarios-in-windows-a61e0931-f11a-73ad-6221-e117ed6e913f).

## Cause

In an office environment, it's common for a user to sign out of Windows at the end of the workday. When the user signs in the next day, the client is already connected to the network and has direct access to a domain controller. Under these conditions, changes to group membership take effect quickly. The user has the correct access levels the next day (the next time the user signs in). Similarly, changes to Group Policy appear to take effect within a day or two (after the user signs in one or two times, depending on the policies that are scheduled to apply).

In a home environment, the user might disconnect from the VPN at the end of the workday and lock Windows. They might not sign out. When the user unlocks Windows (or signs in) the next morning, the client doesn't connect to the VPN (and doesn't have access to a domain controller) until after the user has unlocked Windows or signed in. The client signs the user in to Windows by using cached credentials instead of by contacting the domain controller for fresh credentials. Windows builds a security context for the user that is based on the cached information. Windows also applies Group Policy asynchronously, based on the local Group Policy cache. This usage of cached information can cause the following behavior:

- The user may have access to resources they shouldn't have, and may not have access to resources that they should have.
- Group Policy settings may not be applied as expected, or the Group Policy settings may be out-of-date.

This behavior occurs because Windows uses cached information to improve performance when users sign in. Windows also uses cached information to sign in users on domain-joined clients that are not connected to the network. Unexpected consequences occur if the client exclusively uses a VPN to connect to the network, and the client cannot establish the VPN connection until after the user signs in.

> [!IMPORTANT]  
> This behavior is relevant only in the interactive logon scenario. Access to network resources works as expected because the network logon does not use cached information. Instead, the group information comes from a domain controller query.

### Effects on the user security context and access control

If the client cannot connect to a domain controller when the user signs in, Windows bases the user security context on cached information. After Windows creates the user security context, it does not update the context until the next time that the user signs in.

For example, suppose that a user is assigned to a group in Active Directory while the user is offline. The user signs in to Windows, and then connects to the VPN. If the user opens a Command Prompt window and then runs the `whoami /groups` command, the list of groups doesn't include the new group. The user locks and then unlocks the desktop while still connected to the VPN. The `whoami /groups` command still produces the same result. Finally, the user signs out of Windows. After the user signs in again, the `whoami /groups` command produces the correct result.

The effect of the cached information on the user's access to resources depends on the following factors:

- **Whether the resources are on the client or on the network**  
  Resources on the network require an additional authentication step (a network logon instead of an interactive logon). This step means that the group information that the resource uses to determine access always comes from a domain controller, not the client cache.
- **Whether the resources use Kerberos tickets or other technologies (such as NTLM access tokens) to authenticate and authorize users**  
  - For details about how cached information affects user access to NTLM-secured resources, see [Resources that rely on NTLM authentication](#resources-that-rely-on-ntlm-authentication).
  - For details about how cached information affects user access to Kerberos-secured resources, see [Resources that rely on Kerberos tickets](#resources-that-rely-on-kerberos-tickets).
- **Whether the user is resuming an existing resource session or starting a new resource session**
- **Whether the user locks and unlocks the client while connected to the VPN**  
  If the user locks the client while connected to the VPN and then unlocks it, the client updates its cache of user groups. However, this change does not affect the existing user security context or any sessions that were running when the user locked the client.
- **Whether the user signs out of the client while connected to the VPN, and then signs in again**  
  The effects of signing out and then signing in differ depending on whether the user has locked and unlocked the client first while connected to the VPN. Locking the client and then unlocking it updates the cache of user information that the client uses at the next sign-in.

#### Resources that rely on NTLM authentication

This category of resources includes the following:

- The user session on the client
- Any resource sessions on the client that rely on NTLM authentication
- Any resource sessions on the network that rely on NTLM authentication

  > [!IMPORTANT]  
  > When the user accesses a resource on the network that requires NTLM authentication, the client presents cached credentials from the user security context. However, the resource server queries the domain controller for the most recent user information.

These resource sessions, including the user session on the client, do not expire. They continue to run until the user ends the session, such as when the user signs out of Windows. Locking and then unlocking the client does not end the existing sessions.

#### Resources that rely on Kerberos tickets

When the user connects to the VPN and then tries to access a network resource that relies on Kerberos tickets, the Kerberos Key Distribution Center (KDC) gets the user's information from Active Directory. The KDC uses information from Active Directory to authenticate the user and create a ticket-granting-ticket (TGT). The group membership information in the TGT is up-to-date at the time that the TGT is created.

Windows then uses the TGT to get a session ticket for the requested resource. The session ticket, in turn, uses the group information from the TGT.

The client caches the TGT and continues to use it each time the user starts a new resource session, whether local or on the network. The client also caches the session ticket so that it can continue to connect to the resource (such as when the resource session expires). When the session ticket expires, the client resubmits the TGT for a fresh session ticket.

> [!IMPORTANT]
> If the user's group membership changes after the user has started resource sessions, the following factors control when the change actually affects the user's resource access:  
>  
> - **A change in group membership does not affect existing sessions.**  
  Existing sessions continue until either the user signs out or otherwise ends the session, or until the session expires. When a session expires, one of the following things occurs:
>   - The client resubmits the session ticket or submits a new session ticket. This operation renews the session.
>   - The client does not try to connect again. The session does not renew.
> - **A change in group membership does not affect the current TGT, or any session tickets that are created by using that TGT.**  
  The ticket granting service (TGS) uses the group information from the TGT to create a session ticket instead of querying Active Directory itself. The TGT isn't renewed until the user locks the client or signs out, or until the TGT expires (typically 10 hours). A TGT can be renewed for 10 days.

You can use the [klist command](/windows-server/administration/windows-commands/klist) to manually purge a client's ticket cache.

> [!NOTE]  
> The ticket cache stores tickets for all of the user sessions on the computer. You can use the `klist` command-line options to target the command to specific users or tickets.

### Effects on start-up and sign-in processes

The Group Policy service is optimized to speed up the application of group policy and to reduce adverse effects on client performance. For more information, see [Understand the Effect of Fast Logon Optimization and Fast Startup on Group Policy](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/jj573586(v=ws.11)). This article provides an in-depth explanation of how Group Policy interacts with start-up and sign-in processes. The Group Policy service can run in the foreground (at startup or sign-in) or in the background (during the user session). The service processes Group Policy in the following manner:

- *Asynchronous processing* refers to processes that do not depend on the outcome of other processes.
- *Synchronous processing* refers to processes that depend on each other's outcome. Therefore, synchronous processes must wait for the previous process to finish before the next process can start.

The following table summarizes the events that trigger foreground or background processing, and whether the processing is synchronous or asynchronous.

|Trigger |Synchronous or Asynchronous |Foreground or background |
| --- | --- | --- |
|Computer startup or shutdown |Synchronous or asynchronous |Foreground |
|User sign-in or sign-out |Synchronous or asynchronous |Foreground |
|Scheduled (during the user session) |Asynchronous |Background |
|User action (`gpupdate /force`) |Asynchronous |Background |

In order to apply configuration changes, some client-side extensions (CSEs) require synchronous processing (at user sign-in or computer startup). In such cases, the CSE identifies the need for a change during background processing. The next time that the user signs in or the computer starts up, the CSE completes the change as part of the synchronous processing phase.

Some of these CSEs have an additional complication: They have to connect to domain controllers or other network servers while the synchronous processing runs. The Folder Redirection and Scripts CSEs are two of the CSEs in this category.

This design works effectively in an office environment. However, in a working-at-home environment, the user might not sign out and back in while connected to the domain. Synchronous processing has to finish before the client contacts a domain controller or any other server. Therefore, some policies cannot be applied or updated correctly.

For example, a change in folder redirection requires all the following:

- Foreground synchronous processing (during user sign-in).
- Connection to a domain controller. The connection must be available while the processing runs.
- Connection to the file server that hosts the redirect target folders. The connection must be available while the processing runs.

In fact, this change can involve two sign-ins. During the first sign-in, the Folder Redirection CSE on the client detects the need for a change and requests the foreground synchronous processing run. During the next sign-in, the CSE implements the policy change.

### Effects on Group Policy reporting

The Group Policy service maintains group membership information on the client, in Windows Management Instrumentation (WMI), and in the registry. The WMI store is used in the Resultant Set of Policy report (produced by running `gpresult /r`). It is not used to make decisions about which GPOs are applied.

> [!NOTE]  
> You can turn off the Resultant Set of Policy reporting function by enabling the [Turn off Resultant Set of Policy logging](https://gpsearch.azurewebsites.net/#347) policy.

In the following circumstances, the Group Policy service doesn't update the group information in WMI:

- Group Policy is running in the background. For example, during periodic refreshes after the computer has started or a user has signed in, or when a user runs the `gpupdate /force` command to refresh Group Policy.
- Group Policy is running from the Group Policy cache. For example, when the user signs in while the client does not have access to a domain controller.

This behavior means that the group list on a VPN-only client might always be stale because the Group Policy service cannot connect to the network during user sign-in. When Group Policy runs and does not update the group information in WMI, the Group Policy service might record an event that resembles the following:

> GPSVC(231c.2d14) 11:56:10:651 CSessionLogger::Log: restoring old security grps

You can be certain that WMI and the output of `gpresult /r` is updated only when the following line appears in the Group Policy service log for the account that you are examining:

> GPSVC(231c.2d14) 11:56:10:651 CSessionLogger::Log: logging new security grps

## Resolution

To resolve the problems that this article describes, use a VPN solution that can establish a VPN connection to a client before the user signs in.

## Workarounds

If you cannot use a VPN that establishes a client connection before the user signs in, these workarounds can mitigate the problems that this article describes.

### Workaround for user security context and access control

After you add a user to a group or remove a user from a group, provide the following steps to the user. This procedure provides the only supported workaround that refreshes the user security context on clients that do not connect to the VPN before the user signs in.

> [!IMPORTANT]  
> Allow enough time for the membership change to replicate among the domain controllers before you have the user start this procedure.

1. Sign in to the client computer, and then connect to the VPN as you usually do.
2. When you are sure that the client computer is connected to the VPN, lock Windows.
3. Unlock the client computer, and then sign out of Windows.
4. Sign in to Windows again.

The group membership information (and resource access) is now up-to-date.

You can verify the group membership information by opening a Command Prompt window, and then running `whoami /all`.

> [!NOTE]  
> You can use the following Windows PowerShell script to automate the lock and unlock steps of this procedure. In this process, the user has to sign in to Windows, and then has to sign out of Windows after the script runs.
>  
> ```powershell
> $fullname = $env:userdnsdomain + "\" + "$env:username" 
> $MyCred = Get-Credential -Username $fullname -Message "Update Logon Credentials"
> Start-Process C:\Windows\System32\cmd.exe -ArgumentList ("/C", "exit 0") -Credential $MyCred -WindowStyle Hidden -PassThru -Wait
> ```

### Workaround for sign-in processes, including Group Policy

You can mitigate some problems by making configuration changes manually, by making script changes so that scripts can run after the user signs in, or by having the user connect to the VPN and then sign out of Windows. You may have to combine these approaches. For Group Policy, in particular, the key is to understand when and how Group Policy can function.

> [!NOTE]  
> Mapped drive connections and logon scripts do not have the same foreground synchronous processing requirements as folder redirections, but they do require domain controller and resource server connectivity.

For a detailed list of the processing requirements of Group Policy CSEs, see [Understand the Effect of Fast Logon Optimization and Fast Startup on Group Policy](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/jj573586(v=ws.11)).
