---
title: Can't open a shared folder in Outlook on the web in Exchange Server
description: Describes an issue that prevents you from opening a shared folder in Outlook on the web. Provides a workaround.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto: 
- Exchange Server 2016 Enterprise Edition 
- Exchange Server 2016 Standard Edition 
- Exchange Server 2010 Enterprise 
- Exchange Server 2010 Standard 
- Exchange Server 2013 Enterprise 
- Exchange Server 2013 Standard Edition 
- Exchange Online
search.appverid: MET150
ms.reviewer: abdallaa, excontent, ninob, kellybos, jmartin, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/24/2024
---
# Can't open a shared folder in Outlook on the web in Exchange Server

## Symptoms

Consider the following scenarios:

### Scenario 1

- You have Microsoft Exchange Server 2016 or Exchange Server 2013 coexistent in an Exchange Server 2010 environment.
- User1 has a mailbox on Exchange Server 2016 or Exchange Server 2013.
- User2 has a mailbox on Exchange Server 2010.
- User1 has full access permissions to the mailbox for User2.

### Scenario 2

- You have a hybrid Microsoft 365 environment.
- User1 has a mailbox in the cloud.
- User2 has a mailbox on-premises.
- User1 has full access permissions to the mailbox for User2.

In these scenarios, User1 can't expand the mailbox for User2 after User1 added the mailbox by using the **Add shared folder** option. Additionally, User1 receives the following error message:

> Can't complete your request.  
> You might not have permission to perform this action.

**Note** In scenario 2, if User1 has a mailbox on-premises and User2 has a mailbox in the cloud (that is, regardless of which environment hosts which mailbox), User1 can't expand the mailbox for User2.

## Cause

The AddSharedFolder  request is successful and adds the shared mailbox to the folder list. However, the request to expand the shared mailbox is proxied to the mailbox server for the user. This triggers a " WrongServerVersionException" message and a status of HTTP 500 . The HTTP response may include the following:

```http
 {"Body":{"ErrorCode":500,"ExceptionName":"WrongServerVersionException","FaultMessage":"The Client Access server version doesn't match the Mailbox server version of the resource that was being accessed. To determine the correct URL to use to access the resource, use Autodiscover with the address of the resource.", "IsTransient":false,"StackTrace":"Microsoft.Exchange.Services.Core.Types.WrongServerVersionException: The Client Access server version doesn't match the Mailbox server version of the resource that was being accessed. To determine the correct URL to use to access the resource, use Autodiscover with the address of the resource. \u000d\u000a at Microsoft.Exchange.Services.Core.Types.StoreSessionCacheBase.ConnectOnce(ExchangePrincipal mailboxToAccess, CallContext callContext, Boolean unifiedLogon)\u000d\u000a at
```

## Workaround

To work around this issue, use the **Open another mailbox** option in Outlook on the web to open a shared mailbox where you have **Full Access**  permission.
 **Note:**  This will generate a redirection link and credentials prompt before you can access the mailbox. For more information, read Mailbox permissions supported in hybrid environments section in [this article](/Exchange/permissions#delegate-mailbox-permissions).
