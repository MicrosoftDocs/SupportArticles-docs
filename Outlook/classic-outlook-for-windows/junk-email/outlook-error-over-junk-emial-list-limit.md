---
title: You are over Junk E-mail list limit
description: Describes the issue that you are over Junk E-mail list limit, and provides resolutions.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Data Protection and Security\Installing Junk email filter updates
  - Outlook for Windows
  - CI 119623
  - CSSTroubleshoot
ms.reviewer: gregmans, wbrandt
search.appverid: 
  - MET150
appliesto: 
  - Outlook for Microsoft 365
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Outlook 2010
  - Office Outlook 2007
ms.date: 01/30/2024
---
# Outlook error indicates that you are over the Junk E-mail list limit

_Original KB number:_ &nbsp; 2669081

## Symptoms

When you start Microsoft Outlook or when you try to configure your junk email settings, you may receive one of the following error messages:

- Error message 1:

    > Cannot add to the server Junk E-mail Lists, you are over the size allowed on the server. The Junk E-mail Filter on the server will be disabled until your Junk E-mail Lists have been reduced to the size allowed by the server.  
    > Would you like to manage your Junk E-mail Lists now?

- Error message 2:

    > Unable to add to the server Junk E-mail Lists, you are over the size allowed on the server. The Junk E-mail Filter on the server will be disabled until your Junk E-mail Lists have been reduced to the size allowed by the server.  
    > Would you like to manage your Junk E-mail Lists now?

## Cause

Microsoft Exchange limits the space that's allotted to your various Junk E-mail lists. By default, this limit is 510 kilobytes (KB).

Considering this limit, there are four known causes of these errors:

- You have a large number of entries in your Safe Senders, Blocked Senders, and Safe Recipients lists.

    By default, you have a cumulative limit of 510 KB for all your Junk E-mail lists. If you have a large number of entries in these lists (cumulatively), you may receive one of these error messages when you try to add more items to the lists.
- The `Max Extended Rule Size` registry value is incorrectly configured on the Exchange server.

  > [!NOTE]
  > The `Max Extended Rule Size` registry value doesn't apply to Exchange Server 2013 and later versions.

  On an Exchange server, you can configure the following registry data:

  > Registry key: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\MSExchangeIS\ParametersSystem`  
  > Value: `Max Extended Rule Size`  
  > Type: DWORD  
  > Data: an integer specifying the maximum size, in *bytes*, you want to allow for the junk e-mail rule

  The value that you enter in the registry is interpreted as the maximum rule size in bytes. Therefore, if you want to specify a limit that's larger than the default 510 KB, you must enter a value greater than 522240 (decimal).

  This error may occur when you unintentionally specify a value lower than the default limit. For example, you might enter a value of 1024 under the assumption that this is double the default limit of 510 KB. However, because the value is interpreted as the number of *bytes*, you have configured a limit of 1024 bytes, and this is substantially lower than the default limit of 510 KB. 
- The **PR_RULE_MSG_STATE** property of the Junk E-mail Rule message is incorrectly configured.

  In an Exchange mailbox, your junk email settings are stored in a hidden message in the associated contents table of your Inbox folder. The subject of this hidden message is Junk E-mail Rule. This message has a **PR_RULE_MSG_STATE** property, and the default value of this property is 49 (decimal) or 0x31 (hexadecimal). If you disable junk email filtering in Outlook Web App, the value of this property becomes 48 (decimal) or 0x30 (hexadecimal). If the value that's specified for this property is something other than 48 or 49 (decimal), you may receive one of these error messages.
- The **Also trust e-mail from my Contacts** option is enabled in Outlook.

  On the Safe Senders tab of the Junk E-mail Options dialog box, you'll see the **Also trust e-mail from my Contacts** option. If this option is enabled, and you have a large number of contacts in your Contacts folder, you may unintentionally exceed the 510-KB limit on your mailbox. When this option is enabled, Outlook tries to add all the email addresses for your contacts to the Safe Senders list.

## Resolution

Because there are four possible causes of this problem, follow these steps to determine the cause of the problem.

> [!NOTE]
> Skip steps 1 and 2 if you're using Exchange Server 2013 or later versions. The `Max Extended Rule Size` registry value applies only to earlier versions of Exchange Server.

1. Check the registry on your Exchange server to see whether an incorrect value is used for `Max Extended Rule Size`.

   > Key: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\MSExchangeIS\ParametersSystem`  
   > Value: `Max Extended Rule Size`  
   > Type: DWORD  
   > Data: an integer specifying the maximum size, in bytes, you want to allow for the junk e-mail rule

   The value that you enter in the registry is interpreted as the maximum rule size in *bytes*. If you want to specify a limit that is larger than the default 510 KB, enter a value that's greater than 522240 (decimal). For example, if you want to double the default limit, specify a value of 1044480.

    > [!NOTE]
    > You must restart the Microsoft Exchange Information Store service for this change to take effect.

    You can also use the following procedure to determine this value without checking the registry on your Exchange server. If the value that's shown in MFCMAPI differs from the value that's shown in the registry on the Exchange server, either you are not on the correct Exchange server or the registry value is not being used yet (because the Exchange Information Store service has not been restarted).

    > [!NOTE]
    > The following steps assume that you're using the November 2011 version (15.0.0.1029) of MFCMAPI or a later version.

    1. Download the MFCMAPI tool on a computer on which you have an Outlook profile configured for the mailbox in question.

        For more information about MFCMAPI, see [MFCMAPI](https://github.com/stephenegriffin/mfcmapi/releases/).

    2. Create an Online mode profile for the mailbox.
    3. Start MFCMAPI.
    4. On the **Session** menu, click **Logon**.
    5. In the **Choose Profile** dialog box, select the Online mode profile and then click **OK**.
    6. In the **Display Name** column, locate the entry for the mailbox. Then, select that row in the list.
    7. On the **Property** menu, click **Additional Properties**.
    8. In the **Extra Properties** dialog box, click **Add**.
    9. In the **Property Tag Editor** dialog box, enter *0x0E9B0003* in the **Property Tag** field.

        This value corresponds to the **PR_EXTENDED_RULE_SIZE_LIMIT** property. After you type this value into the **Property Tag** field, the remaining fields in the **Property Tag Editor** should automatically fill in to match the values that are shown in the following screenshot:

        :::image type="content" source="media/outlook-error-over-junk-emial-list-limit/property-tag-editor-details.png" alt-text="Screenshot of Property Tag Editor dialog box." border="false":::


    10. Click **OK** in the **Property Tag Editor** dialog box.
    11. Click **OK** in the **Extra Properties** dialog box.
    12. With the mailbox selected in the top pane, locate and select the **PR_EXTENDED_RULE_SIZE_LIMIT** property in the bottom pane, as in the following screenshot:

        :::image type="content" source="media/outlook-error-over-junk-emial-list-limit/select-pr-extended-rule-size-limit-property.png" alt-text="Screenshot of selecting PR_EXTENDED_RULE_SIZE_LIMIT property.":::

        The value of this property as displayed in the **Value** column. In this screenshot, the default limit of 522240 is being used.

    If the `Max Extended Rule Size` registry value doesn't exist on your Exchange server, or if the value is correctly configured, go on to step 2.

2. If there are many cumulative entries in the Safe Senders, Blocked Senders and Safe Recipients lists, you can probably isolate this problem to a small number of mailboxes. For example, if only a few users encounter the errors that are described in the [Symptoms](#symptoms) section, you should examine the Safe Senders, Blocked Senders, and Safe Recipients lists in Outlook to determine whether there is a large number of entries in the lists (in total).

    If you have narrowed the problem to being caused by a large number of items in these lists, you can configure a larger limit by using the Max Extended Rule Size registry value on your Exchange server. This solution can be used on servers that are running Exchange Server 2003, Exchange Server 2007, and Exchange Server 2010.

    - Key: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\MSExchangeIS\ParametersSystem`
    - Value: `Max Extended Rule Size`  
    - Type: DWORD
    - Data: an integer specifying the maximum size, in bytes, you want to allow for the junk e-mail rule

    The value that you enter in the registry is interpreted as the maximum rule size in bytes. If you want to specify a limit that is larger than the default 510 KB, enter a value that's greater than 522240 (decimal).

    > [!NOTE]
    > You must restart the Microsoft Exchange Information Store service for this change to take effect.

    This change affects all mailboxes that are located on the Exchange server on which this registry change is performed.

    If there are not many entries (cumulatively) in the Safe Senders, Blocked Senders, and Safe Recipients lists, go to step 3.

3. If the `Max Extended Rule Size` registry value is configured correctly, and there are not many entries in the Safe Senders, Blocked Senders, and Safe Recipients lists, the problem may involve the Trust e-mail from my Contacts setting in Outlook. This setting is shown in the following screenshot:

    :::image type="content" source="media/outlook-error-over-junk-emial-list-limit/also-trust-email-from-my-contacts-option-enabled.png" alt-text="Screenshot of the Also trust e-mail from my Contacts option.":::

    If this option is enabled, and you have a large number of contacts in your Contacts folder, you may unintentionally exceed the default 510-KB limit on your mailbox. When this option is enabled, Outlook tries to add all the email addresses for your contacts to the Safe Senders list. If you clear this check box, and the problem no longer occurs, you can either leave this option disabled or use the `Max Extended Rule Size` registry value on your Exchange server to increase the default limit.

    > Key: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\MSExchangeIS\ParametersSystem`  
    > Value:`Max Extended Rule Size`    
    > Type: DWORD  
    > Data: an integer specifying the maximum size, in bytes, you want to allow for the junk e-mail rule

    The value that you enter in the registry is interpreted as the maximum rule size in bytes. If you want to specify a limit that's larger than the default 510 KB, you must enter a value that's greater than 522240 (decimal).

    > [!NOTE]
    > You must restart the Microsoft Exchange Information Store service for this change to take effect.

4. If you still experience this problem after you review or implement steps 1-3, the hidden Junk E-mail Rule message in your mailbox may have an incorrectly configured value in the **PR_RULE_MSG_STATE** property. To determine whether your mailbox contains an incorrectly configured value for this property, follow these steps.

    > [!NOTE]
    > The following procedure assumes that you're using the November 2011 version (15.0.0.1029) of MFCMAPI or a later version.

    1. Download the MFCMAPI tool on a computer on which you have an Outlook profile configured for the mailbox in question. For more information about MFCMAPI, see [MFCMAPI](https://github.com/stephenegriffin/mfcmapi/releases/).
    2. Create an Online mode profile for the mailbox.
    3. Exit Outlook if it's currently running.
    4. Start MFCMAPI.
    5. On the **Session** menu, click **Logon**.
    6. In the **Choose Profile** dialog box, select the Online mode profile, and then click **OK**.
    7. In the list of accounts, double-click the entry that has the email address for the mailbox.

        :::image type="content" source="media/outlook-error-over-junk-emial-list-limit/double-click-email-address-for-mailbox.png" alt-text="Screenshot of selecting the email address for the mailbox.":::
    8. Expand **Root Container**, and then expand **Top of Information Store**.
    9. Right-click the **Inbox** folder, and then click **Open associated contents table**.

        :::image type="content" source="media/outlook-error-over-junk-emial-list-limit/select-open-associated-contents-table.png" alt-text="Screenshot of clicking Open associated contents table.":::
    10. In the **Inbox** dialog box, locate and select the message whose **Subject** is *Junk E-mail Rule*.
    11. In the bottom pane, locate and select the **PR_RULE_MSG_STATE** property.

        :::image type="content" source="media/outlook-error-over-junk-emial-list-limit/select-pr-rule-msg-state-property.png" alt-text="Screenshot of selecting the PR_RULE_MSG_STATE property.":::

        The default value of the **PR_RULE_MSG_STATE** property is 49 (decimal) as shown in this screenshot. If you do not see a value of 49 for this property, go on to step l.
    12. Right-click **PR_RULE_MSG_STATE** and then click **Delete property**.

        :::image type="content" source="media/outlook-error-over-junk-emial-list-limit/delete-property-option.png" alt-text="Screenshot of selecting Delete property option.":::
    13. Click **OK** when you're prompted to delete the property.
    14. Close all windows that are open in MFCMAPI.
    15. Start Outlook.

## References

[How to delete junk email rules by using MFCMAPI in an Exchange Server environment](https://support.microsoft.com/help/2860406)
