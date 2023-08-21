---
title: Quick step guide to email PM EFT Remittances in Microsoft Dynamics GP 2010
description: Describes steps to email PM EFT Remittances in Microsoft Dynamics GP 2010.
ms.reviewer: cwaswick
ms.topic: how-to
ms.date: 03/31/2021
---
# Quick step guide to email PM EFT Remittances in Microsoft Dynamics GP 2010

This article describes a new functionality to email out the EFT Remittance in Payables Management offered in Microsoft Dynamics GP 2010.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2998443

## Prerequisites

- Microsoft Office 2007 or Office 2010.
- Microsoft Outlook must be 32 bit. (Click **File** > **Help** and you should see '32-bit' written next to the Version number on the right side.)
- Verify in **Control Panel** > **Programs and Features** that the "Open XML SDK 2.0 for Microsoft Office" is installed. (Required)
- The "Microsoft Dynamics GP Add-in for Microsoft Word" is only needed if you'll be modifying the Word Template. (Optional)

For testing, set the security in Dynamics GP to the original unmodified Check Remittance. (**Tools** > **Setup** > **System** >**Alternate Modified Forms and Reports**). It's easiest to use the original check remittance for the sake of testing and make sure you can get the emails to send successfully first, before you introduce a modified Check Remittance into the picture.

> [!NOTE]
> If you have Mekorma MICR installed, make sure theMekorma MICR System Optionsare set to have email enabled, or else the "Send Document in email' checkbox in the Remittance window will not be available to mark (or grayed out). To check this setting, go to **Microsoft Dynamics GP** > **Tools** > **Setup** > **System** > **Mekorma MICR** > **System Options**.  Mark the checkbox for **'Enable Email Remittance'** and click **Save**.

## Step 1: Go to Microsoft Dynamics GP|Tools|Setup|Company|Email Settings

1. Mark the Document Options and File Formats you want to allow. (This step creates the pick-list you see when you set it up for each vendor.)
1. Click the **Purchasing** Series link and mark the checkbox for **Vendor Remittance**. (Keep it simple as possible for testing. Don't use a Message ID yet.) Click **OK**. Click **OK** again to close the window.

## Step 2: Go to Cards|Purchasing|Vendor. Select the Vendor ID that you want to send the remittance to

1. Next to the Address ID, click on the 'i' button to open the *Internet Information window*. For testing, enter your own email address in the **TO:** section for E-Mail Addresses at the top. (Once it's working, you can edit it later to be the vendor's email address.) Click **Save** and close the *Internet Information window*.
1. On the **Vendor Maintenance** window, click the **E-mail** button. In the bottom section, mark the checkbox for **Vendor Remittance** and choose which Format to use. (We recommend testing with **.docx** or **.html** first just to get it working.)

## Step 3: During the Payables checkrun process

1. Outlook must be open on the same workstation that Dynamics GP 2010 is on.
1. Build a computer check batch and select **EFT** as the Payment Method for the new batch.
1. When you click to print checks, you'll get a **Process Payables Remittance** window instead of a **Print Checks** window, since it's an EFT and not a check. Mark the radio box for **Remittance** Form, and also mark the checkbox for**Send Document in E-mail**. Click **Process**.

## Step 4: You should receive the test email for review

Once you've tested and the emails are working successfully, make sure to change the email address on the vendor to be their email address and not yours

## Step 5: Verify in your Sent Items folder in Outlook that the emails went out

They could still be in the Outbox too, so make sure they aren't stuck there because of Outlook settings.)

If these steps don't work for you, please open a support incident or refer to the Report Writer manual for more information on using Word Template functionality. If you have questions on how to modify the Word Template, refer to the Report Writer manual or open a support case. Note that the assistance we'll provide with Word Template modifications is outlined in Knowledge Base (KB) # [850201](https://support.microsoft.com/help/850201).

Anything beyond what is outlined in this KB article may be considered a consulting expense, and beyond what we can do in a regular support case. Refer to our policy outlined below:

[850201](https://support.microsoft.com/help/850201) Guidelines that Microsoft support professionals use to determine when a support case becomes a consulting engagement for Report Writer, SSRS, Word Templates, SmartList Builder, SQL scripts, Business Alerts, VB Script, Modifier/VBA, and Configurator Files

## More information

The above article has also been published externally on the blog site:

[Quick Step Guide to E-mail PM EFT Remittances in Microsoft Dynamics GP 2010](https://community.dynamics.com/blogs/post/?postid=11e9fb89-af60-4af7-82ab-1455def05a16)

