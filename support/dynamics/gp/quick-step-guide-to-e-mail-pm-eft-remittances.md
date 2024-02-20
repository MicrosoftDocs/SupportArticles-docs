---
title: Quick step guide to E-mail PM EFT Remittances
description: Quick step guide to E-mail PM EFT Remittances in Microsoft Dynamics GP.
ms.reviewer: theley
ms.date: 02/20/2024
---
# Quick step guide to E-mail PM EFT Remittances in Microsoft Dynamics GP

This article introduces how to get the E-mail functionality to work for Payables EFT Remittances using Word Templates in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP
_Original KB number:_ &nbsp; 2998439

## Prerequisites

- Verify in the **Control Panel** > **Programs and Features** that the **Open XML SDK 2.0 for Microsoft Office** is installed. (Required)
- The **Microsoft Dynamics GP Add-in for Microsoft Word** is only needed if you will be modifying the Word Template. (Optional)

> [!NOTE]
> If you have Mekorma MICR installed, make sure the Mekorma MICR System Options are set to have email enabled, or else the **Send Document in email** checkbox in the Remittance window will not be available to mark (or grayed out). To check this setting, go to **Microsoft Dynamics GP** > **Tools** > **Setup** > **System** > **Mekorma MICR** > **System Options**. Mark the checkbox for **Enable Email Remittance** and select **Save**.

## Resolution

- Step 1: For the sake of testing, it is recommended to first get the email functionality working by using the original canned Check Remittance in your initial testing. This is important to verify the email functionality is working and to rule out any issues that may be due to an incomplete or damaged modified Word Template. Use these steps to check the security settings:

  1. Go to **Microsoft Dynamics GP** > **Tools** > **Setup** > **System** > **Alternate/Modified Forms and Reports**. And select the REPORT ID being used. (Ex. DEFAULTUSER)
  2. Leave Product as All Products. For Type, select **Reports**. For Series, leave as All or select Purchasing.
  3. In the Report List, expand **Purchasing**.
  4. Scroll down to the Check Remittance and make sure Microsoft Dynamics GP is marked. (If it is not listed, then you do not have a modified check remittance in the system.) Select **Save**.

- Step 2: Activate the E-mail functionality for the Check Remittance at the main setup level by using the following steps:

  1. Go to **Microsoft Dynamics GP** > **Tools** > **Setup** > **Company** > **E-mail Settings**.
  2. Mark the Document Options and File Formats you want to allow. (This creates the pick-list you see at the vendor level so you can customize per vendor.)
  3. Select the Purchasing Series link and mark the checkbox for Vendor Remittance. (Keep it simple as possible for testing. Don't use a Message ID yet.) Select **OK**. Select **OK** again to close the window.

- Step 3: Complete the setup for each Vendor by using these steps:

  1. Go to **Cards** > **Purchasing** > **Vendor**. Select the Vendor ID that you want to send the EFT remittance to.
  2. Next to the Address ID field, select the **World** button to open the **Internet Information** window. For testing, enter your own email address in the TO: section for E-Mail Addresses at the top. (Once it is working, you can edit it later to be the vendor's email address.) Select **Save** and close the **Internet Information** window.
  3. On the Vendor Maintenance window, select the **E-mail** button. In the bottom section, mark the checkbox for Vendor Remittance and choose which Format to use. (We recommend testing with .docx or .html first just to get it working.) Select **OK** and then select **Save**.

- Step 4: Presumably, there are already posted invoices keyed against the EFT Address ID for this vendor ready to be paid out. During the Payables checkrun process:

  1. Build a computer check batch and select EFT as the Payment Method for the new batch.
  2. When you print checks, you will get a **Process Payables Remittance** window instead of a **Print Checks** window, since it is an EFT and not a check. Mark the radio box for Remittance Form, and also mark the checkbox for Send Document in E-mail (Print if mail cannot be sent.). Select **Process**.
  3. In the **Report Destination** window, the Report Type of Template will default if a Word Template is being used. Complete and post the checkrun.
  4. The Send Remittance Exception Report will display and hopefully each says *Document sent successfully*. Review the report for any emails that did not sent successfully.

  If you have questions on how to modify the Word Template, refer to the Report Writer manual or open a support case. Note that the assistance we will provide with Word Template modifications is outlined in [Guidelines that Microsoft support professionals use to determine when a support case becomes a consulting engagement for Report Writer, SSRS, Word Templates,SmartList Builder/Designer, SQL scripts, Business Alerts, VB Script, Modifier/VBA & Configurators, Workflow](hguidelines-that-support-professionals-use.md). Anything beyond what is outlined in this article may be considered a consulting expense, and beyond what we can do in a regular support case.

- Step 5: If the test above worked successfully, then continue to grant security access to the modified Check Remittance and test again.

## More information

The above article was also published externally on this blog site:

[Quick Step Guide to E-mail PM EFT Remittances in Microsoft Dynamics GP](https://community.dynamics.com/blogs/post/?postid=abb4eb99-17a3-416b-be4a-c7925a5727cf)
