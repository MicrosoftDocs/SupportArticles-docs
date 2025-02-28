---
title: Troubleshooting access denied and user not authorized issues in RDS
description: Provides solutions to access denied and authorization issues that occur when you try to connect to a remote computer by using Remote Desktop Services.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: heshamelkouha, kaushika, v-tappelgate
ms.custom:
- sap:remote desktop services and terminal services\deployment,configuration,and management of remote desktop services infrastructure
- pcy:WinComm User Experience
---
# Troubleshooting access denied and user not authorized issues in Microsoft Remote Desktop Services

This article helps you troubleshoot "Access is Denied" and "User is not authorized" errors that occur when you try to connect to a remote computer.

_Applies to:_ &nbsp; Windows Server 2012 and later versions  

## Symptoms

When you try to connect to a Windows computer or virtual machine by using Remote Desktop Protocol (RDP), you receive a message that resembles one of the following messages:

> Access is denied.

> User is not authorized.

## Causes

The most common "access denied" messages, and the most likely causes or circumstances of each, are as follows:

- **Access is denied.** This error usually indicates that the user who is trying to connect doesn't have the necessary permission to access the remote server.
- **The connection was denied because the user account is not authorized for remote login.** This error suggests that the user's account doesn't have the correct user access rights to establish an RDP connection to the target server.
- **To sign in remotely, you need the right to sign in through Remote Desktop Services.** This error is usually related to Remote Desktop Services (connecting to an RDS farm), not a standalone RDP connection.
- **The requested session access is denied** or **Account restriction is preventing this user from signing in.** This error usually means that restrictions such as Credential Guard are preventing access.

## Troubleshooting checklist

There are many potential issues that can cause "access denied" issues for RDP users. To narrow the list of possible causes and provide a starting point for further troubleshooting, consider the following:

1. Does the issue affect one user, or more than one user?
   An issue that affects one user indicates that an issue exists in that user's configuration or permissions. For more information, see [Common issues](#common-issues).

1. Does the issue affect both administrative users and regular users?
   This behavior might indicate an issue that relates to security group settings. For more information, see [Common issues](#common-issues).

1. Does the user have the correct permissions to access the remote computer in a non-RDP context (for example, can the user sign in the computer locally)?
   In this case, the user might have a general access issue instead of an RDP issue. You might have to contact your Active Directory administrator for assistance.

1. Is the remote computer reachable?
   - If the user typically connects by using a non-Microsoft client, can the user connect by using an alternative connection method, such as the Remote Desktop Web application (RD Web) or the Remote Desktop Connection application (Mstsc.exe)?
      If the issue involves a non-Microsoft app, you might have to contact the app provider for assistance.
   - Can you start an administrative RDP connection? To do this, open a Windows Command Prompt window, and enter *mstsc /admin*.
   - Can a user or administrator connect to the destination computer at all? For example, can an administrator successfully connect by using the `ping` or `nslookup` commands?
      If these commands don't work, there might be a network, port, or DNS issue instead of an RDP issue.

1. Is the remote computer a domain controller?
   Only members of the **Domain Admins** group can use RDP to connect to a domain controller.

## Common issues

The following sections provide more specific troubleshooting information:

- [Troubleshoot permissions](#troubleshoot-permissions)
- [Troubleshoot permissions for session collections and apps](#troubleshoot-permissions-for-session-collections-and-apps)
- [Troubleshoot user access rights](#troubleshoot-user-access-rights)
- [Troubleshoot "Account restriction is preventing this user from signing in"](#troubleshoot-account-restriction-is-preventing-this-user-from-signing-in)
- [Troubleshoot SAM access restriction](#troubleshoot-sam-access-restriction)
- [Troubleshoot Remote Desktop Services service issues](#troubleshoot-remote-desktop-services-service-issues)

### Troubleshoot permissions

To check permissions at the forest level, follow these steps:

1. Open the Active Directory Users and Computers MMC snap-in (available on the **Tools** menu in Server Manager).
1. Under the domain node, select **Built-in**, right-click **Remote Desktop Users**, and then select **Properties**.
1. Make sure that the user is a member of the group.

If the remote computer isn't a domain member, check permissions at the remote computer level. Follow these steps:

1. On the remote computer, open the Local Users and Groups (Lusermgr.msc) tool.
1. Select **Groups** > **Remote Desktop Users**, and make sure that the user is a member of the group.

### Troubleshoot permissions for session collections and apps

If you're using collections to manage your RDS offerings, you have additional layers of authorization to work with. To check that the user has access to the collection, follow these steps:

1. On the RD Session Host, in Server Manager, select **Remote Desktop Services** > **Collections** > **\<*CollectionName*>**.
   > [!NOTE]  
   > In this sequence, \<*CollectionName*> represents the name of the collection that you want to manage.
1. Check the **User Group** item in the collection's **Properties** list. Do one of the following:
   - Add the user to a group that is already listed (such as by using Active Directory User's and Computers).
   - To add a group to the collection, locate the area that's above the **Properties** list, select **Tasks** > **Edit Properties** > **User Groups**, and then select **Add**.
1. To check permissions for a particular app in the collection, locate the app in the **RemoteApp Programs** list, right-click the app, and then select **Edit Properties** > **User Assignment**. To make changes, follow the instructions on the **User Assignment** page.

### Troubleshoot user access rights

Make sure that the user account belongs to a group that has the right to sign in remotely to the remote computer. Use the following procedures, depending on how you manage the user access rights on the remote computer. Remember that Group Policy settings override Local Security Policy settings.

If you use Group Policy at the domain level, follow these steps:

1. On the Server Manager **Tools** menu, open the Group Policy Management Console (GPMC), right-click the Group Policy Object (GPO) that controls the remote computer, and then select **Edit** to open the Group Policy Editor.
1. Select **Computer Configuration** > **Policies** > **Windows Settings** > **Security Settings** > **Local Policies** > **User Rights Assignment**.
1. Select **Allow logon through Remote Desktop Services**. If the policy is enabled, right-click **Allow logon through Remote Desktop Services**, and then select **Properties**.
   If the policy isn't defined, see the next procedure to check the local security policy.
1. Check the groups that have been assigned this right.
   If the user doesn't belong to a group that has this right, either add the group to the policy or add the user to one of the groups that is already configured.

If you use local security policy, follow these steps:

1. On the remote computer, open Local Security Policy.
1. Select **Security Settings** > **Local Policies** > **User Rights Assignment**.
1. Select **Allow logon through Remote Desktop Services**, and check the list of groups in **Security Settings**.
   If the user doesn't belong to a group that has this right, either add the group to the policy or add the user to one of the groups that is already configured.
1. To add a group to the policy, right-click the policy, and then select **Properties**. Select **Add User or Group**, and then select a group.

### Troubleshoot "Account restriction is preventing this user from signing in"

The message, "Account restriction is preventing this user from signing in," typically means that [Credential Guard](/windows/security/identity-protection/credential-guard/) is restricting user access.

Credential Guard affects only direct connections to remote computers. It's not supported for connections that use RD Connection Broker or RD Gateway. For more information about how to use Credential Guard, see [User can't authenticate or must authenticate twice](cannot-authenticate-must-authenticate-twice.md).

### Troubleshoot SAM access restriction

If the **Restrict clients allowed to make remote calls to SAM** policy is enabled, it might prevent users from connecting to remote computers. This policy controls which users can enumerate users and groups in the local Security Accounts Manager (SAM) database and Active Directory. The policy is present in Windows Server 2016 and later versions.

To check this policy, follow these steps:

1. In Group Policy Editor, select **Computer Configuration** > **Policies** > **Windows Settings** > **Security Settings** > **Local Policies** > **Security Options**.
1. Check the status of the **Network access: Restrict clients allowed to make remote calls to SAM** policy.
1. If this policy is enabled, review [Network access: Restrict clients allowed to make remote calls to SAM](/previous-versions/windows/it-pro/windows-10/security/threat-protection/security-policy-settings/network-access-restrict-clients-allowed-to-make-remote-sam-calls).
   > [!IMPORTANT]  
   > This policy is a security setting that can't be added or removed by using predefined Group Policy settings. It does, however, have an audit-only mode. The linked article provides information about how to configure audit-only mode and how to use audit-only mode in a test environment.

### Troubleshoot Remote Desktop Services service issues

You can use the Services MMC snap-in (Services.msc, also available on the **Tools** menu in Server Manager) to manage the services locally or remotely. You can also use PowerShell to manage the services locally or remotely (if the remote computer is configured to accept remote PowerShell cmdlets).

If the issue involves a direct RDP connection to the remote computer, check the status of the service on the remote computer. If the service isn't running, start it.

If you're using a larger-scale deployment of RD Session Host servers, check the status of the service on the RD Session Host servers. If the service isn't running, start it.

If you're running versions of Windows Server that are earlier than Windows Server 2016, you might encounter an issue in which the remote computer or RD Session Host server can't query the domain controller correctly for user information. If you suspect that you have this issue, see [Server freezes or user logon is slow when connecting to Windows Server 2012 R2 by using RDP](../performance/sbsl-issue-create-rdp-connection-to-computer.md).  
