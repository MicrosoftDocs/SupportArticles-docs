---
title: Can't migrate Google Workspace mailboxes to Microsoft 365
description: Unable to migrate mailboxes from Google Workspace to Microsoft 365 because the app passwords aren't set for these mailboxes. 
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Migration
  - CI 163330
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: shahmul, ninob
appliesto: 
  - Exchange Online
  - Microsoft 365
search.appverid: MET150
ms.date: 01/24/2024
---
# Error during mailbox migration from Google Workspace to Microsoft 365

## Symptoms

When you do a mailbox migration from Google Workspace to Microsoft 365, the migration fails and returns the following error message:

> Error MigrationPermanentException: Special credentials are required in order to access this IMAP account. --> Imap server reported an error during LOGIN with the following alert: 'Application-specific password required: `https://support.google.com/accounts/answer/185833` (Failure).

If you generate a diagnostic report about the migration, you'll see the same error message listed in the report.

## Cause

To migrate a mailbox from Google Workspace to Microsoft 365, you must set up 2-step verification and an app password for the mailbox.

If the Google Workspace mailbox isn't assigned an app password, the Microsoft 365 migration service can't access it during the migration. Instead, the service displays an error message.

## Resolution

To resolve this issue, set up an app password for the Google Workspace mailbox:

1. Sign in to the Google Workspace mailbox.
2. Select the mailbox account (profile), and then select **Manage your Google Account**.

    :::image type="content" source="media/google-workspace-mailbox-migration-fail/google-profile.png" alt-text="Screenshot of the account page with the Manage your Google Account button." border="false":::

3. Select the **Security** tab.

    :::image type="content" source="media/google-workspace-mailbox-migration-fail/google-account.png" alt-text="Screenshot of the Google Account page. The Security menu is selected." border="false":::

4. Under **Signing in to Google**, select **App passwords**.

    :::image type="content" source="media/google-workspace-mailbox-migration-fail/app-password.png" alt-text="Screenshot of the Signing into Google page. The App passwords option is highlighted." border="false":::

5. Enter the password to sign in to your Google Workspace account.

6. In the **Select app** list, select **Other *(Custom name)***.

    :::image type="content" source="media/google-workspace-mailbox-migration-fail/select-app.png" alt-text="Screenshot of the App passwords page. The Other (custom name) option is highlighted in the Select app list." border="false":::

7. Enter a name, such as *Migration*, and then select **GENERATE**.
8. Note the generated app password, and then select **DONE**.

    :::image type="content" source="media/google-workspace-mailbox-migration-fail/generate-password.png" alt-text="Screenshot of the Generated app password page with the password." border="false":::

9. In the CSV file for the migration, add the generated app password in the **Password** column.

    :::image type="content" source="media/google-workspace-mailbox-migration-fail/migration-csv.png" alt-text="Screenshot of the migration CSV file. The Password column has no app password.":::

10. Start the migration wizard in the Exchange admin center.
11. Locate the failed migration batch, select the affected mailbox, and then select **Resume migration**.

    :::image type="content" source="media/google-workspace-mailbox-migration-fail/resume-migration.png" alt-text="Screenshot of the migration batches page. The Resume migration button is highlighted." border="false":::

The migration should finish successfully.

:::image type="content" source="media/google-workspace-mailbox-migration-fail/migration-synced.png" alt-text="Screenshot of a successful migration example that shows the status as synced." border="false":::

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-information-disclaimer.md)]
