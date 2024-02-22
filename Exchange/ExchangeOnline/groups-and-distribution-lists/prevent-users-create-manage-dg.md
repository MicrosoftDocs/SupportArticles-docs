---
title: Prevent users from creating and managing distribution groups in Microsoft 365
description: Users can create and manage distribution groups in Microsoft 365, but organizations may not want to allow this. Describes how Exchange Online admins can disable this functionality.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
ms.date: 01/24/2024
ms.reviewer: v-six
---
# How to prevent users from creating and managing distribution groups in Microsoft 365

## Introduction

Users in a Microsoft 365 environment can create distribution groups and manage those distribution groups. As an admin, you may want to prevent users or a subset of users from creating and managing distribution groups.

## Procedure

The functionality to create and manage distribution groups is available to users in organizations that don't use directory synchronization to sync users and groups from the on-premises environment to Microsoft 365. Exchange Online admins can disable this functionality so that users can't create and manage their own distribution groups. To do this, follow these steps:

### Step 1: Edit the default role assignment policy or create a new role assignment policy

Depending on the particular scenario and the kind of organization, Exchange Online admins have two options for using a role assignment policy to control whether users can create and manage distribution groups. These options are as follows:

- If you want to apply the policy to all users in your organization, edit the default role assignment policy.
- If you have already created several role assignment policies or if you only want to disable this feature for a subset of users in your organization, create a new role assignment policy.

Do one of the following things, as appropriate for your situation:

- Edit the default role assignment policy

  To edit the default role assignment policy, follow these steps:
   1. Sign in to the Microsoft 365 portal as an admin, click **Admin**, and then click **Exchange** to open the Exchange admin center.
   2. In the left navigation pane click **permissions**, and then click **user roles**.
   3. Double-click **Default Role Assignment Policy**.
   4. Click to clear the **MyDistributionGroups** check box and the **MyDistributionGroupMembershipcheck** box.
   5. Click **Save**.

- Create a new role assignment policy

  To create a new role assignment policy, follow these steps:
  1. Sign in to the Microsoft 365 portal as an admin, click **Admin**, and then click **Exchange** to open the Exchange admin center.
  2. In the left navigation pane click **permissions**, and then click **user roles**.
  3. Click **New** (:::image type="icon" source="media/prevent-users-create-manage-dg/new.png" border="false":::).
  4. Type a name for the new role assignment policy, and then click to select the options that you want. Make sure that the **MyDistributionGroups** check box and the **MyDistributionGroupMembershipcheck** box are cleared.
  5. Click **Save**.

### Step 2: Apply the role assignment policy

> [!IMPORTANT]
> If you only use one role assignment policy in your organization, you don't have to follow this step.

After you set up the role assignment policy, apply the policy. Be aware that if you changed the default role assignment policy, you don't have to reapply it. However, if you created a new role assignment policy, you must apply it to users in your organization.

To apply the role assignment policy, use one of the following methods, as appropriate for your situation.

- Manually apply the role assignment policy to one user by using the Exchange admin center

  To apply the role assignment policy to one user, follow these steps:

  1. Sign in to the Microsoft 365 portal as an admin, click **Admin**, and then click **Exchange** to open the Exchange admin center.
  2. In the left navigation pane, click **recipients**, and then click **mailboxes**.
  3. Double-click the mailbox to which you want to apply the policy.
  4. In the mailbox details window, click **mailbox features**, and then in the **Role assignment policy** box, select the policy that you want to apply.
  5. Click **Save**.

- Apply the role assignment policy to all users by using remote PowerShell

  To apply the role assignment policy to all users in the organization by using remote PowerShell, follow these steps:

  1. Connect to Exchange Online by using remote PowerShell. For more information about how to do this, see [Connect to Exchange Online using remote PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
  2. At the PowerShell prompt, type the following command, and then press Enter:

        ```powershell
        Get-Mailbox | Set-Mailbox –RoleAssignmentPolicy " <Name of Policy> "
        ```

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).