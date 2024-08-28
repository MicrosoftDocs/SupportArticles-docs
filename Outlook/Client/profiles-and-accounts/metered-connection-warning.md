---
title: Can't send or receive email and Metered Connection Warning is triggered
description: Describes an issue that blocks Outlook 2016 or Outlook 2013 from sending or receiving email and triggers Internal MAPI errors and Metered Connection Warning messages. Provides workarounds.
author: cloud-writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.editor: v-jesits
ms.custom: 
  - sap:Sending, Receiving, Synchronizing, or viewing email\Other
  - Outlook for Windows
  - CSSTroubleshoot
appliesto: 
  - Outlook for Microsoft 365
  - Outlook 2016
  - Outlook 2013
ms.date: 01/30/2024
---

# Can't send or receive email in Outlook and "Metered Connection Warning" is triggered

## Symptoms

In Outlook for Microsoft 365, Microsoft Outlook 2016, or Microsoft Outlook 2013, you experience one or more of the following symptoms:

- New email messages aren't received.
- When you try to send an email message, it isn't sent. Instead, it remains in the Outbox.
- When you try to configure a new Outlook profile by using an IMAP account, you receive the following error message:

    > Internal MAPI error: The profile does not contain the requested service. Contact your administrator.

- When you select **File** in Outlook 2016, the following warning messages are displayed:

    > Metered Connection Warning  
    > We noticed the metered connection you're on may charge extra and this Office program might access online content. You may want to:  
    >
    > - Tap or click the network icon and turn on Airplane mode to go offline  
    > - Connect to a WiFi or LAN network that isn't metered  
    > - Check the status of your data plan with your mobile operator

    > Upgrade in Progress  
    Your mailbox is currently being optimized as part of an upgrade to Outlook 2016. This one-time process may take more than 15 minutes to finish, and performance may be affected while the optimization is in progress.

    :::image type="content" source="media/metered-connection-warning/account-information-warning.png" alt-text="Screenshot shows the Metered Connection Warning and Upgrade in Progress messages under Account Information.":::

## Resolution

To fix these issues for Outlook for Microsoft 365, update your Office installation to version 2008 (Build 13127.20508) or a later version.

1. Open any Office application, such as Outlook or Word.
2. Select **File**, and then select **Office Account** or **Account**.
3. Check the version number that is listed under **Office Updates**. If the version is earlier than 2008, select **Update Options**, and then select **Update Now**.

For more information about update channels for Microsoft 365 clients, see [Update history for Microsoft 365 Apps (listed by date)](/officeupdates/update-history-microsoft365-apps-by-date).

If updating the Office installation does not fix the issues, use one of the methods that are listed in the "Workaround" section.

There is no resolution for Outlook 2016 and Outlook 2013 at this time. Use the appropriate workarounds for these products.

## Workaround

### For Outlook for Microsoft 365 and Outlook 2016

To work around these issues, try Method 1 first. If that doesn't fix the issues, try Method 2.

#### Method 1: Delete the SecurityManager key in the registry

The issues might be caused by the registry values under this subkey:

`HKLM\SOFTWARE\Microsoft\Office\ClickToRun\REGISTRY\MACHINE\Software\Microsoft\SecurityManager\CapAuthz\ApplicationsEx`

Delete the **SecurityManager** key and its subkeys in the registry.

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry](https://support.microsoft.com/help/322756) for restoration in case problems occur.

1. Exit Outlook.
2. Start **Registry Editor**.
   - For **Windows 10, Windows 8.1, and Windows 8**: Press Windows logo key+R to open a **Run** dialog box. Type **regedit.exe**, and then select **OK**.
   - For **Windows 7**: Select **Start**, type **regedit.exe** in the search box, and then press Enter.
3. In Registry Editor, locate the following subkey in the registry:

    `HKLM\SOFTWARE\Microsoft\Office\ClickToRun\REGISTRY\MACHINE\Software\Microsoft\SecurityManager\CapAuthz\ApplicationsEx`

4. Right-click the **SecurityManager** key, and select **Permissions**.
5. Select **Advanced**, and select the **Replace all child object permission entries with inheritable permission entries from this object** check box.
6. Select **OK**.
7. Select **yes** if you receive the following notification: "**This will replace explicitly defined permissions on all descendants of this object with inheritable permissions from \<parent key>. Do you wish to continue?**
8. Select **OK**.
9. Right-click the **SecurityManager** key, and select **Delete** to delete the **SecurityManager** key and the subkeys.
10. Exit **Registry Editor**.
11. [Repair the Office application](https://support.microsoft.com/office/repair-an-office-application-7821d4b6-7c1d-4205-aa0e-a6b40c5bb88b), and check whether the issues have been resolved.

#### Method 2: Stop third-party applications that access MAPISVC.inf file

These issues may also be caused by third-party applications that access MAPISVC.inf and prevent Outlook from setting up the Account Manager. To mitigate this situation, stop the applications and processes that may be affecting MAPISVC.inf.

Use [Process Monitor](/sysinternals/downloads/procmon) to see the processes that are accessing MAPISVC.inf. If a process displays a **SHARING_VIOLATION on MAPISVC.inf**, it indicates that the associated application is likely to be responsible for the issues. For instance, RepMgr.exe (C:\Program Files\Confer\RepMgr.exe) is an application that is known to cause these issues. Stop this process if you see it in Process Monitor.

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-information-disclaimer.md)]

### For Outlook 2013

To work around these issues, try Method 1 first. If that doesn't fix the issues, try Method 2.

#### Method 1: Verify permissions in the registry

In some cases, the issues are related to a permissions issue in the registry. To determine whether this is the cause of the issues and then fix them, follow these steps:

1. Exit Outlook.
2. Start **Registry Editor**.
   - For **Windows 10, Windows 8.1 and Windows 8**: Press Windows logo key+R to open a **Run** dialog box. Type **regedit.exe**, and then select **OK**.
   - For **Windows 7**: Select **Start**, type **regedit.exe** in the search box, and then press Enter.

3. In Registry Editor, locate and right-click the following subkey in the registry, and then select **Permissions**:

    `HKEY_CLASSES_ROOT\Installer\Components\F1291BD604B860441AB89E60BDEE0F9C`

4. Under Group or user names, find your own user name or a group that you're a member of (such as Users or Administrators).

    If you're unsure about which groups your user account is a member of, follow these steps:
   - Open **Control Panel**.
   - From **Category** view, select **User Accounts**, and then select **User Accounts** again.
   - Select **Manage User Accounts**.
   - In the **User Accounts** window, find your **User Name**, and review the groups that are listed in the **Group** column.

        > [!NOTE]
        > You may have to expand the **Group** column to view all the groups.
   - When you are finished, select **Cancel**.

5. If you do not see a group that you're a member of or your own user name listed in the permissions list, select **Add**, and then add your own user account.
6. Select **OK**.
7. Select your user name or the group that you're a member of.
8. View the permissions for your user name or group, and make sure that the **Read** permission has **Allow** selected.
9. Select **OK**.
10. Exit Registry Editor.

#### Method 2: Run a repair of Office

Follow the steps in the following article to repair your Office installation. This method is most appropriate for MSI-based installations of Office. To determine whether your Office installation is Click-to-Run or MSI-based, see the "More information" section.

[Repair an Office application](https://support.office.com/article/repair-an-office-application-7821d4b6-7c1d-4205-aa0e-a6b40c5bb88b)

## More information

To determine whether your Office installation is Click-to-Run or MSI-based, follow these steps:

1. Start Outlook.
2. On the **File** menu, select **Office Account**.
3. An **Update Options** item is displayed for Office Click-to-Run installations, but not for MSI-based installations.

 :::image type="content" source="media/metered-connection-warning/office-version.png" alt-text="Screenshot shows differences between Office Click-to-Run and MSI-based versions under Office Account.":::
