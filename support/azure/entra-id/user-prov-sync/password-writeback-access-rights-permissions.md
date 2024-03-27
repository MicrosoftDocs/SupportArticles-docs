---
title: Troubleshoot password writeback access rights and permissions
description: Learn about preparatory troubleshooting steps involving the required access rights and permissions for password writeback.
ms.date: 06/02/2022
ms.reviewer: jarrettr, nualex, v-leedennis
ms.service: entra-id
ms.subservice: users
keywords:
#Customer intent: As a Microsoft Entra administrator, I want to learn about the required access rights and permissions for password writeback so that I can troubleshoot password writeback issues more easily.
---
# Troubleshoot password writeback access rights and permissions

This article describes the access rights and permissions that are required in the domain root, the user object, and the Builtin container in Active Directory. It also discusses the following items:

- Required domain group policies
- How to identify the Active Directory Domain Services (AD DS) Connector account that Microsoft Entra Connect uses
- How to check existing permissions on that account
- How to avoid replication issues

This information can help you troubleshoot specific problems that involve password writeback.

## Identify the AD DS Connector account

Before you check for password writeback permissions, verify the current AD DS Connector account (also known as the *MSOL_* account) in Microsoft Entra Connect. Verifying this account helps you avoid taking the wrong steps during password writeback troubleshooting.

To identify the AD DS Connector account:

1. Open the Synchronization Service Manager. To do this, select **Start**, enter *Microsoft Entra Connect*, select **Microsoft Entra Connect** in the search results, and then select **Synchronization Service**.

1. Select the **Connectors** tab, and then select the applicable Active Directory connector. In the **Actions** pane, select **Properties** to open the **Properties** dialog box.

1. In the left pane of the **Properties** window, select **Connect to Active Directory Forest**, and then copy the account name that appears as **User name**.

## Check existing permissions of the AD DS Connector account

To set the correct Active Directory permissions for password writeback, [use the built-in ADSyncConfig PowerShell module](/azure/active-directory/hybrid/how-to-connect-configure-ad-ds-connector-account#using-the-adsyncconfig-powershell-module). The ADSyncConfig module includes a method to [set permissions for password writeback](/azure/active-directory/hybrid/how-to-connect-configure-ad-ds-connector-account#permissions-for-password-writeback) by using the [Set-ADSyncPasswordWritebackPermissions](/azure/active-directory/hybrid/reference-connect-adsyncconfig#set-adsyncpasswordwritebackpermissions) cmdlet.

To check whether the AD DS Connector account (that is, the *MSOL_* account) has the correct permissions for a specific user, use one of the following tools:

- Active Directory Users and Computers snap-in on the Microsoft Management Console (MMC)
- Command prompt
- PowerShell

### Active Directory Users and Computers snap-in

Use the MMC snap-in for Active Directory Users and Computers. Follow these steps:

1. Select **Start**, enter *dsa.msc*, and then select the Active Directory Users and Computers snap-in in the search results.

1. Select **View** > **Advanced Features**.

1. In the console tree, find and select the user account that you want to check the permissions for. Then, select the **Properties** icon.

1. In the **Properties** dialog box for the account, select the **Security** tab, and then select the **Advanced** button.

1. In the **Advanced Security Settings** dialog box for the account, select the **Effective Permissions** tab. Then, in the **Group or user name** section, select the **Select** button.

1. In the **Select User, Computer, or Group** dialog box, select **Advanced** > **Find Now** to show the selection list. In the **Search results** box, select the *MSOL_* account name.

1. Select **OK** two times to return to the **Effective Permissions** tab in the **Advanced Security Settings** dialog box. Now, you can view the list of effective permissions for the *MSOL_* account that are assigned to the user account. The list of the default permissions that are required for password writeback is shown in the [Required permissions on the user object](#required-permissions-on-the-user-object) section in this article.

### Command prompt

Use the [dsacls](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc771151(v=ws.11)) command to display the access control lists (ACLs, or permissions) of the AD DS Connector account. The following command stores the command output in a text file, although you can modify it to display the output on the console:

```cmd
dsacls "CN=User01,OU=Sync,DC=Contoso,DC=com" > dsaclsDomainContoso.txt
```

You can use this method to analyze the permissions for any Active Directory object. However, it isn't useful to compare permissions between objects because the text output isn't sorted.

### PowerShell

Use the [Get-Acl](/powershell/module/microsoft.powershell.security/get-acl) cmdlet to get the AD DS Connector account permissions, and then store the output as an XML file by using the [Export-Clixml](/powershell/module/microsoft.powershell.utility/export-clixml) cmdlet, as follows:

```powershell
Set-Location AD:
Get-Acl "DC=Contoso,DC=com" | Export-Clixml aclDomainContoso.xml
```

The PowerShell method is useful for offline analysis. It lets you import the file by using the [Import-Clixml](/powershell/module/microsoft.powershell.utility/import-clixml) cmdlet. It also keeps the original structure of the ACL and its properties. You can use this method to analyze the permissions for any Active Directory object.

## Avoid replication issues when fixing permissions

When you fix Active Directory permissions, the changes to Active Directory might not take effect immediately. Active Directory permissions are also subject to replications across the forest in the same manner that Active Directory objects are. How do you mitigate the Active Directory replication issues or delays? You set a preferred domain controller in Microsoft Entra Connect, and work on only that domain controller for any changes. When you use the Active Directory Users and Computers snap-in, right-click the domain root in the console tree, select the **Change Domain Controller** menu item, and then pick the same preferred domain controller.

For a quick sanity check within Active Directory, run domain controller diagnostics by using the [dcdiag](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc731968(v=ws.11)) command. Then, run the [repadmin /replsummary](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc770963(v=ws.11)) command to view a summary of replication problems. The following commands store the command output to text files, although you can modify them to display the output on the console:

```cmd
dcdiag > dcdiag.txt
repadmin /replsum > replsum.txt
```

## Required permissions on the Active Directory domain root

This section describes the expected Active Directory permissions for password writeback on the Active Directory domain root. Don't confuse this root with the root of the Active Directory forest. A forest can have multiple Active Directory domains. Each domain must have the correct permissions set in its own root, so that password writeback can work for users in that domain.

You can view the existing Active Directory permissions in the security properties of the domain root. Follow these steps:

1. Open the Active Directory Users and Computers snap-in.

1. In the console tree, locate and select the Active Directory domain root, and then select the **Properties** icon.

1. In the **Properties** dialog box for the account, select the **Security** tab.

Each of the following subsections contains a table of domain root default permissions. This table shows the required permission entries for the group or user name that's in the subsection title. To view and modify the current permission entries to match the requirements for each group or user name, follow these steps for each subsection:

1. On the **Security** tab, select the **Advanced** button to view the **Advanced Security Settings** dialog box. The **Permissions** tab shows the current list of domain root permissions for each Active Directory identity (Principal).

1. Compare the current permissions list against the list of default permissions for each Active Directory identity (Principal).

1. If necessary, select **Add** to add required permission entries that are missing from the current list. Or, select a permission entry, and then select **Edit** to modify that entry to meet the requirement. Repeat this step until the current permission entries match the subsection table.

1. Select **OK** to accept the changes in the **Advanced Security Settings** dialog box and return to the **Properties** dialog box.

> [!NOTE]
> The permissions on the Active Directory domain root aren't inherited from any parent container.

### Root default permissions for the AD DS Connector account (Allow)

| Permission | Apply to |
| ---------- | -------- |
| Reset password | Descendant User objects |
| (blank) | Descendant msDS-Device objects |
| Replicating Directory Changes | This object only |
| Replicating Directory Changes All | This object only |
| Read all properties | Descendant publicFolder objects |
| Read/write all properties | Descendant InetOrgPerson objects |
| Read/write all properties | Descendant Group objects |
| Read/write all properties | Descendant User objects |
| Read/write all properties | Descendant Contact objects |

### Root default permissions for Authenticated Users (Allow)

| Permission | Apply to |
| ---------- | -------- |
| Enable per user reversibly encrypted password | This object only |
| Unexpire password | This object only |
| Update password not required bit | This object only |
| Special | This object only |
| (blank) | This object and all descendant objects |

### Root default permissions for Everyone (Deny + Allow)

| Type | Permission | Apply to |
| ---- | ---------- | -------- |
| Deny | Delete all child objects | This object only |
| Allow | Read all properties | This object only |

### Root default permissions for Pre-Windows 2000 Compatible Access (Allow)

| Permission | Apply to |
| ---------- | -------- |
| Special | Descendant InetOrgPerson objects |
| Special | Descendant Group objects |
| Special | Descendant User objects |
| Special | This object only |
| List contents | This object and all descendant objects |

### Root default permissions for SELF (Allow)

| Permission | Apply to |
| ---------- | -------- |
| (blank) | This object and all descendant objects |
| Special | All descendant objects |
| Validated write to computer attributes | Descendant Computer objects |
| (blank) | Descendant Computer objects |

## Required permissions on the user object

This section describes the expected Active Directory permissions for password writeback on the target user object that has to update the password. To view the existing security permissions, follow these steps to show the security properties of the user object:

1. Return to the Active Directory Users and Computers snap-in.

1. Use the console tree or the **Action** > **Find** menu item to select the target user object, and then select the **Properties** icon.

1. In the **Properties** dialog box for the account, select the **Security** tab.

Each of the following subsections contains a table of user default permissions. This table shows the required permission entries for the group or user name that's in the subsection title. To view and modify the current permission entries to match the requirements for each group or user name, follow these steps for each subsection:

1. On the **Security** tab, select the **Advanced** button to view the **Advanced Security Settings** dialog box.

1. Make sure that the **Disable Inheritance** button is displayed near the bottom of the dialog box. If the **Enable Inheritance** button is displayed instead, select that button. The enable inheritance feature allows all the permissions from parent containers and organizational units to be inherited by this object. This change resolves the issue.

1. On the **Permissions** tab, compare the current permissions list against the list of default permissions for each Active Directory identity (Principal). The **Permissions** tab displays the current list of user permissions for each Active Directory identity (Principal).

1. If necessary, select **Add** to add required permission entries that are missing from the current list. Or, select a permission entry, and then select **Edit** to modify that entry to meet the requirement. Repeat this step until the current permission entries match the subsection table.

1. Select **OK** to accept the changes in **Advanced Security Settings** dialog box and return to the **Properties** dialog box.

> [!NOTE]
> Unlike for the Active Directory domain root, the required permissions for the user object are usually inherited from the domain root, or from a parent container or organizational unit. Permissions that were set directly on the object will indicate an inheritance from **None**. The inheritance of the access control entry (ACE) isn't important as long as the values in the **Type**, **Principal**, **Access**, and **Applies to** columns for the permission are the same. However, certain permissions can be set only in the domain root. These entities are listed in the subsection tables.

### User default permissions for the AD DS Connector account (Allow)

| Permission | Inherited from | Apply to |
| ---------- | -------------- | -------- |
| Reset password | \<domain root> | Descendant User objects |
| (blank) | \<domain root> | Descendant msDS-Device objects |
| Read all properties | \<domain root> | Descendant publicFolder objects |
| Read/write all properties | \<domain root> | Descendant InetOrgPerson objects |
| Read/write all properties | \<domain root> | Descendant Group objects |
| Read/write all properties | \<domain root> | Descendant User objects |
| Read/write all properties | \<domain root> | Descendant Contact objects |

### User default permissions for Authenticated Users (Allow)

| Permission | Inherited from | Apply to |
| ---------- | -------------- | -------- |
| Read general information | None | This object only |
| Read public information | None | This object only |
| Read personal information | None | This object only |
| Read web information | None | This object only |
| Read permissions | None | This object only |
| Read Exchange information | \<domain root> | This object and all descendant objects |

### User default permissions for Everyone (Allow)

| Permission | Inherited from | Apply to |
| ---------- | -------------- | -------- |
| Change password | None | This object only |

### User default permissions for Pre-Windows 2000 Compatible Access (Allow)

The **Special** permissions in this table include **List contents**, **Read all properties**, and **Read permissions** rights.

| Permission | Inherited from | Apply to |
| ---------- | -------------- | -------- |
| Special | \<domain root> | Descendant InetOrgPerson objects |
| Special | \<domain root> | Descendant Group objects |
| Special | \<domain root> | Descendant User objects |
| List contents | \<domain root> | This object and all descendant objects |

### User default permissions for SELF (Allow)

The **Special** permissions in this table include **Read/Write private information** rights only.

| Permission | Inherited from | Apply to |
| ---------- | -------------- | -------- |
| Change password | None | This object only |
| Send as | None | This object only |
| Receive as | None | This object only |
| Read/write personal information | None | This object only |
| Read/write phone and mail options | None | This object only |
| Read/write web information | None | This object only |
| Special | None | This object only |
| Validated write to computer attributes | \<domain root> | Descendant Computer objects |
| (blank) | \<domain root> | Descendant Computer objects |
| (blank) | \<domain root> | This object and all descendant objects |
| Special | \<domain root> | This object and all descendant objects |

## Required permissions on the SAM server object

This section describes the expected Active Directory permissions for password writeback on the Security Account Manager (SAM) server object (CN=Server,CN=System,DC=Contoso,DC=com). To find the security properties of the SAM server object (samServer), follow these steps:

1. Return to the Active Directory Users and Computers snap-in.

1. In the console tree, locate and select the **System** container.

1. Locate and select **Server** (the samServer object), and then select the **Properties** icon.

1. In the **Properties** dialog box for the object, select the **Security** tab.

1. Select the **Advanced Security Settings** dialog box. The **Permissions** tab displays the current list of samServer object permissions for each Active Directory identity (Principal).

1. Verify that at least one of the following principals is listed in the access control entry for the samServer object. If only **Pre-Windows 2000 Compatible Access** is listed, make sure that **Authenticated Users** is a member of this built-in group.

### Permissions for Pre-Windows 2000 Compatible Access (Allow)

**Special** permissions must include the **List contents**, **Read all properties**, and **Read permissions** rights.

### Permissions for Authenticated Users (Allow)

**Special** permissions must include the **List contents**, **Read all properties**, and **Read permissions** rights.

## Required permissions on the Builtin container

This section describes the expected Active Directory permissions for password writeback on the Builtin container. To view the existing security permissions, follow these steps to get to the security properties of the built-in object:

1. Open to the Active Directory Users and Computers snap-in.

1. In the console tree, locate and select the **Builtin** container, and then select the **Properties** icon.

1. In the **Properties** dialog box for the account, select the **Security** tab.

1. Select the **Advanced** button to view the **Advanced Security Settings** dialog box. The **Permissions** tab displays the current list of Builtin container permissions for each Active Directory identity (Principal).

1. Compare this current permissions list against the list of required allow permissions for the *MSOL_* account, as follows.

    | Permission | Inherited from | Apply to |
    | ---------- | -------------- | -------- |
    | Read/write all properties | \<domain root> | Descendant InetOrgPerson objects |
    | Read/write all properties | \<domain root> | Descendant Group objects |
    | Read/write all properties | \<domain root> | Descendant User objects |
    | Read/write all properties | \<domain root> | Descendant Contact objects |

1. If necessary, select **Add** to add required permission entries that are missing from the current list. Or, select a permission entry, and then select **Edit** to modify that entry to meet the requirement. Repeat this step until the current permission entries match the subsection table.

1. Select **OK** to exit the **Advanced Security Settings** dialog box and return to the **Properties** dialog box.

## Other required Active Directory permissions

In the **Pre-Windows 2000 Compatible Access** group properties, go to the **Members** tab, and make sure that **Authenticated Users** is a member of this group. Otherwise, you might experience issues that affect password writeback on Microsoft Entra Connect and Active Directory (especially on older versions).

## Required domain group policies

To make sure that you have the correct domain group policies, follow these steps:

1. Select **Start**, enter *secpol.msc*, and then select **Local Security Policy** in the search results.

1. In the console tree, under **Security Settings**, expand **Local Policies**, and then select **User Rights Assignment**.

1. In the list of policies, select **Impersonate a client after authentication**, and then select the **Properties** icon.

1. In the **Properties** dialog box, make sure that the following groups are listed on the **Local Security Setting** tab:

    - Administrators
    - LOCAL SERVICE
    - NETWORK SERVICE
    - SERVICE

For more information, see the [default values for the **Impersonate a client after authentication** policy](/windows/security/threat-protection/security-policy-settings/impersonate-a-client-after-authentication#default-values).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
