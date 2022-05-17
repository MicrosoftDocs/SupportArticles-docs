---
title: Can't migrate Google Workspace mailboxes to Microsoft 365
description: Unable to migrate mailboxes from Google Workspace to Microsoft 365 because the app passwords aren't set for these mailboxes. 
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 163330
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: shahmul
appliesto: 
  - Exchange Online
  - Microsoft 365
search.appverid: MET150
ms.date: 5/17/2022
---
# Mailbox migration from Google Workspace to Microsoft 365 fails with error "Application-specific password required"

## Symptoms

When you perform a mailbox migration from Google Workspace (formerly known as G Suite) to Microsoft 365, you receive the following error message:

> Error MigrationPermanentExeption: Special credentials are required in order to access this IMAP account. --> Special credentials are required in order to access this IMAP account. --> Imap server reported an error during LoginCommand with the following alert: 'Application-specific password required: `https://support.google.com/accounts/answer/185833` (failure).

Additionally, if you review the migration diagnostic report by running the following cmdlet, you see the similar error message in the report.

```powershell
Get-MigrationUserStatistics -IncludeReport -Identity user@domain.com| FL
```

## Cause

This issue occurs because the app password is not set for the Google Workspace mailbox in the migration. In this scenario, Microsoft 365 migration service can't access the Google Workspace mailbox.

**Note:** When you try to perform a migration from Google Workspace to Microsoft 365, you must have the 2-step verification (also known as multifactor authentication) and app password enabled. For more information, see [Prepare your Gmail or Google Workspace account for connecting to Outlook and Microsoft 365 or Office 365](\/exchange/mailbox-migration/migrating-imap-mailboxes/prepare-gmail-or-g-suite-accounts#enable-your-gmail-to-be-connected-by-microsoft-365-or-office-365).

## Resolution

To resolve this issue, set up the app password for the Google Workspace mailbox.

1. Sign in to the Google Workspace mailbox.
2. Select the mailbox account (profile), and then select **Manage your Google Account**.

    :::image type="content" source="media/google-workspace-mailbox-migration-fail/google-profile.png" alt-text="Screenshot of the account page with the Manage your Google Account button.":::

3. Select the **Security** tab.

    :::image type="content" source="media/google-workspace-mailbox-migration-fail/google-account.png" alt-text="Screenshot of the Google Account page. The Security menu is selected.":::

4. Under **Signing into Google**, select **App passwords**, and you'll be prompted for the user password. Then, enter the Google Workspace user password.

    :::image type="content" source="media/google-workspace-mailbox-migration-fail/app-password.png" alt-text="Screenshot of the Signing into Google page. The App passwords option is highlighted.":::

5. In the **Select app** drop-down list, select **Other *(Custom name)***.

    :::image type="content" source="media/google-workspace-mailbox-migration-fail/select-app.png" alt-text="Screenshot of the App passwords page. The Other (custom name) option is highlighted in the Select app drop down.":::

6. Enter a name, for example *Migration*, and then select **GENERATE**.
7. Note the generated app password and select **DONE**.

    :::image type="content" source="media/google-workspace-mailbox-migration-fail/generate-password.png" alt-text="Screenshot of the Generated app password page with the password.":::

8. In the migration CSV file, specify the generated app password in the **Password** column.

    :::image type="content" source="media/google-workspace-mailbox-migration-fail/migration-csv.png" alt-text="Screenshot of the migration CSV file. The Password column has no app password.":::

9. Launch the migration wizard in the Exchange admin center.
10. Locate the failed migration batch, select the affected mailbox, and then select **Resume migration**.

    :::image type="content" source="media/google-workspace-mailbox-migration-fail/resume-migration.png" alt-text="Screenshot of the migration batches page. The Resume migration button is highlighted.":::

11. Wait until the migration is completed successfully.

    :::image type="content" source="media/google-workspace-mailbox-migration-fail/migration-synced.png" alt-text="Screenshot of a successful migration example that shows the status Synced":::

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-information-disclaimer.md)]
