---
title: Cannot find user in offline address book
description: Describes an issue in which you can't find a user in the offline address book in Microsoft 365. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: jhayes, v-lanac, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# You can't find a user in the offline address book in Microsoft 365

_Original KB number:_ &nbsp; 2427141

## Resolution - Step 1: Download the latest copy of the OAB

Download the latest copy of the OAB. To do this, follow these steps:

1. Do one of the following:
   - If you have Microsoft Office Outlook 2007, on the **Tools** menu, point to **Send/Receive**, and then select **Download Offline Address Book**.
   - If you have Outlook 2010 or Outlook 2013, on the **Send/Receive** tab, select **Send/Receive Groups**, and then select **Download Address Book**.
2. In the Offline Address Book dialog box, select to clear the **Download changes since last Send/Receive** check box, and then select **Full Details**.
3. Select **OK**.

If you receive an error message when you're downloading the OAB, there might be an issue with connecting to the Exchange Autodiscover service. Use the Test E-mail AutoConfiguration tool in Outlook to check whether the Autodiscover service and the Availability service are working. To do this, follow these steps:

1. Start Outlook.
2. Hold down the Ctrl key, right-click the Outlook icon in the notification area, and then select **Test E-mail AutoConfiguration**.
3. Make sure that the correct email address is in the **E-mail Address** box.
4. Select to clear the **Use Guessmart** check box and the **Secure Guessmart Authentication** check box.
5. On the **Test E-mail AutoConfiguration** page, select to select the **Use AutoDiscover** check box, and then select **Test**.

Make sure that this test is successful and that Outlook can retrieve the correct URLs for the Availability service. If this test isn't successful, the Autodiscover service is the reason why the OAB isn't working as expected.

## Resolution - Step 2: Check whether the person exists in the Microsoft 365 portal

Confirm that the person has a user account that's active in the Microsoft 365 portal. Also, confirm the person is licensed. To do this, follow these steps.

> [!NOTE]
> You have to be a Microsoft 365 admin to complete this step.

1. Sign in to the [Microsoft 365 portal](https://portal.office.com)).
2. Select **Admin**, and then do one of the following:
   - If you are a Microsoft 365 Enterprise customer, in the left navigation pane, select **Users and groups**.
   - If you are a Microsoft 365 Business customer, under **Users**, select **Add users, manage contacts, and more**.
3. In the **Search** box, type the user name, and then press Enter to find that user.
4. If the user is present, select the user's name and confirm that a license is assigned to the user. If the user isn't present, or if the user doesn't have an Exchange Online license, the user may not be set up in Exchange Online.

If the user is present but isn't licensed, go to the **Step 3: Confirm that the person has an Exchange Online mailbox** section. If the user isn't present, check whether the user was deleted intentionally or if the user has to be restored. For information about how to restore a user, see [Delete or Restore User Mailboxes in Exchange Online](/exchange/recipients-in-exchange-online/delete-or-restore-mailboxes).

## Resolution - Step 3: Confirm that the person has an Exchange Online mailbox

> [!NOTE]
> You have to be a Microsoft 365 admin to complete this step.

Use the Exchange admin center to make sure that the Exchange Online mailbox wasn't removed.

1. Open Exchange Admin Center. To do this, sign in to the Microsoft 365 portal, select **Admin**, and then select **Exchange**.
2. In the left navigation pane, select **Recipients**, and then select **Mailboxes**.
3. Check whether the user is set up in Exchange Online.
4. If the person who you're looking for isn't in your organization, select **Contacts** to locate the entry. If the entry was added in the last 24 hours, updates might not yet be replicated from the GAL to the OAB.

  It can take 24 to 48 hours for the GAL to update the OAB. Check back after another 24 hours to see whether the OAB is updated.
  
If the mailbox isn't present, check whether the person was deleted intentionally or if the person has to be restored. For information about how to restore a user, see [Delete or Restore User Mailboxes in Exchange Online](/exchange/recipients-in-exchange-online/delete-or-restore-mailboxes).

## More information

This issue can occur for several reasons, including the following:

- The primary Simple Mail Transfer Protocol (SMTP) address of the user was recently changed.
- You are viewing an outdated version of the OAB.
- You are searching for a user who is no longer active or who was removed.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
