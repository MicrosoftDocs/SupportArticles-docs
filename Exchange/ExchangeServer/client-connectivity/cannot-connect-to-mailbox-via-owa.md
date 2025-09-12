---
title: Cannot connect to a mailbox from OWA
description: Describes the issue in which you cannot use IMAP4 or POP3 to connect to an Exchange Server 2010 mailbox through Outlook Web App (OWA).
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Clients and Mobile\Can't Connect to Mailbox with OWA
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: davefor, v-six
appliesto: 
  - Exchange Server 2010 Standard
  - Exchange Server 2010 Enterprise
search.appverid: MET150
ms.date: 01/24/2024
---
# You cannot connect to an Exchange Server 2010 mailbox from Outlook Web App

_Original KB number:_ &nbsp; 980049

## Symptoms

You can't use POP3 or IMAP4 to connect to an Exchange Server 2010 mailbox through Microsoft Office OWA. When you try to connect, you receive following error message:

> A problem occurred while you were trying to use your mailbox.

If you select **Show details**, you see that the following exception causes the error:

> Microsoft.Exchange.Data.Storage.TooManyObjectsOpenedException

If you try to use a Telnet connection to try to connect to the mailbox by using POP or IMAP, you receive this error message:

> No Server
>
> Unavailable 15

The server that is running Exchange Server 2010 logs an error in the Application log that resembles the following:

> Log Name: Application  
Source: MSExchangeIS  
Date: *dd/mm/yyyyhh:mm:ss*  
Event ID: 9646  
Task Category: General  
Level: Error  
Keywords: Classic  
User: N/A  
Computer: *Servername.contoso.com*  
Description:  
Mapi session "/o=**First Organization**/ou=Exchange Administrative Group (FYDIBOHF23SPDLT)/cn=Recipients/cn=**E-mailUser**" exceeded the maximum of 16 objects of type "session".

Event Xml:

```xml
<Event xmlns="http://schemas.microsoft.com/win/2004/08/events/event">
   <System>
      <Provider Name="MSExchangeIS" />
      <EventID Qualifiers="49158">9646</EventID>
      <Level>2</Level>
      <Task>6</Task>
      <Keywords>0x80000000000000</Keywords>
      <TimeCreated SystemTime="SystemTime" />
      <EventRecordID>126268</EventRecordID>
      <Channel>Application</Channel>
      <Computer>Servername.contoso.com</Computer>
      <Security />
   </System>
   <EventData>
      <Data>/o=First Organization/ou=Exchange Administrative Group (FYDIBOHF23SPDLT)/cn=Recipients/cn=E-mailUser</Data>
      <Data>16</Data>
      <Data>session</Data>
      <Binary>070000005B444941475F4354585D000016000000FFE83A00000000000002080000003A67F01FFE000000</Binary>
   </EventData>
</Event>
```

> [!NOTE]
> The following changes do not resolve this issue:
>
> - You change the **MaximumConnectionsPerUser** value in Exchange Server 2010 for **POPSettings** or for **IMAPSettings**.
> - You change the Throttling policy.
> - You add the View Information Store Status permission to the Exchange 2010 Store.

## Cause

This issue occurs because the Exchange 2010 Store limits the number of non-MAPI sessions that other services generate, such as IMAP, POP, OWA, Microsoft Exchange ActiveSync (EAS), or Exchange Web Services (EWS). By default, sessions per user are limited to 32, and service sessions per user are limited to 16.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To resolve this issue, first determine whether this situation is caused by a different issue. If not, then increase the limit that your organization requires for non-MAPI sessions. To do this, follow these steps:

1. On the server that is running the Exchange Server 2010 Mailbox role, select **Start**, select **Run**, type *regedit*, and then select **OK**.

2. Locate and then select the following key in the registry:  
   `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MSExchangeIS\ParametersSystem`

3. On the **Edit** menu, point to **New**, and then select **DWORD Value**.
4. Type *Maximum Allowed Service Sessions Per User*, and then press ENTER.

5. On the **Edit** menu, select **Modify**.

6. Type the decimal value that specifies the number of sessions that you want to use, and then select **OK**.

7. Exit Registry Editor.

> [!NOTE]
> The registry value **Maximum Allowed Service Sessions Per User** affects all Mailbox Databases on the server and is not applied on a per-user basis. If you increase this value, server performance may be adversely affected. For example, doubling the number of service sessions from 16 to 32 could slow server performance.

## References

For more information about how to set limits for sessions, see:

- [Set Connection Limits for IMAP4](/exchange/set-connection-limits-for-imap4-exchange-2013-help)
- [Set Connection Limits for POP3](/exchange/set-connection-limits-for-pop3-exchange-2013-help)
