---
title: Cross forest free/busy lookup fails
description: Resolves an issue in which you can't see the free/busy information for attendees in other organizations. This issue occurs in a mixed Exchange environment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: excontent, message, exuetr, jmartin, aartigoyle, jarrettr, v-six
ms.custom: 
  - sap:Sharing\Issue viewing Free Busy
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
ms.date: 01/24/2024
---
# Cross forest free/busy lookup fails when target forest is Exchange Server 2013 or Exchange Server 2016

_Original KB number:_ &nbsp; 3010570

## Symptoms

Consider the following scenario:

- An organizer has a Microsoft Exchange Server 2016, Exchange Server 2013, Exchange Server 2010, or Exchange Server 2007 mailbox.

- Attendee mailbox is in another Exchange organization that uses Exchange Server 2016 or Exchange Server 2013 as the Autodiscover endpoint.

- Availability address space is used for cross-forest free/busy data.

- The Autodiscover service uses the DNS method.

In this scenario, the organizer can't view the free/busy information for the attendee and only hash marks are displayed.

> [!NOTE]
> This issue may occur on any Exchange clients, such as Microsoft Outlook, Outlook Web App, an Exchange Web Services (EWS) application, or any other client that tries to retrieve free/busy information.  

## Cause

This issue occurs because the availability service sends an Autodiscover request by using an automatically generated SMTP address for the anchor mailbox. This SMTP address that is used is 01B62C6D-4324-448f-9884-5FEC6D18A7E2@Availability_Address_Space_domain.

Example: 01B62C6D-4324-448f-9884-5FEC6D18A7E2@domain.com

However, the Exchange Server 2013 Client Access server in the attendee forest can't locate a mailbox for this email address and responds with a 404 status.

## Resolution

To resolve this issue, assign the SMTP address from the HttpProxy log error to a mailbox in the attendee forest. To do this, run the following command within the Exchange Management Shell:

```powershell
$m = Get-Mailbox <alias>
$m.EmailAddresses += "smtp:01B62C6D-4324-448f-9884-5FEC6D18A7E2@domain.com"Set-Mailbox $m -EmailAddresses $m.EmailAddresses
```

> [!NOTE]
> Replace \<alias> in the command by using the alias of the mailbox in your organization. Replace the domain *domain.com* with the domain that is found in the HttpProxy log.

## More information

This issue doesn't occur when Exchange uses the service connection point (SCP) method to locate the Autodiscover service that is in the remote forest.

The GUID 01B62C6D-4324-448f-9884-5FEC6D18A7E2 is only used when Exchange uses the DNS method to locate the Autodiscover service.  

### Logs when this issue occurs

If you check the Outlook 2010 free/busy log, it shows the following error:

> Unable to send cross-forest request for mailbox \<User Name> SMTP:\<SMTP address> because of invalid configuration., inner exception: AvailabilityAddressSpace '\<Availability Address Space domain>' couldn't be used because the Autodiscover endpoint couldn't be discovered.

If you check the Autodiscover HttpProxy log, it shows an error that resembles the following error:

> MailboxGuidWithDomainNotFound  
> HttpProxyException: Cannot find mailbox  
> 01b62c6d-4324-448f-9884-5fec6d18a7e2 with domain domain.com.
