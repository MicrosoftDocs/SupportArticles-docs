---
title: Outlook send receive errors HTTP 0 HTTP 404 HTTP 500
description: Provides a resolution for the errors HTTP 0, HTTP 404, and HTTP 500 that may occur in the Outlook status bar.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:People or Contacts\SharePoint contacts
  - CSSTroubleshoot
appliesto:
- Outlook
search.appverid: MET150
ms.reviewer: rakeshs, aruiz, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/30/2024
---
# Outlook send/receive errors HTTP 0, HTTP 404, HTTP 500

## Symptoms

When you are using Microsoft Outlook 2010 or Microsoft Outlook 2013, you receive the following error in the Outlook status bar:

> Send/Receive Error

When you select the error, the Outlook Send/Receive Progress dialog opens and displays one or more of the following errors:

> Task 'SharePoint' reported error (0x80040102) : 'Outlook cannot connect to the SharePoint List (_site name - list name_). The server may not be reachable from your location. Contact the SharePoint site administrator for more information. HTTP 0.'

> Task 'SharePoint' reported error (0x8004010F) : 'The SharePoint List (_site name - list name_) cannot be found. If the problem continues, contact the SharePoint site administrator. HTTP 404.'

> Task 'SharePoint' reported error (0x80004005) : 'An error occurred in this SharePoint List (_site name - list name_). Try updating the folder again. If the problem continues, contact the SharePoint site administrator. HTTP 500.  
> The server returned the following error message: Exception of type  
> 'Microsoft.SharePoint.SoapServer.SoapServerException' was thrown.'

## Cause

The SharePoint list no longer exists or you cannot connect to it.

## Resolution

If you no longer have to synchronize with the specific SharePoint list mentioned in the error, follow these steps to remove the SharePoint list from Outlook:

1. Select **File**, and then select **Account Settings**.
2. Select **Account Settings**, and then select **SharePoint Lists**.
3. In the **Account Settings** dialog box, double-click the SharePoint list for which you received the error.
4. Clear the check on **Display this list on other computers with the account:** and then select **OK**.
5. Make sure that the SharePoint list for which you received the error is still selected, and then select **Remove**.
6. Close the **Account Settings** dialog box.

> [!NOTE]
> If you have multiple Outlook clients connected to the same email account, you may have to wait until the changes are synchronized to your other Outlook clients. If the SharePoint List is still listed on the other Outlook clients, repeat these steps on each of those clients.
