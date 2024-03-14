---
title: Disable home page features
description: Describes how to disable home page features in Microsoft Dynamics GP by using Microsoft Dynamics GP or by using a SQL query.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/13/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# How to disable home page features in Microsoft Dynamics GP

This article describes how to disable the home page feature in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 917998

## Introduction

The users in your organization can use the role-based home page feature in Microsoft Dynamics GP. However, your company might have a policy that doesn't let these Microsoft Dynamics GP users use the home page. So you can disable the home page feature for particular Microsoft Dynamics GP users. To disable the home page feature, use one of the following methods.

## Method 1: Use Microsoft Dynamics GP

A user-specific setting determines whether the home page appears or not. So you can disable the home page feature when you sign in to Microsoft Dynamics GP. To do it, follow these steps.

### Microsoft Dynamics GP 2013, Microsoft Dynamics GP 2010, and Microsoft Dynamics GP 10.0

1. Sign in to Microsoft Dynamics GP.
2. On the home page, select the **Customize this page** link.
3. In the **Customize Home Page** window, select to clear the following check boxes under **Mark Content to Display**:
   - **To Do**  
   - **Microsoft Outlook**  
   - **Metrics**  
   - **My Reports**  
   - **Quick Links**
4. Select **OK**.

### Microsoft Dynamics GP 9.0

1. Sign in to Microsoft Dynamics GP.
2. On the home page, select the **Customize this page** link.
3. In the **Customize Home Page** window, select to clear the **Display home page when Microsoft Dynamics GP starts** check box and the **Update my home page every hour** check box.

## Method 2: Use Microsoft SQL Query Analyzer, SQL Server Management Studio, or Support Administrator Console

You can also configure the home page layout display by using SQL Query Analyzer, SQL Server Management Studio, or Support Administrator Console. The home page layout display is located in the SY08100 table in Microsoft Dynamics GP 10.0 or higher versions, and in the SY08000 table in Microsoft Dynamics GP 9.0.

To disable a feature on the home page, use one of the following procedures, depending on whether you want to enable or disable the home page feature for a particular Microsoft Dynamics GP user or for all Microsoft Dynamics GP users.

### Microsoft Dynamics GP 2013, Microsoft Dynamics GP 2010 and Microsoft Dynamics GP 10.0

- Disable the home page feature for a particular Microsoft Dynamics GP user. To do it, run the following SQL query:

    ```sql
    UPDATE DYNAMICS..SY08100 SET Visible=0 WHERE USERID='XXX'
    ```

    > [!NOTE]
    > Replace **XXX** with the user ID of the particular user for whom you want to disable the home page.

- Disable the home page feature for all Microsoft Dynamics GP users. To do it, run the following SQL query:

    ```sql
    UPDATE DYNAMICS..SY08100 SET Visible=0
    ```

### Dynamics GP 9.0

- Disable the home page feature for a particular Microsoft Dynamics GP user. To do it, run the following SQL query:

    ```sql
    UPDATE DYNAMICS..SY08000 set DISPHP = 0 where USERID = 'XXX'
    ```

    > [!NOTE]
    > Replace **XXX** with the user ID of the particular user for whom you want to disable the home page.
- Disable the home page feature for all Microsoft Dynamics GP users. To do it, run the following SQL query:

    ```sql
    UPDATE DYNAMICS..SY08000 set DISPHP = 0
    ```

## References

For more information, see [Frequently asked questions about the home pages and area pages features in Microsoft Dynamics GP](https://support.microsoft.com/help/918313).
