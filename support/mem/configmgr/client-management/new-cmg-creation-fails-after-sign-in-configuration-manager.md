---
title: New CMG creation fails after entering sign-in credentials in Configuration Manager
description: Helps to resolve the issue in which a new Cloud Management Gateway (CMG) creation fails after entering sign-in credentials in Configuration Manager version 2207 or earlier versions.
ms.date: 12/05/2023
ms.reviewer: kaushika, disattana, umaikhan, v-lianna
---

# New CMG creation fails after entering sign-in credentials in Configuration Manager

This article helps to resolve the issue in which a new Cloud Management Gateway (CMG) creation fails after entering sign-in credentials in Configuration Manager version 2207 or earlier versions.

_Applies to:_ &nbsp; Configuration Manager current branch, versions 2207, 2203, and 2111

## Cause

The new CMG creation fails because the Configuration Manager console terminates unexpectedly after entering sign-in credentials in Configuration Manager.

When you try to create a CMG, there's a failure to obtain the Microsoft Graph token, and the `Microsoft.Identity.Client.MsalUiRequiredException` exception is referenced in the *SMSAdminUI.log* file.

This issue occurs in one of the following conditions:

- The `Prompt.Never` flag is passed, but the constraint can't be honored because user interaction is required.
- An error occurs during a silent web authentication that prevents the HTTP authentication flow from completing in a short enough time frame.

## Resolution

> [!NOTE]
> This issue doesn't occur in Configuration Manager version 2211.

To fix this issue, use one of the following methods:

- If you're running Configuration Manager version 2207, install the [hotfix rollup (KB15152495)](/mem/configmgr/hotfix/2207/15152495).

    > [!NOTE]
    > To get the hotfix, go to the **Administration** workspace, select the **Updates and Servicing** node, and then select **Check for updates** in the ribbon.

- If you're running Configuration Manager version 2203, install the [limited release hotfix](https://configmgrbits.azureedge.net/qfe/2203/KB15986968_9078.1030/CM2203-KB15986968.ConfigMgr.Update.exe) to address this issue.

    Prerequisite: To install the hotfix, you must have the [hotfix rollup KB14244456](/mem/configmgr/hotfix/2203/14244456) installed.

- If you're running Configuration Manager version 2111, install the [limited release hotfix](https://configmgrbits.azureedge.net/qfe/2111/KB15986968_9068.1033/CM2111-KB15986968.ConfigMgr.Update.exe) to address this issue.

    Prerequisite: To install the hotfix, you must have the [hotfix rollup KB12896009](/mem/configmgr/hotfix/2111/12896009) installed.

For more information about installing the out-of-band update, see [Use the update registration tool to import hotfixes](/mem/configmgr/core/servers/manage/use-the-update-registration-tool-to-import-hotfixes).
