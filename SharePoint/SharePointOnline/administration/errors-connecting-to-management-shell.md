---
title: Errors when connecting to SharePoint Online Management Shell
description: Describes how to resolve an issue when unable to connect to SharePoint Online Management Shell.
author: salarson
ms.author: v-matham
manager: dcscontentpm
localization_priority: Normal
ms.date: 06/04/2021
audience: Admin
ms.topic: article
ms.service: sharepoint-online
ms.custom: 
- CSSTroubleshoot
- CI 150508
search.appverid:
- SPO160
- MET150
ms.assetid: 
appliesto:
- SharePoint Online
---

# Errors when connecting to SharePoint Online Management Shell

## Symptoms

When you try to connect to SharePoint Online Management Shell, you might encounter one of the following errors:

> The remote server returned an error: (429)

> The response status code is 'Unauthorized'

> Connection disconnected: Unexpected error occurred

> No connection available

> Connect-SPOService : Could not connect to SharePoint Online.

## Resolution

1. Make sure SharePoint Online Management Shell is up to date. For the steps to do this, see [Getting started with SharePoint Online Management Shell](/powershell/sharepoint/sharepoint-online/connect-sharepoint-online).

1. Check that you are using the latest TLS protocols. For more information, see the following articles:

    - [Authentication errors occur when client doesn't have TLS 1.2 support](./authentication-errors-tls12-support.md)

    - [Preparing for TLS 1.2 in Office 365](/microsoft-365/compliance/prepare-tls-1.2-in-office-365)

1. Run PowerShell in administrator mode:

    - Select Start and type *powershell* in the search box.  

    - Look for **Windows PowerShell** or just **PowerShell** (if using PowerShell Core) in the search results.

    - Right-click on **Windows PowerShell** (or just **PowerShell**), and select **Run as administrator**.

1. After PowerShell is running as administrator, update the execution policy of the session by running the following command:

    ```powershell
    Set-ExecutionPolicy Undefined
    ```

1. Connect to the SharePoint Admin URL you are using with the following command: 

    ```powershell
    Connect-SPOService -Url https://contoso-admin.sharepoint.com  
    ```
    (Replace `https://contoso-admin.sharepoint.com` in this example with the URL of the SharePoint site you are administrating) 

## References

For more information on SharePoint Online Management Shell please visit, [Getting started with SharePoint Online Management Shell](/powershell/sharepoint/sharepoint-online/connect-sharepoint-online).

You can also reference [Cannot force Modern Authentication when using Connect-SPOService cmdlet in SharePoint Online Management Shell](..\security\cannot-force-modern-authentication.md)

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).