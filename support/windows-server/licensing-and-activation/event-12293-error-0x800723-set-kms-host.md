---
title: DNS Event Security Event 12293 with error 0x80072338 registering KMS host record
description: Provides a resolution to fix the event ID 12293 that occurs when setting up a KMS host.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:windows-volume-activation, csstroubleshoot
---
# Security Event 12293 with error 0x80072338 registering KMS host record

This article provides a resolution to fix the event ID 12293 that occurs when setting up a KMS host.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2553863

## Symptoms

When setting up a KMS host, you may receive the following Event ID in the application event log on the KMS host.

> Source:  Security-SPP  
Event ID:  12293  
Publishing the Key Managment Service (KMS) to DNS in the `contoso.com` domain failed.  
Info:  0x80072338  
>
> 0x80072338: DNS_ERROR RCODE_BADSIG  
DNS signature failed to verify.  

## Cause

This error can occur if the KMS host doesn't have permissions to edit the existing _VLMCS SRV record in DNS.  

## Resolution

Use the following steps to change the permissions to allow the new KMS host to update the record.  

1. In DNS goto Forward Lookup Zones\Contoso.com\\_tcp.  
2. Locate the _VLMCS record
3. Right click, choose properties
4. On security tab, add the new KMS host computer name with Full Control
5. Restart sppssvc or slsvc service on KMS host

> [!Note]
> These are instructions specific to Microsoft DNS server. If you're using a third party DNS server, consult your documentation for how to change permissions.  

## More information

SRV records in DNS use the record name as the ID for all records of that type. The first KMS host to create a record named VLMCS.TCP becomes the Creator/Owner of SRV records with that name. Other KMS can't publish SRV records in that zone with that name until given permission to do so.

The _VLMCS SRV record can be thought as an array with single name. In a default DDNS configuration, any machine can create a unique SRV record. Once a \_VLMCS record exists, no other computer has the rights to change that record. The second and later KMS hosts create the SRV records with the same name. The SRV record design allows a DNS admin to explicitly and control which machines are allowed to advertise services in the DNS zone.

When publishing to DNS is successful, the KMS host will log an Event ID 12294 in the application event log.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
