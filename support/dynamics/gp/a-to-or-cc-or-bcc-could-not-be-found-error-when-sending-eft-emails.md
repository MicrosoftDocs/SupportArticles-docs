---
title: A To or CC or Bcc Address could not be found error when sending EFT emails
description: An error that states a A or CC or Bcc address could not be found when sending EFT emails in Microsoft Dynamics.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "A To, CC, or Bcc Address could not be found" error when sending EFT emails in Microsoft Dynamics GP

This article provides a resolution for the issue that when you send EFT emails in Microsoft Dynamics GP, you receive an error message that states a To, CC, or Bcc Address could not be found.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 3124509

## Symptoms

When sending EFT emails in Microsoft Dynamics GP, you receive this error message:

> A To, CC, or Bcc Address could not be found.

## Cause

Email address missing.

## Resolution

Resolve the message by following these steps:

1. In Microsoft Dynamics GP:

    For Purchasing, select **Cards**, point to **Purchasing** and select **Vendor**.

    For Sales, select **Cards**, point to **Sales**, and select **Customer**.

2. First go to the bottom of the Vendor or Customer Maintenance window, and note the ADDRESS ID in the following field:

    REMIT TO field for a vendor  
    SHIP TO for sales documents for a customer  
    STATEMENT TO field for a statement for a customer

3. Next, to the right of the ADDRESS ID field (in the middle of the page), select the **Internet Information** icon (looks like a *world*).

4. In the Internet Information window:

    1. Scroll to the Address ID that you noted earlier in step 2 above.
    2. Then in the E-mail Addresses section, enter email addresses in the TO..., CC... or Bcc.... fields as needed. (Filling in all is not required.)
    3. Save.

5. Back on the Vendor/Customer Maintenance Card, select the **E-MAIL** button at the bottom. Make sure the appropriate type of document you want to send in email is marked.

   > [!NOTE]
   > The **Enable** button simply acts as a **Mark All/Unmark All** button only. Its the checkbox next to the document type that counts.

   You can also select a Message ID to be used, and Format type, and other settings as desired. Save your changes.

6. Now test sending the email again.

## More information

Refer to the below blog articles for more information on general setup and modifying Word Templates. It is recommended to test with the original GP Word Template to get it working, before you introduce a modified Word Template into the picture.

- [Quick Step Guide to E-mail PM EFT Remittances in Microsoft Dynamics GP 2013](https://community.dynamics.com/blogs/post/?postid=abb4eb99-17a3-416b-be4a-c7925a5727cf)
- [Quick Step Guide to E-mail PM EFT Remittances in Microsoft Dynamics GP 2010](https://community.dynamics.com/blogs/post/?postid=11e9fb89-af60-4af7-82ab-1455def05a16)
