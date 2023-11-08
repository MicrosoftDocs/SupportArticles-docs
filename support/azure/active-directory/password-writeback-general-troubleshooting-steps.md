---
title: General password writeback troubleshooting steps
description: Review general steps to help you troubleshoot password writeback issues in Microsoft Entra ID.
ms.date: 11/03/2023
ms.reviewer: jarrettr, nualex, v-leedennis
editor: v-jsitser
ms.service: active-directory
ms.subservice: enterprise-users
ms.custom: has-azure-ad-ps-ref, azure-ad-ref-level-one-done
keywords:
#Customer intent: As a Microsoft Entra administrator, I want to understand how to troubleshoot password writeback issues better so that I can more quickly resolve problems that affect password writeback.
---
# General password writeback troubleshooting steps

This article describes general troubleshooting steps to resolve password writeback issues. These steps are a good way to start the process if you have to consult other content that explains more specific issues.

## Focus on the exact failure scenario

You should be consistent about how the password issue is reproduced or tested. Understand exactly what the failure scenario is, and learn the repro steps. Because a password reset and a password change are two different operations, focus on one operation, and use the same steps for that operation to reproduce the issue. The difference between the operations is as follows.

| Operation | Characteristics |
| --------- | --------------- |
| Password reset | The user or administrator doesn't know or doesn't provide the current password. |
| Password change | Only a user can initiate a password change. Users have to enter their current password before they can specify a new password. |

## Contrast working versus nonworking users

Does the operation fail for one user but succeed for another user? In this situation, try to determine the differences between a working and nonworking user. You can use the following steps:

1. Get information about certain Active Directory users by running the [Ldifde](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc731033(v=ws.11)) command or the [Get-ADUser](/powershell/module/activedirectory/get-aduser) PowerShell cmdlet.

1. Run [user commands in Microsoft Graph PowerShell](/powershell/microsoftgraph/find-mg-graph-command) to get information about those users in [Microsoft Graph PowerShell](/powershell/microsoftgraph/overview).

1. Compare the Active Directory and Microsoft Graph PowerShell information about those two users offline, especially in terms of:

    - Administrator roles and groups
    - Organizational unit placement
    - The last time that the object and password were synced
    - Other differences

    Keep this information handy while you're troubleshooting an issue.

## Use the same domain controller

Try to use the same domain controller every time that you test or make changes. To control which domain controller is getting contacted for password writeback operations, set a single preferred domain controller in the Active Directory Connector, and then restart the ADSync service. Change the preferred domain controller to the nearest one, or use the domain controller that owns the primary domain controller (PDC) emulator role.

To set the preferred domain controller, follow these steps:

1. Open the Synchronization Service Manager. To do this, select **Start**, enter *Microsoft Entra ID*, select the **Microsoft Entra Connect** group, and then select **Synchronization Service**.

1. Select the **Connectors** tab, and then select the applicable Active Directory connector. In the **Actions** pane, select **Properties** to open the **Properties** dialog box.

1. In the **Connector Designer** pane, select **Configure Directory Partitions**. In the **Configure Directory Partitions** pane, select a directory partition from the list.

1. In the **Domain controller connection settings** group, select the **Only use preferred domain controllers** checkbox. Then, select **Configure**.

1. Make the appropriate changes in the **Configure Preferred DCs** dialog box.

Depending on the issue, it might actually help to try different domain controllers, instead. Then, you can determine whether the issue can be isolated to a specific domain controller or occurs on any domain controller.

In addition, when you use the Active Directory Users and Computers snap-in, change the connected domain controller to the same one that you used for Microsoft Entra Connect. Follow these steps:

1. Open the Active Directory Users and Computers snap-in. To do this, select **Start**, search on *dsa.msc*, and then press Enter.

1. In the navigation pane, right-click the domain name, and then select the **Change Domain Controller** menu item.

1. In the **Change Directory Server** dialog box, select the **This Domain Controller or AD LDS instance** option.

1. In the list of domain controllers, select the domain controller that matches the one that you selected for Microsoft Entra Connect, and then select **OK**.

## Temporarily relax the local Active Directory password policy

To troubleshoot password writeback operations, we recommend that you temporarily modify the local [Active Directory password policy](/windows/security/threat-protection/security-policy-settings/password-policy). Set the [minimum password age](/windows/security/threat-protection/security-policy-settings/minimum-password-age) to zero to allow users to change their password more than one time consecutively. If [password complexity is required](/windows/security/threat-protection/security-policy-settings/password-must-meet-complexity-requirements), use a combination of uppercase letters, lowercase letters, and numerals. Because [password history is usually enforced](/windows/security/threat-protection/security-policy-settings/enforce-password-history) to a default of 24 remembered passwords, always use another password in every reset or change attempt. For example, increment an integer suffix (1, 2, 3, and so on) for every reset or change.

## Check application events by using the Event Viewer

These troubleshooting articles for specific password writeback issues contain many examples of application events that provide details about the issues. These examples show that the Event Viewer snap-in (*Eventvwr.msc*) is the most effective Windows tool to troubleshoot password writeback.

## Identify the exact account name for the AD DS Connector

Recheck the name of the current account for the Active Directory Domain Connector. Make sure that this account has the same name as the account that the Microsoft Entra Connect server uses. To find this account name, see [Identify the AD DS Connector account](password-writeback-access-rights-permissions.md#identify-the-ad-ds-connector-account).

## Learn which writeback operations are supported or unsupported

To review the lists of supported and unsupported password writeback operations, see [How does self-service password reset writeback work in Microsoft Entra ID?](/azure/active-directory/authentication/concept-sspr-writeback).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
