---
title: HTTP server error status (500) when signing in to EAC
description: Resolves an issue in which you, as an administrator, receive an HTTP 500 error message when you sign in to the EAC.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom:
  - CI 181061
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: batre, meerak, v-trisshores
appliesto:
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: MET150
ms.date: 10/18/2023
---

# HTTP server error status (500) when signing in to EAC

## Symptoms

When you, as an administrator, try to sign in to the Exchange Admin Center (EAC) in Microsoft Exchange Server, you receive the following error message:

> This page isn't working right now  
> \<server FQDN\> can't currently handle this request.  
> HTTP ERROR 500  

If you check the HTTP proxy logs in the *%ExchangeInstallPath%\Logging\HttpProxy\Owa* folder on the server, you find an entry that has the following values:

```output
HttpStatus: "500"
ErrorCode: "OrganizationMailboxNotFound"
Method: "POST"
RoutingHint: "WindowsIdentity-NoDatabase"
GenericErrors: "HttpProxyException=Microsoft.Exchange.HttpProxy.HttpProxyException: Unable to find
organization mailbox for organization"
```

## Cause

When an administrator tries to sign in to the EAC, Exchange Server uses the location of the admin mailbox to proxy the sign-in request. If the administrator isn't mailbox-enabled, the server tries to proxy the request to the database that hosts the arbitration mailboxes. This issue occurs if both of the following conditions are true:

- The administrator doesn't have a mailbox.
- One or more arbitration mailboxes are in an unhealthy condition.

## Resolution

To resolve the issue, create the admin mailbox, fix the arbitration mailboxes, or do both.

### Create the admin mailbox

Run the following command to create the admin mailbox:

```PowerShell
Enable-Mailbox -Identity <admin ID>
```

### Fix the arbitration mailboxes

To check the status of the arbitration mailboxes, run the following command:

```PowerShell
Get-Mailbox -Arbitration
```

If you run this command when the arbitration mailboxes exist and are healthy, the output lists seven mailboxes and contains no warnings or error messages. Fix any arbitration mailboxes that are missing or unhealthy by following the steps in [Re-create missing arbitration mailboxes](/exchange/architecture/mailbox-servers/recreate-arbitration-mailboxes).
