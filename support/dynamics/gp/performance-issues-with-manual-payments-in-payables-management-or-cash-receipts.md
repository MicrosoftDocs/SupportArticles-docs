---
title: Performance issues with manual payments
description: Performance issues can occur with payments in Payables Management and Receivables Management if the module Payment Document Management is installed.
ms.reviewer: theley, cwaswick, lmuelle
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Financial - Receivables Management
---
# Performance issues with manual payments in Payables Management or cash receipts in Receivables Management

This article provides methods to solve the performances issues with manual payments in Payables Management or cash receipts in Receivables Management in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2468048

## Symptoms

Performance issues, posting issues, or error messages can occur with manual payments in Payables Management or cash receipts in Receivables Management if the module Payment Document Management is installed. This module will change the functionality of payments in Payables Management or Receivables Management. Some symptoms that may occur in these windows include:

- Inability to save a manual payment in Payables Management, or a cash receipt in Receivables Management. When you select the **save** button, nothing happens and there are no errors.
- Posting issues when trying to post a manual payment in Payables Management or a cash receipt in Receivables Management.
- Distribution accounts do not default into the distribution window for manual payments or cash receipts. The cash account or Account Payable account does not default into the distribution window.
- Error during posting a cash receipt:

  > Unhandled script exception  
Illegal address for field 'Check Number' in script  
'TRIGGER_ALL_Check_Number_Fields'. Script teminated.

- When going into the Payment Document Inquiry window, you may receive this message:

  > The Payment Document Management Setup is Missing or Damaged

## Cause

Payment Document Management module is installed and may cause issues with payments if it is not fully set up. This module is typically not used in a US installation.

## Resolution

Use one of the methods below to remove the Payment Document Management module:

Method 1: Use **Add/Remove Programs** in the Control Panel to remove the Payment Document Management module from your Microsoft Dynamics GP installation.

Method 2: You can manually remove the Payment Document Management module from the Dynamics.set file in GP as follows:

1. Exit Microsoft Dynamics GP.
2. Navigate to the GP Code folder. The default location is: C:\Program Files\Microsoft Dynamics\GP.

   > [!NOTE]
   > The navigation path may be slightly different than listed above, depending on where Microsoft Dynamics GP was installed.

3. Right-click on the Dynamics.set file and make a copy of it for safe-keeping.
4. Right-click on the Dynamics.set file and open it with Notepad.
5. The number in line 1 is a total of how many modules are installed, so decrement it by one. (For example, if the number in line 1 is 15, make it 14.)
6. In the module list, remove these two lines:

   2150  
   Payment Document Management

7. In the bottom section, remove the three lines below pointing to the dictionaries for this module:

   > [!NOTE]
   > The navigation path may be slightly different and should match where you found the GP code folder in step 2.

    :C:Program Files/Microsoft Dynamics/GP/PMNTDOC.DIC  
    :C:Program Files/Microsoft Dynamics/GP/2150FRM.DIC  
    :C:Program Files/Microsoft Dynamics/GP/2150RPT.DIC
  
8. Exit out of the Dynamics.set file and save the changes.
9. Restart Microsoft Dynamics GP and test again.

## More information

The Payment Document Management module was created specifically for countries/regions that use other payment methods other than cash, check or credit card, such as Spain and some other Latin American, Middle Eastern or European countries/regions. This module will change the functionality of payment windows in Payables Management and Receivables Management. Most US installs do not use this module.
