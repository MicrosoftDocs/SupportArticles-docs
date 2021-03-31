---
title: App doesn't appear within Outlook
description: Dynamics 365 App for Outlook doesn't appear within Outlook.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# Microsoft Dynamics 365 App for Outlook does not appear within Outlook

This article provides a solution to an issue where the app doesn't appear within Outlook after deploying Dynamics 365 App for Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4345566

## Symptoms

After deploying Dynamics 365 App for Outlook, the app doesn't appear within Outlook.

## Cause

**Cause 1**: The version of Outlook or Exchange isn't supported.

**Cause 2**: Enable optional connected experiences setting is disabled in Outlook (applies to Microsoft 365 Apps for enterprise).

**Cause 3**: The Reading Pane isn't enabled.

**Cause 4**: The specific type of email you're viewing isn't supported by Office Apps or the Dynamics 365 app.

**Cause 5**: The app needs to be redeployed.

**Cause 6**: A Microsoft Exchange setting or group policy setting is restricting use of Office Apps.

## Resolution

**Resolution 1**  
Verify the version of Outlook and Exchange are supported by Dynamics 365 App for Outlook. For details of the supported configurations, see [Requirements](/dynamics365/outlook-app/deploy-dynamics-365-app-for-outlook#requirements).

**Resolution 2**  
If you're using Microsoft 365 Apps for enterprise, verify the **Enable optional connected experiences** setting is enabled:

1. Select **File** > **Office Account** > **Account Privacy** > **Manage Settings**.
2. Locate the setting **Enable optional connected experiences.**  
3. Verify this setting is enabled. If it's disabled, no add-ins will be displayed in Outlook.

    For more information about this setting, see [Use policy settings to manage privacy controls for Microsoft 365 Apps for enterprise](/deployoffice/privacy/manage-privacy-controls).

**Resolution 3**  
If you don't see the app appear when viewing a list of emails, but you do see the app when you open an email, verify the [Use and configure the Reading Pane to preview messages](https://support.microsoft.com/office/2fd687ed-7fc4-4ae3-8eab-9f9b8c6d53f0) is enabled in Outlook. Outlook Apps such as Dynamics 365 App for Outlook are intended to appear in the reading pane when viewing a list of emails.

**Resolution 4**  
Dynamics 365 App for Outlook is an Outlook Add-in. Some email types such as encrypted emails aren't available to use with Outlook Add-ins. For more information, see [Mailbox items available to add-ins](/office/dev/add-ins/outlook/outlook-add-ins-overview#mailbox-items-available-to-add-ins). In addition to the items not available for Office Apps, the Dynamics 365 App for Outlook doesn't currently support [delegate users](/dynamics365/outlook-app/faq#are-there-any-known-issues).

**Resolution 5**  
Access Dynamics 365 as a user with the System Administrator role. Navigate to **Settings**, and then select Dynamics 365 App for Outlook. Select the user in the list and then select **Add App To Outlook**.

If the user doesn't appear in this list, see [A user does not appear in the All Eligible Users list within the Dynamics 365 App for Outlook area](https://support.microsoft.com/help/4345543).

> [!NOTE]
> It may take up to 15 minutes to complete. If the user doesn't appear in this list, see [A user does not appear in the All Eligible Users list within the Dynamics 365 App for Outlook area.](https://support.microsoft.com/help/4345543).

After the status shows as **Added to Outlook**, close and reopen Outlook.

**Resolution 6**  
Dynamics 365 App for Outlook is an Office Add-in and use of Office Add-ins can be blocked in your organization. Check with your administrator to verify a setting such as those mentioned in the following articles aren't configured to block the use of Office Add-ins in your organization:

- [Apps for Outlook 2013 do not activate as expected in email messages](/outlook/troubleshoot/user-interface/apps-for-outlook-2013-do-not-activate-as-expected).
- [User not seeing add-ins](/office365/troubleshoot/access-management/user-not-seeing-add-ins#for-outlook-2016)
