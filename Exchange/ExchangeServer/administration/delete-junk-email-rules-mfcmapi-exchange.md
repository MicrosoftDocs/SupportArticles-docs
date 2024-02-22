---
title: Delete junk email rules by using MFCMAPI
description: Describes how to delete junk email rules by using MFCMAPI in Exchange Server 2010, Exchange Server 2013, and Exchange Server 2016.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CI 119623
  - CSSTroubleshoot
ms.reviewer: ChrisBur, MHAQUE, DJBall, ChrisBur, genli, v-six
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
ms.date: 01/24/2024
---
# How to delete junk email rules by using MFCMAPI in an Exchange Server environment

_Original KB number:_ &nbsp; 2860406

## How to delete a junk email rule

> [!NOTE]
> If you permanently delete a junk email rule, you cannot recover any addresses that appear in the Junk Email Filter Lists. Make sure that you export the lists before you delete the junk email rule.  
> For more information about how to export addresses from the Junk Email Filter Lists, see [Export addresses from the Junk Email Filter Lists](https://support.office.com/article/export-addresses-from-the-junk-email-filter-lists-e9884655-41a9-4b2d-90a5-d3f78842a92d).

To delete a junk email rule, follow these steps:

1. As an administrator, create a new mail profile by using Outlook in online mode.

    For more information about how to create and configure a mail profile, see [Create an Outlook profile](https://support.office.com/article/create-an-outlook-profile-f544c1ba-3352-4b3b-be0b-8d42a540459d).

2. Export the list of addresses that contain safe senders and blocked senders to a text (.txt) file.

3. Download MFCMAPI from [MFCMAPI](https://github.com/stephenegriffin/mfcmapi/releases/).

    > [!NOTE]
    > Only an Exchange administrator who has full permissions of a mailbox can use the MFCMAPI tool to remove a junk email rule.

4. Close all Outlook clients that access the mailbox. Otherwise, the MFCMAPI tool can't correctly delete the junk email rule.
5. Use the MFCMAPI tool to delete the junk email rule. To do this, follow these steps:

    1. Open MFCMAPI.
    2. Click the **Session** tab and select **Logon**. (The screenshot for this step is listed below).

   :::image type="content" source="media/delete-junk-email-rules-mfcmapi-exchange/logon-option-on-session-tab.png" alt-text="Screenshot of selecting Logon from the Session tab.":::

    3. Double-click the default Exchange mailbox store in the list. This is displayed as **UserName**@**DomainName.com**. A new MFCMAPI window will open.
    4. Expand **Root Container**, and then expand **Top of Information Store**. (The screenshot for this step is listed below).

        :::image type="content" source="media/delete-junk-email-rules-mfcmapi-exchange/expand-top-of-information-store-option.png" alt-text="Screenshot of window for Top of Information Store.":::

        > [!NOTE]
        > If you see **IPM_SUBTREE** in the list, then you are accessing the mailbox by using cached Exchange mode. Exit MFCMAPI and change the mail profile to use online mode.

    5. Under **Top of Information Store**, select **Inbox**.
    6. Right-click **Inbox** and select **Open associated contents table**. A new MFCMAPI window will open.
    7. Sort the top pane by the **Message Class** column and locate **IPM.ExtendedRule.Message**. Only one Inbox will be displayed.
    8. Select **IPM.ExtendedRule.Message**  on the top pane.
    9. In the bottom pane, sort by the **Tag** column and locate **0x65EB001F**. This tag corresponds to the **JunkEmailRule** value.
    10. After you locate the junk email rule by locating the **0x65EB001F** tag, select **IPM.ExtendedRule.Message** again in the top pane.
    11. Right-click **IPM.ExtendedRule.Message** and select **Delete message**. The **Delete Item** window will open.
    12. In the **Deletion style** drop-down list, select **Permanent delete passing DELETE_HARD_DELETE (unrecoverable)**, and then click **OK**. (The screenshot for this step is listed below).

        :::image type="content" source="media/delete-junk-email-rules-mfcmapi-exchange/permanent-delete-passing-delete-hard-delete.png" alt-text="Screenshot for selecting Permanent delete passing DELETE_HARD_DELETE.":::

    13. **IPM.ExtendedRule.Message** should disappear from the top pane after the rule is deleted.
    14. Close the first two MFCMAPI windows.
    15. On the final MFCMAPI window, click the **Session** tab and select **Logoff**  to close the MAPI session. (The screenshot for this step is listed below).

        :::image type="content" source="media/delete-junk-email-rules-mfcmapi-exchange/select-logoff.png" alt-text="Screenshot for selecting Logoff under Session.":::

    16. Close the final MFCMAPI window.

6. Start Outlook again.
7. On the **Home** tab, in the **Delete** group, click **Junk**, and then select **Junk E-mail Options**.
8. Examine each tab for **Safe Senders**, **Safe Recipients**, and **Block Senders**. No addresses will be displayed in any of the lists. If addresses still appear, then the junk email rule wasn't deleted correctly.
9. Import email addresses into Junk Email Filter Lists by using the lists that you exported in step 2.

## References

- [Overview of the Junk Email Filter](https://support.office.com/article/overview-of-the-junk-email-filter-5ae3ea8e-cf41-4fa0-b02a-3b96e21de089?ocmsassetID=HP010355048&CorrelationId=1ce926e6-2a2d-4cb4-96a9-e3363adcf3cd)

- [Outlook Junk Email settings ignored after you move a mailbox to Exchange Server 2010](https://support.microsoft.com/help/2655142)

- [Outlook error indicating you are over your Junk E-mail list limit](https://support.microsoft.com/help/2669081)

- ["Junk e-mail validation error" error message when you manage the junk email rule for a user's mailbox in an Exchange Server 2010 environment](https://support.microsoft.com/help/2591572)
