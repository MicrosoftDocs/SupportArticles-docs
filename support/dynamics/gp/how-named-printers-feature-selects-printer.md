---
title: How the named printers feature selects a printer in Microsoft Dynamics GP
description: Describes how the named printers feature selects a printer in Microsoft Dynamics GP. The named printers feature is a workstation-based feature.
ms.topic: how-to
ms.reviewer: theley, Kyouells
ms.date: 03/20/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# How the named printers feature selects a printer in Microsoft Dynamics GP

This article describes how the named printers feature selects a printer in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 935790

The named printers feature is a workstation-based feature. Each workstation has a machine ID that is stored in the Dex.ini file. This machine ID is typically based on the network ID of the workstation.

When a printer task is assigned to a printer class, you can select one of the following printer classes in the **Assign Named Printers** window:

- **System**
- **User**
- **Company**
- **User & Company**
- **Any Printer ID**
- **Manual Selection**
- **None**  

For more information about these printer classes, see the following descriptions.

## System

If you select **System** in the **Printer Class** field, the named printers feature uses the selected printer ID for all users and for all companies.

## User

If you select **User** in the **Printer Class** field, you must select a printer ID that is assigned to the User printer class for each user in the **Assign Named Printers** window.

## Company

If you select **Company** in the **Printer Class** field, you must select a printer ID that is assigned to the Company printer class for each company in the **Assign Named Printers** window.

## User & Company

If you select **User & Company** in the **Printer Class** field, you must select a printer ID that is assigned to the "User & Company" printer class. You must select this printer ID for each user in the **Assign Named Printers** window and for each company combination in the **Assign Named Printers** window.

> [!NOTE]
> If you select one of the following four options, and you do not select a printer ID, the named printers feature prompts you to define a printer ID that is assigned to the same printer class:
>
> - **System**  
> - **User**  
> - **Company**  
> - **User & Company**

You are prompted for this printer ID when you print a document.

## Any Printer ID

If you select **Any Printer ID** in the **Printer Class** field, you are prompted for the printer ID when you print a document. You can select the printer ID from any printer class.

## Manual Selection

If you select **Manual Selection** in the **Printer Class** field, the Printer Selection window opens when you print a document. This is the same window that opens when you click **Print Setup** on the **File** menu.

If no valid printer selection can be made for the current user, and if the current user is mapped to a template user ID, the named printers feature repeats the selection process. However, the named printers feature uses the template user ID to find a valid printer selection. Template users can be configured in the "Setup Named Printers - Advanced" window. To open the "Setup Named Printers - Advanced" window, follow these steps:

1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Named Printers**.
2. In the **Assign Named Printers** window, click **Setup**.
3. In the Setup Named Printers window, click **Advanced**.

If a printer task is assigned to the User printer class, the Machine ID window prompts you for a printer ID for all users on a workstation. For an example of why you are prompted for a printer ID, consider the following scenario:

1. A workstation has a machine ID. A printer ID that is assigned to the User printer class is created for User A. When User A is selected in the **User ID** field in the **Assign Named Printers** window, the printer class for a printer task is changed to User. The printer ID that was previously created is selected.

2. User B logs on to the workstation. User B prints this printer task. The named printers feature sees that the printer task is assigned to the User printer class. But there is no printer ID selected for User B.

3. The named printers feature checks whether the current user is associated with a template user. If the current user is associated with a template user, the named printers feature looks for a valid printer ID selection for the template user ID.

4. If no printer ID can be selected, the Named Printers window prompts the user to enter a printer ID that is assigned to the User printer class.

To prevent the Machine ID window from appearing, use one of the following methods:

- Define a printer ID for each user of the workstation.
- Use a template user, and then assign other users to the template user.

We recommend that you set up a template user when you set up a system on which Terminal Server is installed. In this situation, you can group users who need the same printer configuration. Additionally, you can set up a template user by using a single user ID.
