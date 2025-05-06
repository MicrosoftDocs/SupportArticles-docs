---
title: Access public folders in Outlook for Windows
description: Describes how to access your public folders in multiple versions of Outlook for Windows.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Exchange Mailbox Accounts\Public folders
  - Outlook for Windows
  - CSSTroubleshoot
  - CI 167385
ms.reviewer: meerak, batre, v-shorestris
appliesto: 
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 03/19/2025
---

# Access public folders in Outlook for Windows

The steps to access public folders is different in new Outlook for Windows and classic Outlook for Windows. Use the information that's appropriate for your version of Outlook for Windows.

## Access public folders in new Outlook for Windows

In new Microsoft Outlook for Windows, you need to add public folders to **Favorites** before you can access them. Use the following steps:

1. Right-click the name of the account and select **Add public folder to Favorites**.

   :::image type="content" source="media/navigate-to-public-folders-in-new-outlook/select-add-pf-to-favorites.png" alt-text="Screenshot of the Add public folders to Favorites menu option after you right-click the account name." border="true":::
  
   **Notes**:
   - If you don't see this option, make sure that public folders are deployed in your tenant. Public folders that are deployed in Microsoft Exchange On-premises and hybrid Exchange environments can't be accessed from new Outlook for Windows.
   - If public folders are deployed but you don't see the option, ask an administrator to check the [Microsoft 365 admin center](https://aka.ms/pfcte) for troubleshooting steps.
1. In the pane that displays the public folder hierarchy, expand **All Public Folders**.

   :::image type="content" source="media/navigate-to-public-folders-in-new-outlook/pf-hierarchy-display.png" alt-text="Screenshot of the public folder hierarchy in the new Outlook for Windows." border="true":::
  
1. Select the public folder that you want to add to **Favorites** and then select **Add Public Folder**.

   :::image type="content" source="media/navigate-to-public-folders-in-new-outlook/select-pf-and-add-pf.png" alt-text="Screenshot of a public folder selected from the list and the Add Public Folders option highlighted." border="true":::

1. After the public folder is added, select it from the list of **Favorites** to access it.

## Access public folders in classic Outlook for Windows

In the redesigned user interface in classic Outlook, you see that:

- The horizontal navigation bar that was at the bottom of the **Folders** view is now a left-side vertical navigation bar.

- The ellipsis icon on the horizontal navigation bar is now a **More Apps** icon on the vertical navigation bar.

To access public folders in the updated design, select **More Apps** \> **Folders**.

:::image type="content" source="media/navigate-to-public-folders-in-new-outlook/outlook-new-look-apps-menu.png" alt-text="Screenshot of the Folders icon in the More Apps menu in the new Outlook for Windows." border="true":::

When you select **Folders**, the navigation bar shows a **Folders** icon. To permanently pin the **Folders** icon to the navigation bar, right-click the icon, and then select **Pin**.

:::image type="content" source="media/navigate-to-public-folders-in-new-outlook/outlook-new-look-folders-pin.png" alt-text="Screenshot of the Pin option in the right-click menu for the Folders icon." border="true":::
