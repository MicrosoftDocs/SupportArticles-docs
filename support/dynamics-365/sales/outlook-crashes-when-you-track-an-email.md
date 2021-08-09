---
title: Outlook crashes when tracking an email
description: Describes an issue where Outlook crashes when you select Track in CRM or Set Involves in an email with an attachment in Microsoft Dynamics CRM.
ms.reviewer: dmartens, tasitae
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Outlook crashes when you try to track an email in Microsoft Dynamics CRM

This article provides a resolution and workarounds to solve the issue that Microsoft Outlook crashes when you try to track an email message in Microsoft Dynamics CRM.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2016, Microsoft Dynamics CRM 2015, Microsoft Dynamics CRM 2013, Outlook 2016, Outlook 2013, Microsoft Outlook 2010  
_Original KB number:_ &nbsp; 3142993

## Symptoms

When you select **Track in CRM** or **Set Regarding** on an email with an attachment, Microsoft Outlook crashes.

Additionally, in the Application Event log, you may find one or more of the following crash signatures with event ID 1000:

| Application name| Application version| Module name| Module version| Offset |
|---|---|---|---|---|
| Outlook 2010|||||
|Outlook.exe|14.0.7165.5000|exsec32.dll|14.0.7159.5000|0x00007D06|
|Outlook.exe|14.0.7160.5000|exsec32.dll|14.0.7159.5000|0x00000000000023C5|
|Outlook.exe|14.0.6109.5005|exsec32.dll|14.0.6019.1000|0x00007C50|
| Outlook 2013|||||
|Outlook.exe|15.0.4763.1000|exsec32.dll|15.0.4759.1000|0x000076BD|
|Outlook.exe|15.0.4551.1004|exsec32.dll|15.0.4551.1001|0x000076a7|
| Outlook 2016|||||
|Outlook.exe|16.0.6366.2036|exsec32.dll|16.0.6366.1439|0x00003F99|
|Outlook.exe|16.0.4266.1001|exsec32.dll|16.0.4266.1001|0x00003F82|
|Outlook.exe|16.0.4266.1001|exsec32.dll|16.0.4266.1001|0x000000000000251F|

## Cause

This issue may occur if Outlook is not configured to use Cached Exchange Mode. Microsoft Dynamics CRM for Outlook is only supported when using Cached Exchange Mode.

## Resolution

To fix this issue, follow the steps for your Office version and installation type. See the More information section to determine whether your Office installation is Click-to-Run or MSI-based.

### Office 2016

#### Click-to-Run-based installations of Office 2016

To fix this issue, make sure that your Office 2016 Click-to-Run installation is at version 16.0.6629.1000 or a later version. If it is not at this version or a later version, update your Office 2013 installation. To do this, follow these steps.

1. Open any Office application, such as Outlook or Word.
2. Select **File**, and then select **Office Account** or **Account**.
3. View the **Version** that is listed under **Office Updates**.
4. If the version is not at 16.0.6629.1000 or a later version, select **Update Options**, and then select **Update Now**.

> [!NOTE]
> If you had previously disabled updates, select **Enable updates** after you select **Update Options**, and then select **Update Now**.

For more information about update channels for Office 365 clients, see [Update history for Microsoft 365 Apps (listed by date)](/officeupdates/update-history-microsoft365-apps-by-date).

#### MSI-based installations of Office 2016

To fix this issue, install the February 7, 2017, update for Outlook 2016. For information about this update, see [February 7, 2017, update for Outlook 2016 (KB3141511)](https://support.microsoft.com/help/3141511).

### Office 2013

#### Click-to-Run-based installations of Office 2013

To fix this issue, make sure that your Office 2013 Click-to-Run installation is at version 15.0.4833.1001 or a later version. If it is not at this version or a later version, update your Office 2013 installation. To do this, follow these steps.

1. Open any Office application, such as Outlook or Word.
2. Select **File**, and then select **Office Account** or **Account**.
3. View the Version that is listed under **Office Updates**.
4. If the version is not at 15.0.4833.1001 or a later version, select **Update Options**, and then select **Update Now**.

> [!NOTE]
> If you had previously disabled updates, select **Enable updates** after you select **Update Options**, and then select **Update Now**.

For more information about Click-to-Run for Office 2013, see [Update history for Office 2013](/officeupdates/update-history-office-2013)

#### MSI-based installations of Office 2013

To fix this issue, install the June 7, 2016, update for Outlook 2013. For information about this update, see [June 7, 2016, update for Outlook 2013 (KB3115158)](https://support.microsoft.com/help/3115158/june-7-2016-update-for-outlook-2013-kb3115158).

## Workaround

If you can't install the update that's mentioned in the Resolution section to fix this issue, you can work around the issue by using one of the following options:

### Option 1 - Enable Cached Exchange Mode

Use the steps in the following article to enable Cached Exchange Mode in Outlook:

[Turn on or off Cached Exchange Mode](https://support.microsoft.com/office/turn-on-cached-exchange-mode-7885af08-9a60-4ec3-850a-e221c1ed0c1c)

### Option 2 - Enable Server-Side Synchronization

Switch the Mailbox record in Microsoft Dynamics CRM for your user to **Server-Side Synchronization or Email Router** instead of **Microsoft Dynamics CRM for Outlook**. You can refer to the following article for additional details about how to configure Server-Side Synchronization.

[Set up server-side synchronization of email, appointments, contacts, and tasks](/previous-versions/dynamicscrm-2016/administering-dynamics-365/dn531109(v=crm.8))

## More information

To determine whether your Office installation is Click-to-Run or MSI-based, follow these steps:

1. Open an Office application, such as Outlook or Word.
2. On the **File** menu, select **Account** or **Office Account**.
3. For Office Click-to-Run installations, an **Update Options** item is displayed. For MSI-based installations, the **Update Options** item isn't displayed.
