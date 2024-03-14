---
title: Issues in Outlook when you try to configure free/busy information or when you try to delegate information
description: Describes the issues that you may experience in Outlook because a mailbox property does not correctly reference a hidden message in the mailbox. Provides a resolution.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto: 
- Outlook 2016 Outlook 2013 
- Microsoft Outlook 2010 
- Outlook for Microsoft 365 
- Outlook 2019
search.appverid: MET150
ms.reviewer: gregmans, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/30/2024
---
# You experience issues in Outlook when you try to configure free/busy information or when you try to delegate information

## Symptoms

In Microsoft Outlook, you experience one of the following issues when you try to configure free/busy information or when you try to delegate information:

- When you accept a meeting request or when you add a delegate to your mailbox, you receive the following error message:
    > Unable to save free/busy information

- When you use the `outlook.exe /cleanfreebusy` command-line switch to start Outlook, you receive the following error message:
    > Unable to clean your local free/busy information.

- When you try to add a delegate, you receive one of the following error messages:
    > The Delegates settings were not saved correctly. Unable to activate free/busy information.  

    > The Delegates settings were not saved correctly. Unable to activate send-on-behalf-of list. You do not have sufficient permission to perform this operation on this object.

- When you try to open a shared calendar item, you receive the following error message:
    > Can't open this item. Unable to open the free/busy information

    Additionally, the following event is logged in the Application log on the Outlook client computer:
    > Event Type: Warning  
    > Event Source: Outlook  
    > Event Category: None  
    > Event ID: 25  
    > Date: date  
    > Time: time  
    > User: N/A  
    > Computer: Computer_name  
    > Description:  
    > Unable to save free/busy information. Unable to open the free/busy information.

- When a delegate tries to create an item in the shared calendar or in the manager calendar, the delegate receives the following error message:

    > Unable to open free/busy information

## Cause

These issues occur because a mailbox property does not correctly reference a hidden message in the mailbox. The hidden message contains information that is related to any of the following features:

- free/busy publishing
- delegate
- direct booking

## Resolution

To resolve this issue, use one of the following methods to force the regeneration of hidden free/busy information in the mailbox.

The steps in this section must be applied to the mailbox of the user who owns the Calendar folder. This is the mailbox on which you try to create the calendar items, use the **/cleanfreebusy** switch, or configure the delegate settings.

> [!NOTE]
> The **/cleanfreebusy** switch is not available in Outlook 2016 and later versions. Instead, you can use the **/cleanroamedprefs** switch.

After you follow these steps, you may have to reconfigure settings that are related to the delegates and direct booking features.

### Method 1: Use the PowerShell cmdlet

You must have the administrator permission to run the PowerShell cmdlets to delete the free/busy configuration on the mailbox, and then add or recreate any necessary delegate permissions:

1. Run the following cmdlet to export the current Calendar folder permissions, which may be needed to recreate any delegate permission settings:

    ```powershell
    Get-MailboxFolderPermission -Identity <alias>:\Calendar
    ```

1. Run the following PowerShell cmdlet against the target mailbox:

    ```powershell
    Remove-MailboxFolderPermission -Identity <alias>:\Calendar -ResetDelegateUserCollection
    ```

    > [!NOTE]
    > See [Remove-MailboxFolderPermission](/powershell/module/exchange/remove-mailboxfolderpermission) for more details on the **ResetDelegateUserCollection** parameter.

1. Run the following cmdlet one or more times, as needed, to add or recreate any necessary delegate permissions:

    ```powershell
    Add-MailboxFolderPermission -Identity <alias>:\Calendar -User <delegate alias> -SharingPermissionFlag Delegate
    ```

### Method 2: Use MFCMAPI tool

Follow these steps:

1. Exit Outlook.
1. Make sure a profile (preferably configured for **Online** mode) exists for the mailbox.
    > [!NOTE]
    > If no profile exists for the mailbox, use the **Mail** item in Control Panel to create it.

1. Download the [MFCMAPI](https://github.com/stephenegriffin/mfcmapi) tool.
1. Start the MFCMapi.exe program that you downloaded, and then select **OK**.
1. If the profile is configured for **Cached** mode, use the following steps to temporarily force **Online** mode within MFCMAPI:
    1. On the **Tools** menu, select **Options**.
    1. Enable the following two options, and then select **OK**.
      - Use the MDB_ONLINE flag when calling OpenMsgStore
      - Use the MAPI_NO_CACHE flag when calling OpenEntry
1. On the **Session** menu, select **Logon**.
1. In the **Profile Name** list, select the profile for the mailbox, and then select **OK**.
1. 8Double-click the appropriate **Microsoft Exchange Message Store**.
1. In the navigation pane, select **Root Container**.
1. In the details pane, right-click **PR_FREEBUSY_ENTRYIDS**, select **Delete Property**, and then select **OK**.
1. In the navigation pane, expand **Root Container**, expand **Top of Information Store**, and then select **Inbox**  
    > [!NOTE]
    > **Top of Information Store** could be localized to another language depending on mailbox regional settings.

1. In the details pane, right-click **PR_FREEBUSY_ENTRYIDS**, select **Delete Property**, and then select **OK**.
1. Delete the **LocalFreeBusy** message by using the following steps:
    1. In the navigation pane, expand **Root Container**.
    1. Double-click **Freebusy Data**.
    1. In the upper pane, find the item with the Subject of **LocalFreebusy**. Right-click it, and then select **Delete message**.
    1. For Deletion style, select **Permanent delete passing DELETE_HARD_DELETE (unrecoverable)**, and then select **OK**.
1. In the navigation pane, select **Top of Information Store** > **Inbox**.
1. On the **Actions** menu, point to **Other tables**, and then select **Rules table**.
1. Find the rule whose PR_RULE_PROVIDER option is set to **SCHEDULE+ EMS Interface**, and then delete it.
1. Exit MFCMAPI.

> [!NOTE]
> You may need to manually remove and re-add the delegate(s) in Outlook by using **File** > **Account settings** > **Delegate Access**. 

### Reconfigure delegates permissions and direct booking

If you have any custom settings that are related to the delegates feature, or the direct booking feature, follow the appropriate steps.

#### For the delegates feature

1. Start Outlook.
1. On the **File** tab, select **Account Settings**, and then select **Delegate Access**.
1. Select the delegate that you want to reconfigure, and then select Permissions.
1. Click to select the options that you want in the **Delegate Permissions** dialog box, and then select **OK**.
1. Repeat step 3 and step 4 for all delegates.
1. Select **OK**.
1. On the **File** tab, select **Exit**.

#### For the direct booking feature

1. Start Outlook.
1. On the **File** tab, select **Options**, and then select **Calendar**.
1. In Outlook 2016 or 2013, select **Auto Accept/Decline**, or in Outlook 2010, select **Resource Scheduling**.
1. Click to select the check boxes that you want.
1. Select **OK** two times.
1. On the **File** menu, select **Exit**.
