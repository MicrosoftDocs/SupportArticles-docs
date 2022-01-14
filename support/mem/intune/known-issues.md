---
title: Known issues with Microsoft Intune
description: Learn about known issues with Microsoft Intune, including workarounds and updated fixes.
ms.date: 01/13/2022
---
# Known issues with Intune

This page lists recent known issues with Microsoft Intune. For a list of weekly feature announcements, see the [What's new in Microsoft Intune](/mem/intune/fundamentals/whats-new) in the Intune product documentation. Visit the [Intune Customer Success blog](https://techcommunity.microsoft.com/t5/intune-customer-success/bg-p/IntuneCustomerSuccess) for posts about best practices, support tips, and other tutorials, as well as a backlog of past known issues.

## Smart card removal behavior for Lock workstation has the wrong behavior applied on Windows 10 devices

We recently discovered a bug in the [Smart card removal behavior setting](/mem/intune/protect/endpoint-protection-windows-10#interactive-logon) for Windows 10 devices where the underlying setting values in Microsoft Intune for **Lock workstation** has the **No Action** behavior applied. We are rolling out a fix in Intune’s January (2201) service release, which is expected to be completed by end of the month.

### Who is impacted

If you have the value **Lock workstation** selected for the Smart card removal behavior setting configured in either your device configuration, security baselines, or Endpoint protection profiles for Windows 10 devices then you might be impacted by this issue.

### Recommended actions

Check the value selected for the Smart card removal behavior setting for existing policies. If you have the selected the value **Lock workstation**, re-save existing policies to apply the correct behavior or update the values based on your organization's needs.

> [!NOTE]
> For security baselines, you do not need to update or re-save the policies after the fix is rolled out.

## Several Office settings in the settings catalog need parent settings enabled

We recently identified several Office settings in the settings catalog that, when enabled, do not automatically enable the required parent setting. This can lead to the policy not applying as expected if you did not configure the parent setting.

To help identify which configuration settings have this behavior, we recently made a user interface (UI) change to mark them as **(deprecated)** in the Settings catalog (preview) page. We have also included a full list below.

We will release new device configuration settings (with the same name) that will automatically enforce the dependencies.

### Recommended actions

Check your device configuration profiles to see if you are using a deprecated setting and if the parent setting is enabled. If the parent setting is not enabled, update your profiles to configure the parent setting and ensure the child setting works as expected. After we release the replacement settings, you can update your configuration profile to use the new setting instead.

### List of settings by category

|Category|Setting|
|------------------|----------------|
|Microsoft Excel 2016\Excel Options\Security\Trust Center|Disable Trust Bar Notification for unsigned application add-ins and block them (User)|
|Microsoft Outlook 2016\Outlook Options\Other\Advanced|Do not allow Outlook object model scripts to run for shared folders (User)|
||Do not allow Outlook object model scripts to run for public folders (User)|
||Use Unicode format when dragging e-mail message to file system (User)|
|Microsoft Outlook 2016\Security|Allow Active X One Off Forms (User)|
||Prevent users from customizing attachment security settings (User)|
|Microsoft Outlook 2016\Security\Automatic Picture Download Settings|Include Internet in Safe Zones for Automatic Picture Download (User)|
|Microsoft Outlook 2016\Security\Cryptography|Minimum encryption settings (User)|
||Signature Warning (User)|
|Microsoft Outlook 2016\Security\Cryptography\Signature Status dialog box|Retrieving CRLs (Certificate Revocation Lists) (User)|
|Microsoft Outlook 2016\Security\Security Form Settings\Attachment Security|Allow users to demote attachments to Level 2 (User)|
||Display Level 1 attachments (User)|
||Remove file extensions blocked as Level 1 (User)|
||Remove file extensions blocked as Level 2 (User)|
|Microsoft Outlook 2016\Security\Security Form Settings\Custom Form Security|Allow scripts in one-off Outlook forms (User)|
||Set Outlook object model custom actions execution prompt (User)|
|Microsoft Outlook 2016\Security\Security Form Settings\Programmatic Security|Configure Outlook object model prompt when reading address information (User)|
||Configure Outlook object model prompt when accessing an address book (User)|
||Configure Outlook object model prompt When accessing the Formula property of a UserProperty object (User)|
||Configure Outlook object model prompt when responding to meeting and task requests (User)|
||Configure Outlook object model prompt when executing Save As (User)|
||Configure Outlook object model prompt when sending mail (User)|
|Microsoft Outlook 2016\Security\Trust Center|Allow hyperlinks in suspected phishing e-mail messages (User)|
||Security Level (User)|
|Microsoft Outlook 2016\Account Settings\Exchange|Enable RPC encryption (User)|
|Microsoft Outlook 2016\Outlook Options\Preferences\Junk E-mail|Junk E-mail protection level (User)|
|Microsoft Outlook 2016\Account Settings\Exchange|Authentication with Exchange Server (User)|
|Microsoft PowerPoint 2016\PowerPoint Options\Security\Trust Center|Disable Trust Bar Notification for unsigned application add-ins and block them (User)|
|Microsoft Project 2016\Project Options\Security\Trust Center|Disable Trust Bar Notification for unsigned application add-ins and block them (User)|
|Microsoft Publisher 2016\Security\Trust Center|Disable Trust Bar Notification for unsigned application add-ins (User)|
|Microsoft Word 2016\Word Options\Security\Trust Center|Disable Trust Bar Notification for unsigned application add-ins and block them (User)|
|Microsoft Visio 2016\Visio Options\Security\Trust Center|Disable Trust Bar Notification for unsigned application add-ins and block them (User)|

## Long sync times in Intune for Managed Google Play private apps and web apps

This issue affects Managed Google Play web apps and private line-of-business (LOB) apps. If you recently created or have been added to a web app and sync your tenant, it may take three to six hours or longer for you to see the apps in Intune. Google is aware of this issue and their engineering team is currently working on a fix.

### Who is impacted

Admins who recently published a new Managed Google Play web or LOB app via one of the available publishing methods (iFrame in the Microsoft Endpoint Manager admin center, the custom app publishing API, or the Google Play Console external to Intune), will notice delays for those apps to sync to Intune. After selecting **Sync** from either the Microsoft Endpoint Manager admin center or the Google Play console, it can take hours for the new apps to appear in the app list in Intune. 

> [!NOTE]
> Existing web and private apps are not affected, including updates or edits to those apps.

### Available workarounds

There is one available workaround for web apps for dedicated devices using Microsoft Managed Home Screen by creating and deploying web links instead of Managed Google Play web apps. In the Microsoft Endpoint Manager admin center, go to Apps > All apps, select Add, and then choose web link as the app type.

:::image type="content" source="media/known-issues/long-sync-time.png" alt-text="Microsoft Endpoint Manager admin center - All apps blade with the "Add" and "web link" options highlighted.":::

There is no workaround for any other app type or enrollment scenario at this time.
