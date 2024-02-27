---
title: Out of Office doesn't function correctly in Microsoft 365
description: Fixes some OOF issues in Microsoft 365, for example, OOF messages cannot be saved, old or duplicate OOF messages are sent, or OOF message is not sent.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: CSSTroubleshoot
appliesto:
- Exchange Online
search.appverid: MET150
ms.reviewer: kellybos, rjewell, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/30/2024
---
# The Out of Office feature in Outlook doesn't function correctly in Microsoft 365

## Symptoms

When you try to use the Out of Office (OOF) feature in Outlook in Microsoft 365, you experience the following symptoms:

- The OOF message cannot be saved.
- An old or duplicate OOF message is sent.
- An OOF message isn't sent even though you enable the OOF message.

## Cause

This issue occurs for one of the following reasons:

- Cause 1: There is a backlog of mailbox assistant events (Exchange 2010 only).
- Cause 2: The OOF rules templates are malformed or corrupted.
- Cause 3: The OOF rules quota is exceeded, and new rules cannot be created.
- Cause 4: The Remote Domain setting for the default (or specific) domain is not set to allow OOF messages.

## Resolution

> [!NOTE]
> Any of the four causes can cause an OOF reply to fail. Therefore, each cause must be ruled out one at a time.

> [!WARNING]
> Using the Microsoft Exchange Server MAPI Editor (MFCMapi) may damage Microsoft Exchange Server and the Exchange server mailboxes. Download **MFCMAPI** from [github](https://github.com/stephenegriffin/mfcmapi) (scroll down and then select **Latest release**).

To resolve this issue, follow the steps for the specific cause.  

### Resolution 1

1. Configure the OOF feature. To do this, run either of the following cmdlets in Windows PowerShell, as appropriate:

   `Set-MailboxAutoReplyConfiguration <identity> -AutoReplyState Disabled`  
   `Set-MailboxAutoReplyConfiguration <identity> -AutoReplyState Enabled`

2. Use MFCMapi to check the `PR_OOF_STATE` value. To do this, follow these steps:

   1. In the main window of MFCMapi, select **Session**, and then select **Logon and Display Store Table** to open the mailbox.
   2. Select the profile that you are accessing, and then scroll down in the bottom pane until you see the `PR_OOF_STATE` value. This value should be **True** if you enabled the OOF feature in Windows PowerShell or **False** if you disabled the OOF feature. For example, if you disabled the OOF feature, consider the following screenshot:

      :::image type="content" source="media/out-of-office-feature-not-working-correctly/pr-oof-state-is-false.png" alt-text="Screenshot of the PR_OOF_STATE value.":::

3. If the `PR_OOF_STATE` value is not the expected result, contact Microsoft Support to have them check for queued events (Exchange 2010 only).

### Resolution 2

> [!NOTE]
> The symptoms in your case may differ slightly from these. For example, the OOF message cannot be sent as expected, although the OOF message can be set without error. However, these steps will still apply.

To resolve this issue, delete the OOF rules and the OOF rules templates from the mailbox. Then, re-enable the OOF feature, and test the behavior. To do this, follow these steps.

> [!NOTE]
> You do not have to back up the OOF message when you follow these steps.

1. In the main window of MFCMapi, select **Session**, and then select **Logon and Display Store Table** to open the mailbox.
2. Expand the root container and the top of the information store.
3. Delete the OOF rules. To do this, follow these steps:

   1. Right-click **Inbox**, and then select **Display Rules Table**.

      - If the OOF feature is disabled, an OOF rule is listed in the rules table together with the following rule name:  
        MSFT: TDX OOF Rules
      - If the OOF feature is enabled, two different OOF rules are listed in the rules table. Which rules are listed depends on whether the rule is enabled only internally or both internally and externally. For example, consider the following screenshot:

        :::image type="content" source="media/out-of-office-feature-not-working-correctly/rules-table.png" alt-text="Screenshot of the details of the Rules Table dialog box.":::

      - If the OOF templates are corrupted or malformed, those OOF templates are listed in the rules table. You can see other entries if the user has other rules enabled.

   2. Right-click the OOF rules, and then select **Delete**.

       > [!NOTE]
       > Do not delete any OOF rules except those that are referenced.
  
   3. Close the Rules Table window.

4. Delete the OOF templates. To do this, follow these steps:

   - Right-click **Inbox**, and then select **Open Associated Contents Table**.
   - Scroll to the right side, and then expand the **Message Class** column.
   - To sort the items, select the **Message Class** column.
   - Look for the items whose **Message Class** is either of the following values:
     - IPM.Note.Rules.ExternalOofTemplate.Microsoft
     - IPM.Note.Rules.OofTemplate.Microsoft

For example, consider the following screenshot:

:::image type="content" source="media/out-of-office-feature-not-working-correctly/inbox-display-name-not-found.png" alt-text="Screenshot of the OOF rules that can be deleted.":::

- Right-click the items that belong to one of those two message classes, and then select **Delete Message**.

  > [!NOTE]
  > Do not delete any items except those are referenced.

  :::image type="content" source="media/out-of-office-feature-not-working-correctly/inbox-display-name-not-found.png" alt-text="Screenshot of the OOF rules that can be deleted.":::

- In the **Delete Item** dialog box, select **Permanent delete passing DELETE_HARD_DELETE (unrecoverable)** under **Deletion style**, and then select **OK**.

  :::image type="content" source="media/out-of-office-feature-not-working-correctly/delete-item-dialog-box.png" alt-text="Select the Permanent delete passing DELETE_HARD_DELETE (unrecoverable) option under Deletion style." border="false":::

- Disable and then re-enable the OOF feature by using the following commands:

  `Set-MailboxAutoReplyConfiguration \<identity> -AutoReplyState Disabled`  
  `Set-MailboxAutoReplyConfiguration \<identity> -AutoReplyState Enabled`

- Check whether the OOF feature works as expected and the symptoms no longer occur.

### Resolution 3

If an OOF reply is no longer returned, it is likely that the rules quota is exceeded. Therefore, the internal and external OOF rules cannot be created. To resolve this issue, follow these steps:

1. Increase your rules quota. To do this, follow the steps in the following article:

   [A user cannot create new rules in Outlook or Outlook Web App](https://support.microsoft.com/topic/a-user-cannot-create-new-rules-in-outlook-or-outlook-web-app-b0b21c57-a734-77d7-87fc-479c67752889)

2. Because of the caching of quota information in the Information Store, the updated quota values may require up to two hours to take effect.
3. Repeat Resolution 2.

### Resolution 4

If the **AllowedOFFType** value for the Remote Domain is **None**, OOF messages do not fire externally. This value must be set to **External** to allow external OOFs. By default, this value is set to **None**. Remember that when you search the Remote Domains, the default value is overridden by specific entries. Therefore, if the user is sending to an @contoso.com user, and there is a `Contoso.com` entry in the remote domain settings, the **AllowedOOFType** value is used for that specific entry. If there is no entry for `Contoso.com`, the default (*) remote domain is used.

```ps
Get-RemoteDomain | select Name,AllowedOOFType
```
