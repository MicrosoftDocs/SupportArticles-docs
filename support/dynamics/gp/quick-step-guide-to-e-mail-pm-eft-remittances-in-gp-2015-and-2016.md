---
title: Quick step guide to e-mail PM EFT remittances
description: Quick step guide to E-mail PM EFT Remittances in Microsoft Dynamics GP 2015 and Microsoft Dynamics GP 2016.
ms.reviewer: theley, cwaswick
ms.date: 03/13/2024
ms.custom: sap:Financial - Payables Management
---
# Quick step guide to E-mail PM EFT Remittances in Microsoft Dynamics GP 2015 and Microsoft Dynamics GP 2016

This article introduces a quick step guide to E-mail PM EFT Remittances in Microsoft Dynamics GP 2015 and Microsoft Dynamics GP 2016.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4019985

## Prerequisites

- Supported versions of Microsoft Office for **Microsoft Dynamics GP 2015**:
  - Microsoft Office 2010 - 64-bit Office must use Exchange only. 32-bit Office can use either Exchange or MAPI.
  - Microsoft Office 2013 - 64-bit Office must use Exchange only. 32-bit Office can use either Exchange or MAPI.
  - Microsoft Office 2016 (Dynamics GP 2015 R2 or later) - 64-bit Office must use Exchange only. 32-bit Office can use either Exchange or MAPI.
  - Office 365 - Both 64-bit or 32-bit must use Exchange. (For an Online Exchange Server there typically isn't a MAPI client installed.)

- Supported versions of Microsoft Office for **Microsoft Dynamics GP 2016**:
  - Microsoft Office 2013 - 64-bit Office must use Exchange only. 32-bit Office can use either Exchange or MAPI.
  - Microsoft Office 2016 - 64-bit Office must use Exchange only. 32-bit Office can use either Exchange or MAPI.
  - Office 365 - Both 64-bit or 32-bit must use Exchange. (For an Online Exchange Server there typically isn't a MAPI client installed.)

- Verify in the **Control Panel** > **Programs and Features** that the **Open XML SDK 2.0 for Microsoft Office** is installed. (Required)
- The **Microsoft Dynamics GP Add-in for Microsoft Word** is only needed if you will be modifying the Word Template. (Optional)

> [!NOTE]
> If you have Mekorma MICR installed, make sure the Mekorma MICR System Options are set to have email enabled, or else the **Send Document in email** checkbox in the Remittance window will not be available to mark (or grayed out). To check this setting, go to **Microsoft Dynamics GP** > **Tools** > **Setup** > **System** > **Mekorma MICR** > **System Options**. Mark the checkbox for **Enable Email Remittance** and select **Save**.

## Steps

### Step 1 - Default form

First, set security to the default Check Remittance. It is best to test with the default check remittance form just to verify that you can get the email functionality working, before you introduce a modified form into the picture. Use these steps to check the security settings:

1. Go to **Microsoft Dynamics GP** > **Tools** > **Setup** > **System** > **Alternate/Modified Forms and Reports**. and select the REPORT ID being used.  (Ex. DEFAULTUSER)
2. Leave Product as **All Products**. For Type, select **Reports**. For Series, leave as **All** (or select Purchasing) and tab through the line.
3. In the Report List, expand **Purchasing**.
4. Scroll down to the **Check Remittance** and make sure **Microsoft Dynamics GP** is marked. (If it is not listed, then you do not have a modified check remittance.) Select **Save**.

### Step 2 - Setup

Activate the E-mail functionality for the Check Remittance at the main setup level by using the following steps:

1. Go to **Microsoft Dynamics GP** > **Tools** > **Setup** > **Company** > **E-mail Settings**.
2. Mark the Document Options and File Formats you want to allow. (This creates the pick-list you see at the vendor level so you can customize per vendor. If you are not sure, mark all the sections.)
3. Select the **Purchasing Series** link and mark the checkbox for **Vendor Remittance**. (If the standard Remittance message ID pops in, you can leave it. Don't use a custom message ID yet that you created. Keep it simple as possible for testing.) Select **OK**. Select **OK** again to close the window.

### Step 3 - Vendor setup

Complete the setup for each Vendor by using these steps:

1. Go to **Cards** > **Purchasing** > **Vendor.** Select the Vendor ID that you want to send the EFT remittance to. (I am going to assume the vendor only has one address ID set up.)
2. Note the Address ID in the **REMIT TO** field.
3. Drill back on the Address ID in the REMIT TO field to open theVendor Address Maintenance window. (Or select the ADDRESS BUTTON and scroll to the address ID in the REMIT TO address field.)
4. Next to the **Address ID** field, select the **World** icon to open theInternet Information window.
5. For testing purposes, enter your own email address in the **TO:** section for E-Mail Addresses at the top. (Once it is working, you can edit it later to be the vendor's correct email address.) Select **Save** and close theInternet Information window.
6. Also on the Vendor Maintenance window, email the **E-mail** button at the bottom. In the bottom section, mark the checkbox for **Vendor Remittance** and choose which Format to use. (We recommend testing with **.docx** or .html first just to get it working. The **Enable** checkbox servers only as a **mark-all** button so does not need to be marked.) Select **OK** and then select **Save**.
7. If you select the **Address** button and **EFT BANK**, you can verify that you have the EFT banking information filled in on the vendor. This is the address ID that should be in the **REMIT TO** field on the Vendor Maintenance card. (I assume the vendor already has EFT working, and you just want to email the remittance, so we won't cover EFT setup.)

### Step 4 - Process

Presumably, there are already posted invoices keyed against the Address ID for this vendor ready to be paid out. During the Payables checkrun process:

1. Outlook must be open on the same workstation that Dynamics GP is on.
2. When creating the computer check batch, select **EFT** as the Payment Method for the new batch, and your **Checkbook ID** that is set up to process EFTs.
3. When you print checks, you will get aProcess Payables Remittance window instead of aPrint Checks window, since it is an EFT and not a check. Mark the radio box for **Remittance Form**, and also mark the checkbox for **Send Document in E-mail (Print if mail cannot be sent.)**. Select **Process**.
4. In theReport Destination window, the Report Type of **Template** will default if a Word Template is being used. (**Under Reports** > **Template Configuration**, the Enable Report Templates checkbox should be marked.) Complete and post the checkrun.
5. The **Send Remittance Exception Report** will display a status such as Document sent successfully. Review the report for any emails that did not sent successfully.

### Step 5 - Verify

Go to Outlook to verify that you received the test email. Check the **Sent Items** folder in Outlook to verify that the emails went out. (They could still be in the Outbox too, so make sure they are not stuck there due to Outlook settings.)

If these steps don't work for you, open a support incident or refer to the Report Writer manual for more information on using Word Template functionality. If you have questions on how to modify the Word Template, refer to the Report Writer manual or open a support case. Note that the assistance we will provide with Word Template modifications is outlined in [Guidelines that Microsoft support professionals use to determine when a support case becomes a consulting engagement for Report Writer, SSRS, Word Templates,SmartList Builder/Designer, SQL scripts, Business Alerts, VB Script, Modifier/VBA & Configurators, Workflow](https://support.microsoft.com/topic/guidelines-that-microsoft-support-professionals-use-to-determine-when-a-support-case-becomes-a-consulting-engagement-for-report-writer-ssrs-word-templates-smartlist-builder-designer-sql-scripts-business-alerts-vb-script-modifier-vba-configurators-workflow-604e49e4-4954-3f43-0778-da923ffd46af). Anything beyond what is outlined in this KB article may be considered a consulting expense, and beyond what we can do in a regular support case.

### Step 6 - Proceed

If the test above worked successfully, then continue to grant security access to the modified Check Remittance and continue to test with the modified report.

## More information

To access the blog article for Microsoft Dynamics GP 2010, see [Quick Step Guide to E-mail PM EFT Remittances in Microsoft Dynamics GP 2010](https://community.dynamics.com/blogs/post/?postid=11e9fb89-af60-4af7-82ab-1455def05a16).

To access the blog article for Microsoft Dynamics GP 2013, see [Quick Step Guide to E-mail PM EFT Remittances in Microsoft Dynamics GP 2013](https://community.dynamics.com/blogs/post/?postid=abb4eb99-17a3-416b-be4a-c7925a5727cf).

## References

For further assistance or troubleshooting tips for modifying Word templates, please search our blog site or the communities for other helpful articles published.  Here are the links to a few helpful blogs, and there are many more out there:

- [How to display more than four line item comments in the SOP Blank Invoice Word Template](https://community.dynamics.com/blogs/post/?postid=c723196c-830c-4fed-b567-c4d12ba4d83d)
- [Word Template borders not printing correctly after making modifications?](https://community.dynamics.com/blogs/post/?postid=2e7e1421-b3e5-4f76-b269-e5d3322b8650)
