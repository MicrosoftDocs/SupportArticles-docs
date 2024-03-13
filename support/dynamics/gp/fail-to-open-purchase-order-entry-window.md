---
title: Error when you open the Purchase Order Entry window in Purchase Order Processing in Microsoft Dynamics GP
description: Provides a solution to an error that occurs when you open the **Purchase Order Entry** window in Purchase Order Processing in Microsoft Dynamics GP.
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Error message when you try to open the Purchase Order Entry window in Purchase Order Processing in Microsoft Dynamics GP 10.0: "You don't have security privileges to open this window"

This article provides a solution to an error that occurs when you open the **Purchase Order Entry** window in Purchase Order Processing in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 945957

## Symptoms

When you open the **Purchase Order Entry** window in Purchase Order Processing in Microsoft Dynamics GP 10.0, you receive the following error message:

> You don't have security privileges to open this window. Contact your system administrator for assistance.

If you grant access to the Purchasing Agent user, the **Purchase Order Entry** window opens.

## Cause

This problem occurs because an additional resource for another add-in module needs security granted. For example, Manufacturing is the most common resource that is installed and that needs security granted.

## Resolution

To resolve this problem, use one of the following methods.

### Method 1: Grant access to the ECM_DPOP_Hidden window

> [!NOTE]
> The following steps assume that Manufacturing is the resource that causes the problem.

1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then click **Security Tasks**.

2. In the **Security Task Setup** window, specify the following fields:

    - **Task ID**: Enter a task that is assigned to the user
    - **Product**: **Manufacturing**  
    - **Type**: **Windows**  
    - **Series**: **3rd Party**

3. In the **Access List** section, click to select the **Hidden** check box to grant access to the ECM_DPOP_Hidden window.

### Method 2: Disable third-party applications and add-in products

1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Customize**, and then click **Customization Status**.

2. In the **Customization Status** window, select one of the add-in products or one of the third-party applications, and then click **Disable** to temporarily disable the product or the application.

3. Try to open the ****Purchase Order Entry**** window.

4. Repeat step 1 through step 3 to determine which add-in product or third-party application causes this problem.

For more information about how to disable third-party applications and customizations completely, click the following article number to view the article in the Microsoft Knowledge Base:

[872087](https://support.microsoft.com/help/872087) How to disable third-party products in the Dynamics.set file in Microsoft Dynamics GP  

If you have to grant security to a resource for a third-party product, contact the company that supports that product. If the product is an add-in product for Microsoft Dynamics GP, open a support incident with Microsoft to address the issue.

If you want to open a support incident with Microsoft Dynamics GP support, collect a Dexsql.log file of the error before you contact support to help you troubleshoot the problem. For more information about how to collect a Dexsql.log file, click the following article number to view the article in the Microsoft Knowledge Base:

[850996](https://support.microsoft.com/help/850996) How to create a Dexsql.log file for Microsoft Dynamics GP  

Additionally, you can try to access the **Purchase Order Entry** window by using the System Administrator user ID or any designated Power User IDs. Note your results by using the System Administrator user ID or a Power User ID. This information can help you troubleshoot the problem.
