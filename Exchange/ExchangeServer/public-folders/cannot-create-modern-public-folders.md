---
title: Owner cannot create modern public folders by using Outlook in Exchange Server 2013 or Exchange Server 2016
description: Resolves an issue in which you cannot create public folders in Outlook even if you have sufficient access permissions. This issue occurs in an Exchange Server 2013 or Exchange Server 2016 environment.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Migration\Issues with Public Folder Migration
  - CSSTroubleshoot
appliesto: 
- Exchange Server 2016 Enterprise Edition 
- Exchange Server 2016 Standard Edition 
- Exchange Server 2013 Enterprise 
- Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.reviewer: batre, christys, genli, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/24/2024
---

# Owner cannot create modern public folders by using Outlook in Exchange Server 2013 or Exchange Server 2016

## Symptoms

Assume that you are the owner of a public folder mailbox or have sufficient access permissions to create a public folder in a Microsoft Exchange Server 2013 or Microsoft Exchange Server 2016 environment. The mailbox uses the secondary hierarchy as the default public folder mailbox. In this situation, when you try to create a public folder by using Microsoft Outlook, you receive the following error message:

> Cannot create the folder. You do not have sufficient permission to perform this operation on this object.
See the folder contact or your system administrator.

> [!NOTE]
> If the default public folder mailbox is changed to a public folder mailbox that contains the primary hierarchy, you can create public folders by using Outlook.

See [More information about how to troubleshoot the issue](#more-information-to-troubleshoot-this-issue) in this article.

## Cause

This issue occurs because the `LmCompatibilityLevel` registry entry on the Exchange Server Mailbox Server role is configured to a value that is less than 2.

## Workaround

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To work around this issue, follow these steps on the Exchange Server Mailbox Server role that is hosting the secondary hierarchy public folder mailbox:

1. Change the value of the `LmCompatibilityLevel` registry entry to _2_ or greater.

    > [!NOTE]
    > The entry is located under the following registry path:  
    > _HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa_

2. Restart the following services:

   - Microsoft Exchange Information Store  
   - Microsoft Exchange RPC Client Access
   - Microsoft Exchange Health Manager

## More information

For more information about the LmCompatibilityLevel setting, see the following articles:

[General information about the LmCompatibilityLevel registry entry](/previous-versions/windows/it-pro/windows-2000-server/cc960646(v=technet.10))

[Security Watch: The Most Misunderstood Windows Security Setting of All Time](/previous-versions/technet-magazine/cc160954(v=msdn.10))

### More information to troubleshoot this issue

When this issue occurs, other than the error message, you can also find the following information that may help troubleshoot this issue.

- The following message is logged under the "RPC Client Access" log in Event Viewer:

    ```output
    Client=MSExchangeRPC,,,,-2147024891 (rop::AccessDenied),00:00:00.0310000,,"RopHandler:
    CreateFolder: [AccessDeniedException] Cannot open mailbox /o=Contoso/ou=Exchange Administrative Group
    (FYDIBOHF23SPDLT)/cn=Recipients/cn=9f049c7972fb4d8ebe9f5ece73e136fe-PFHierarchy. ->
    [MapiExceptionNoAccess] Unable to make connection to the server. (hr=0x80070005, ec=-2147024891)
    [diag::AAAGAgAA/wAAAAAAAAAAA/gBAACYMvAvAQAAACwQAsAAAAAA6PIAEHA5FpCYP/AvBQAAAG4vYQBwORaQmCHwH/Q1AACYMfAvcDkWkAk00AEsEALAmCnwHw0AAACYOfAfLBACwJgl8B95BQAAmDXwHwAAAACYLfAfAAAAAOjyABBwORaQmD/wLwUAAABuL2EAcDkWkJgh8B/0NQAAmDHwL3A5FpAJNNABkQEAAJgp8B8NAAAAmDnwH5EBAACYJfAfiQUAAJg18B8AAAAAmC3wHwEAAACYIvA/AAAAAFVuYXV0aG9yaXplZAAAAADo8gAQcDkWkJg/8C8FAAAAbi9hAHA5FpCYIfAf9DUAAJgx8C9wORaQCTTQAQAAAACYKfAfDQAAAJg58B8AAAAAmCXwH+ELAACYNfAfAAAAAJgt8B8AAAAA6PIAEHA5FpCYP/AvBQAAAG4vYQBwORaQmCHwH/Q1AACYMfAvcDkWkAk00AHhCwAAmCnwHw0AAACYOfAfAAAAAJgl8B/hCwAAmDXwHwAAAACYLfAfAAAAAHHoQBAFAAeAcMVAIQAPFIQZAPAvBQAAAHDLQBAFAAeA0McAEPQ1AADxzEAQBQAHgKHqABAFAAAA8YNAEAUAB4Cd6QAQBQAAAAfNQBAFAAeAQk0AEAAAAABCbUAQBQAHgEJFABAAAAAAQmVAEAUAB4A=] 
    at M.E.D.S.RPCPrimaryHierarchyProvider.GetHierarchyStore() 
    at M.E.D.S.RPCPrimaryHierarchyProvider.CreateFolder(String folderName, String folderDescription, StoreId parentFolderId, CreateMode mode, Guid& contentMailboxGuid) 
     at M.E.R.H.PublicFolderOperations.<>c__DisplayClass1.<CreateFolder>b__0(StoreId& folderIdToSync, Guid& contentMailboxGuid) 
    at M.E.R.H.PublicFolderOperations.InvokeOnPrimaryHierarchyAndSync[T](Boolean isCompleteSync, PublicLogon publicLogon, PrimaryHierarchy",,,admin@contoso.com,
    ```

- If you run the Get-ServerHealth -Identity **ServerIdParameter**  -HealthSet 'Outlook.Protocol'  command in Exchange Management Shell (EMS), the Outlook.Protocol health set reports unhealthy, specifically for the following monitors that are related to Outlook remote procedure call RPC):

  - OutlookRpcDeepTestMonitor
  - OutlookRpcSelfTestMonitor

- The failure of the OutlookRpcDeepTestProbe probe logs the following message:

    ```output
    Microsoft.Exchange.Rpc.RpcException: Error 0x5 (Access is denied) from ClientAsyncCallState.CheckCompletion: RpcAsyncCompleteCall
    ```
