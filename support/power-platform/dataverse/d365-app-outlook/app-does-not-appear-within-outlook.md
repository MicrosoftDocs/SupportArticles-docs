---
title: App doesn't appear within Outlook
description: Provides a solution to an issue where the app doesn't appear within Outlook after deploying Dynamics 365 App for Outlook.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 01/31/2023
ms.custom: sap:Dynamics 365 App for Outlook Add-In
---
# Microsoft Dynamics 365 App for Outlook doesn't appear within Outlook

There are several reasons why the Dynamics 365 App for Outlook may not appear within Outlook after deployment. This article describes the different causes and solutions.

_Applies to:_ &nbsp; Dynamics 365 App for Outlook  
_Original KB number:_ &nbsp; 4345566

## Symptoms

After deploying Dynamics 365 App for Outlook, the app doesn't appear within Outlook.

## Cause 1: The version of Outlook or Exchange isn't supported

#### Resolution

Verify that the version of Outlook and Exchange are supported by Dynamics 365 App for Outlook. For details of the supported configurations, see [Deploy and install Dynamics 365 App for Outlook](/dynamics365/outlook-app/deploy-dynamics-365-app-for-outlook).

## Cause 2: Enable optional connected experiences setting is disabled in Outlook (applies to Microsoft 365 Apps for enterprise)

#### Resolution

If you're using Microsoft 365 Apps for enterprise, verify that the **Enable optional connected experiences** setting is enabled:

1. Select **File** > **Office Account** > **Account Privacy** > **Manage Settings**.
2. Locate the **Enable optional connected experiences** setting.
3. Verify that this setting is enabled. If it's disabled, no add-ins will be displayed in Outlook.

    For more information about this setting, see [Use policy settings to manage privacy controls for Microsoft 365 Apps for enterprise](/deployoffice/privacy/manage-privacy-controls).

## Cause 3: The Reading Pane isn't enabled

#### Resolution

If you don't see the app appear when viewing a list of emails, but you do see the app when you open an email, verify that the [Use and configure the Reading Pane to preview messages](https://support.microsoft.com/office/2fd687ed-7fc4-4ae3-8eab-9f9b8c6d53f0) is enabled in Outlook. Outlook Apps such as Dynamics 365 App for Outlook are intended to appear in the reading pane when viewing a list of emails.

## Cause 4: The specific type of email you're viewing isn't supported by Dynamics 365 App for Outlook

#### Resolution

Dynamics 365 App for Outlook is an Outlook Add-in. Some email types such as encrypted emails aren't available to use with Outlook Add-ins. For more information, see [Mailbox items available to add-ins](/office/dev/add-ins/outlook/outlook-add-ins-overview#mailbox-items-available-to-add-ins).

## Cause 5: The app needs to be redeployed

#### Resolution

Access Dynamics 365 as a user with the System Administrator role. Navigate to **Settings**, and then select Dynamics 365 App for Outlook. Select the user in the list and then select **Add App To Outlook**.

> [!NOTE]
> It may take up to 15 minutes to complete. If the user doesn't appear in this list, see [A user does not appear in the All Eligible Users list within the Dynamics 365 App for Outlook area](../../../dynamics-365/sales/a-user-disappears-all-eligible-users.md).

After the status shows as **Added to Outlook**, close and reopen Outlook.

## Cause 6: A Microsoft Exchange setting or group policy setting is restricting use of Office Apps

#### Resolution

Dynamics 365 App for Outlook is an Office Add-in and use of Office Add-ins can be blocked in your organization. Check with your administrator to verify a setting such as those mentioned in the following articles aren't configured to block the use of Office Add-ins in your organization:

- [Apps for Outlook 2013 do not activate as expected in email messages](/outlook/troubleshoot/user-interface/apps-for-outlook-2013-do-not-activate-as-expected)
- [User not seeing add-ins](/office365/troubleshoot/access-management/user-not-seeing-add-ins#for-outlook-2016)
