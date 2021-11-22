---
title: Error when emailing EFT Remittances in Payables Management
description: Provides a solution to an error that occurs when you email EFT Remittances in Payables Management.
ms.topic: troubleshooting
ms.reviewer: cwaswick
ms.date: 03/31/2021
---
# "Not privileged to run this report" error message when emailing EFT Remittances in Payables Management for Microsoft Dynamics GP 2010

This article provides a solution to an error that occurs when you email EFT Remittances in Payables Management.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2533854

## Symptoms

The Accounts Payable user receives the permissions message below when marking the **Send Document in E-mail** (Print if mail cannot be sent.) option in the Process Payables Remittance window during the Accounts Payables Checkrun for Electronic Funds Transfers in Microsoft Dynamics GP 2010.

> Not privileged to run this report.

## Cause

The AP user will need to have security granted to Process Payables Remittances.

## Resolution

To grant access to the Accounts Payable user so they can send Payables remittances in an email, follow these steps to edit the security:

1. Click on **Microsoft Dynamics GP**, point to **Tools**, point to **Setup**, point to **System** and click on **Security Task**.
2. Select the Task ID: TRX_PURCH_016 *.

    > [!NOTE]
    > The tasks of TRX_PURCH_009, TRX_PURCH_014, or TRX_PURCH_015 would work as well.

3. Select **Product**: **Microsoft Dynamics GP**; **Type**: **Windows**; **Series**: **Purchasing**.
4. Scroll down and mark the option for Process Payables Remittance.
5. Click **Save**.
6. Then select **Product**: **Microsoft Dynamics GP**; **Type**: **Reports**; **Series**: **Purchasing**.
7. Scroll down and mark the option for PM Email Exception Report.
8. Click **Save**.
9. Now review the current roles that are assigned to the user, and verify that this Security Task is granted access to one of the roles that are assigned to the AP user. Steps to do this are below:

    - To see what roles are assigned to the user, click on **Microsoft Dynamics GP**, point to **Tools**, point to **Setup**, point to **System** and click on **User Security**. Enter the User and Company and note what roles are currently assigned to them. An example role that you may want to use is AP CLERK*, but you can use any role you want.)

    - To review the tasks that are assigned to the roles, click on **Microsoft Dynamics GP**, point to **Tools**, point to **Setup**, point to **System** and click on **Security Roles** and bring up one of the roles assigned to the user (such as AP CLERK *). Scroll down and make sure the security task for TRX_PURCH_016\* is marked to allow permissions for this role.
