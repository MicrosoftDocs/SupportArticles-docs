---
title: Project Accounting information for this vendor does not exist warning
description: Project Accounting information for this vendor does not exist this warning occurs when you select a vendor record. Provides a resolution.
ms.reviewer: theley, ppeterso
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Project Accounting information for this vendor does not exist warning in Microsoft Dynamics GP purchasing

This article provides a resolution for the issue that you can't select a vendor record due to the **Project Accounting information for this vendor does not exist** warning.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2004318

## Symptoms

When you select a vendor record in either the Purchase Order Entry or Receivings Transaction Entry window, you receive the following warning message:

> Project Accounting information for this vendor does not exist. Do you want to add the vendor's project information?

## Cause

This error will occur when all the following are true:

- You have Project Accounting installed.
- The vendor you have selected has not been set up for use with Project Accounting.

> [!NOTE]
> The error will occur even if you do not have access to the alternate security windows for Project Accounting because at the time the vendor header is entered we do not know if the document will be Project related or not. Due to this we have to verify whether it is a vendor associated with Project Accounting or not at the time the vendor is selected.

## Resolution

When the warning message appears, select **No** if you do not want this vendor added to your Project Accounting Vendor Master table. This warning will then appear every time you select that vendor for as long as you have Project Accounting code installed. If you do not want Project Accounting installed, then it can be uninstalled by using Add/Remove Programs.

If you want to continue to having Project Accounting installed, to prevent the warning message a one time population of the Project Accounting Vendor Master table needs to occur. To do that complete these steps:

1. Sign in to Microsoft Dynamics GP with a user who has access to the alternate Project Accounting window for the Vendor Maintenance window.

    > [!NOTE]
    > If there is no one with this security, follow the steps related to Vendor Maintenance found in article [The Project button is missing from the Employee Maintenance window, the Vendor Maintenance window, and the Customer Maintenance window in Microsoft Dynamics GP](https://support.microsoft.com/topic/the-project-button-is-missing-from-the-employee-maintenance-window-the-vendor-maintenance-window-and-the-customer-maintenance-window-in-microsoft-dynamics-gp-2c0da88f-53d8-0a05-f4d1-6229c43c1a55).

2. On the **Cards** menu, point to **Purchasing**, and then select **Vendor**.
3. In the Vendor ID field, enter the vendor you received the error on.
4. Select the **Project** button to open the PA Vendor Options window.
5. Select **OK** to close the window.
6. Select **Save** to save the record to the Project Accounting Vendor Master (PA00901) table.

After these steps are performed the message will no longer appear for that vendor. We recommend using these steps for all vendors you will be creating purchase orders or entering receivings transactions against.

> [!NOTE]
> When you create a new vendor, you will want to access the PA Vendor Options window so that the record is added to the table and the error is avoided.
