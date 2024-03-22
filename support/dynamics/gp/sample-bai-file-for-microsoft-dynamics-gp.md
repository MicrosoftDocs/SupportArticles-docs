---
title: Sample BAI file for Microsoft Dynamics GP
description: Provides a sample BAI file for Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick
ms.date: 03/20/2024
ms.custom: sap:Europe, Latin America, Africa, Asia, and Australia
---
# Sample BAI file for Microsoft Dynamics GP

This article introduces a sample BAI file for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP, Microsoft Dynamics SL Bank Reconciliation  
_Original KB number:_ &nbsp; 3168165

1. **File setup**: Copy the below data in-between the lines below into **Notepad**, and save the file as a .csv file to your desktop or another location where you can find it. The same data in the file is:

    date = May 30, 2016 (notice the date needs to be 160530. the format is YYMMDD, so don't drop leading zeroes on the month or day, which is why you should work in Notepad and not Excel, as the auto-formatting in Excel drops leading zeroes.)  
    Bank account = 80808080  
    Two checks #456 and #789 for $100.00 each  
    The first two digits of each line is the standard code for each line type to tell the system what type of line it is.

    > 01,,,,,,,,  
    02,,,,160530,,,  
    03,80808080,,,,,,  
    16,475,10000,,160530,,,456,  
    16,475,10000,,160530,,,789,  
    9,,  
    98,,,  
    99,20000,,2

2. **Checkbook setup**: Then in GP, go to **Cards** > **Financial** > **Checkbook**, and select the checkbook you want to use.

    1. Put the Bank Account number **80808080** in the **BANK ACCOUNT** field, or else put your actual bank account number in and then update it in the third line of the sample file above, so it matches. This is how it finds the checkbook to use. (This bank account can only be on ONE checkbook.)
    2. In the **BANK ID** field, enter a Bank ID of your choice, such as *BAI*. (Add it when prompted.)
    3. **Save** and close the checkbook.

3. **Configurator setup**: Go to **Tools** > **Routines** > **Financial** > **Electronic Reconcile** > **Configurator**.

    1. Enter a Bank format name and description of your choice, such as *BAI*.
    2. For FILE FORMAT, select **BAI** and the fields will default.
    3. Unmark the **RECORD DELIMITER** checkbox.
    4. Select the **CODES ENTRY** button in the button right.

        1. Select **CHECK PAID** and select **Save** to cache the default codes under this category.
        1. Also select **DEPOSITS REC'D** and select **Save** to cache it. Close the window.

    5. Select **SAVE**.

4. **Download setup**: Go to **Tools** > **Routines** > **Financial** > **Electronic Reconcile** > **Download Maintenance**.

    1. Enter a **BANK** **DOWNLOAD** **ID** of whatever you want, such as *BAI*.
    1. Select the BAI bank format that you created.
    1. Select the BAI bank ID that you saved on the checkbook.

       1. Select **ADD CHECKBOOK** and select the checkbook ID you worked with in #2 above.

    1. In the Download Filename and path, browse out to the bai.scv file you saved on your desktop in #1.
    1. **Save**.

5. **Download TRX**: To download the file, go to **Tools** > **Routines** > **Financial** > **Electronic Reconcile** > **Transactions Download**.

    1. Select the BAI download ID.
    2. Select **DOWNLOAD** button at the top.
    3. For a confirmation number, enter *123* and select **SUCCESSFUL**. Hopefully both checks rom the file populate in.
    4. Select **OK** at the top to close the window.

6. **Clear**. To do this again, go to **Tools** > **Routines** > **Financial** > **Electronic Reconcile** > **Summary History**, and select your download ID, and select **DELETE ALL** at the top, and select **DELETE** when prompted. Now you can bring in the file again.

## References

For more troubleshooting tips for Electronic Reconcile, bringing in bai files, and the matching process refer to the following:

- [Steps to modify the BAI file format in Electronic Reconcile in Microsoft Dynamics GP](https://support.microsoft.com/topic/steps-to-modify-the-bai-file-format-in-electronic-reconcile-in-microsoft-dynamics-gp-725574ef-b596-7af8-c289-104470a28204)
- [Setup information for Electronic Reconcile Format Configurator](https://support.microsoft.com/topic/kb-850751-setup-information-for-electronic-reconcile-format-configurator-88954a65-6af5-c843-9b61-dd5f4b85e79e)
- [How Transactions are Matched in Electronic Reconcile for Microsoft Dynamics GP](https://support.microsoft.com/topic/kb-851279-how-transactions-are-matched-in-electronic-reconcile-for-microsoft-dynamics-gp-01c9d3e1-a36a-e040-4445-dd1da7be98c0)
