---
title: What the UserAgent property value refers to in the unified audit log
description: Describes what the value for the user agent in a unified audit log refers to and how to disable legacy protocols.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Auditing
  - CSSTroubleshoot
ms.reviewer: munatara, ioana
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 06/24/2024
---

# UserAgent property value in the unified audit log from the Security & Compliance Center

_Original KB number:_&nbsp;4487380

## Summary

When you pull the unified audit log from the Office 365 Security & Compliance Center for successful or failed sign-in, you see the following value for the **UserAgent** property. This article explains what the information refers to.

`"Name":"UserAgent","**Value**":"**CBAInPROD**"`

The details of the audit log may resemble the following:

`{'CreationTime':'YYYY-MM-DD','Id':'GUID','Operation':'UserLoginFailed','OrganizationId': 'OrganizationId','RecordType':15,'ResultStatus':'Failed','UserKey':'10037FFE8BE14EC8@contoso.com', 'UserType':0,'Version':1,'Workload':'AzureActiveDirectory','ClientIP':'192.168.0.1','ObjectId':'Unknown','UserId':'user@contoso.com', 'AzureActiveDirectoryEventType':1,'ExtendedProperties':[{'Name':'UserAgent','Value':'CBAInPROD'}`

## More information

User agent usually refers to the information about the user's browser. In this particular case, it indicates that you use a legacy protocol such as POP or IMAP to access your mailbox.

Legacy email clients use Basic authentication. Basic authentication in Exchange Online accepts a user name and a password for client access requests. Blocking Basic authentication can help protect an Exchange Online organization from brute force or password spray attacks. To block basic authentication, see [Disable Basic authentication in Exchange Online](/exchange/clients-and-mobile-in-exchange-online/disable-basic-authentication-in-exchange-online).
