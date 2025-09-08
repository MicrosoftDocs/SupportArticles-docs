---
title: 554 5.4.14 Hop count exceeded - possible mail loop NDR for outgoing email
description: Provides a fix for the 554 5.4.14 Hop count exceeded - possible mail loop issue in Exchange Server.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
ms.custom: 
  - sap:Mail Flow\Need Help with Configuring Mailflow, Mail routing (Connectors, Domains)
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2016
  - Exchange Server 2013
ms.date: 01/24/2024
ms.reviewer: v-six
---

# "554 5.4.14 Hop count exceeded - possible mail loop" NDR for outgoing email that's sent to an on-premises application in Exchange Server

## Symptoms

Consider the following scenario: 
 
- You have a parent domain, **contoso.com**, that you have added as an accepted domain to an on-premises Microsoft Exchange Server 2016 or 2013 environment.    
- You have an on-premises application server domain, such as **app.contoso.com**, that is a subdomain of the parent domain.    
- The parent domain is configured to accept email messages from domains such as ***.contoso.com**.   
- You try to send an email message to the on-premises application through Exchange Server.   

In this scenario, the message cannot be sent. Instead, it loops between the Exchange Edge Transport server and Exchange Online Protection (EOP). Additionally, you receive a non-delivery report (NDR) that resembles the following: 
 
**554 5.4.14 Hop count exceeded - possible mail loop** 

## Cause

This issue occurs because the Exchange Edge server cannot associate the SMTP address space for the application as a subdomain to the accepted domain. This is true even though the accepted domain is configured as a parent domain.
 
In this scenario, the subdomain would be part of the address space in the **EdgeSync - Inbound to SiteName** send connector. 

## Resolution

To fix this issue, follow these steps: 
 
1. Add the subdomain as an accepted domain. To do this, run the following command:

    ```powershell
    New-AcceptedDomain -DomainName app.Contoso.com -DomainType InternalRelay -Name app.contoso.com
    ```

2. To have the added accepted domain synced to the Edge servers immediately, run the following command: 

    ```powershell
    Start-EdgeSynchronization
    ```
    
    Alternatively, wait for the changes to be synced to the Edge servers.     
