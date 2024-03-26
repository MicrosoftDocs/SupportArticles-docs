---
title: Can't open an Access desktop database in SharePoint Online
description: Fix an issue in which you receive the error Could not execute query; could not find linked table when trying to open an Access desktop database in SharePoint Online.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Sites\Other
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# "Could not execute query; could not find linked table" error message when you open an Access desktop database in SharePoint Online

## Problem

When you try to open a Microsoft Access desktop database in Microsoft SharePoint Online, you receive the following error message:

**Could not execute query; could not find linked table.**

## Solution

To resolve this issue, follow these steps:

1. In the Microsoft Access web app, create a new connection.
1. In your Access desktop database, delete all linked tables.
1. Relink the tables in the Access desktop database by using the information about the new connection for the Access web app.

To create a new connection in the Access web app and view the new connection information, follow these steps:

1. Open the Access web app in the Access client. To do this, follow these steps:

   1. Browse to the SharePoint Online site where the Access webapp exists.
   1. Click the gear icon for the settings menu, and then click **Design customization in Access**.

1. In the Access client, click **File** on the ribbon, and then click Info.
1. Click **Manage** in the **Connections** section of the **Info** page.
1. Disable the following settings if either or both are enabled:

   - Enable Read-Only Connection
   - Enable Read Write Connection

1. Close the Access client.
1. Reopen the Access web app in the Access client.
1. Click **File** on the ribbon, and then click **Info**.
1. Click **Manage** in the **Connections** section of the **Info** page.
1. Check to activate the following settings, as appropriate for your situation:

   - Enable Read-Only Connection
   - Enable Read Write Connection

1. View the new connection information. To do this, click one of the following buttons:

   - View Read-Only Connection Information
   - View Read-Write Connection Information

1. Re-create the linked tables in your Access database by using the new connection information that's listed.

If other users are connected to the same data in the Access web app, you'll have to give them information about the new connection that you created in the previous steps.

> [!NOTE]
> If you don't have the client version of the Access web app, open the Access web app in the Access client. To do this, follow these steps:
> 1. Browse to the SharePoint Online site where the Access web app exists.
> 1. Click the gear icon for the settings menu, and then click **Customize in Access**.

## More information

This issue may occur when you open an Access desktop database that has tables that are linked to an Access web app in SharePoint Online.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
