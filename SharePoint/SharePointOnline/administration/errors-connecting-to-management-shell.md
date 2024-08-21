---
title: Errors when connecting to SharePoint Online Management Shell
description: Describes how to resolve connectivity problems to SharePoint Online Management Shell.
author: helenclu
ms.reviewer: salarson
ms.author: luche
manager: dcscontentpm
ms.date: 12/17/2023
audience: Admin
ms.topic: troubleshooting
ms.custom: 
  - sap:Permissions\Errors
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

When you try to connect to SharePoint Online Management Shell, you receive one of the following error messages:

> The remote server returned an error: (429)

> The response status code is 'Unauthorized'

> Connection disconnected: Unexpected error occurred

> No connection available

> Connect-SPOService : Could not connect to SharePoint Online.

## Resolution

1. Make sure that SharePoint Online Management Shell is up-to-date. For the steps to do this, see [Getting started with SharePoint Online Management Shell](/powershell/sharepoint/sharepoint-online/connect-sharepoint-online).

1. Verify that you're using the latest TLS protocols. For more information, see the following articles:

    - [Authentication errors occur when client doesn't have TLS 1.2 support](./authentication-errors-tls12-support.md)

    - [Preparing for TLS 1.2 in Office 365](/microsoft-365/compliance/prepare-tls-1.2-in-office-365)

1. Run PowerShell in administrative mode:

    1. Select **Start**, and then enter *powershell* in the search box.

    1. In the search results. look for **Windows PowerShell** or simply **PowerShell** (if you're using PowerShell Core).

    1. Right-click **Windows PowerShell** (or **PowerShell**), and select **Run as administrator**.

1. After PowerShell is running in administrative mode, update the execution policy of the session by running the following command:

    ```powershell
    Set-ExecutionPolicy Undefined
    ```

1. Connect to the SharePoint Admin URL that you're using by running the following command: 

    ```powershell
    Connect-SPOService -Url https://contoso-admin.sharepoint.com  
    ```
    **Note:** In this command, replace `https://contoso-admin.sharepoint.com` with the URL of the SharePoint site that you're administrating.

## References

For more information about SharePoint Online Management Shell, see the following articles:

> [Getting started with SharePoint Online Management Shell](/powershell/sharepoint/sharepoint-online/connect-sharepoint-online).

> [Cannot force Modern Authentication when using Connect-SPOService cmdlet in SharePoint Online Management Shell](..\security\cannot-force-modern-authentication.md)

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
