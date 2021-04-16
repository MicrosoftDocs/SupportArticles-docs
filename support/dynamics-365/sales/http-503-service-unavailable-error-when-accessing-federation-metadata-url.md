---
title: HTTP 503 Service Unavailable error when accessing Federation Metadata URL
description: This article describes the error message received while accessing the Microsoft Dynamics CRM 2011 Internal Federation Metadata URL either on the Microsoft Dynamics CRM server or on the ADFS server after configuring the claims-based Authentication for the Microsoft Dynamics CRM 2011.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# "HTTP 503 Service Unavailable" error when accessing Microsoft Dynamics CRM Federation Metadata URL after configuring the claims-based Authentication

This article provides a resolution to solve the error **HTTP Error 503 - The service is unavailable** that occurs when accessing the Microsoft Dynamics CRM 2011 Internal Federation Metadata URL either on the Microsoft Dynamics CRM server or on the ADFS server.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2696987

## Symptoms

After configuring the claims for Microsoft Dynamics CRM in Deployment Manager, the internal Federation Metadata URL for Microsoft Dynamics CRM is generated. The Internal Federation Metadata URL will have the format below:

`https://<internalcrm>.<domain>.com/FederationMetadata/2007-06/FederationMetadata.xml`

When you try to access the Microsoft Dynamics CRM internal Federation Metadata URL, the following error message may be received:

> Service Unavailable
>
> HTTP Error 503. The service is unavailable.

The same behavior can be observed while the URL is accessed either on the Microsoft Dynamics CRM server or the ADFS server.

## Cause

The above error message occurs if there are stale records in the ACL related to Microsoft Dynamics CRM or other websites on the same port as Microsoft Dynamics CRM being used now.

## Resolution

The issue will be resolved by removing the stale records in the ACL. Follow the below steps to perform the same:

1. Run the following command to show the existing records:

    `NETSH HTTP SHOW URLACL`

    The above should show us all the reserved namespaces.

2. Look in the results to verify if you have an URL likes the example below:

    Reserved URL : `https://+:444/adfs/services/`  
    Can't lookup sid, Error: 1332  
    SDDL: D:(A;;GA;;;S-1-5-80-2246541699-21809830-3603976364-117610243- 975697593)

3. If the URL is present, run the following command to delete the URL:

   `netsh http delete urlacl url=https://+:443/FederationMetadata/2007-06/`

4. Perform an IISRESET.

After the above steps, you should be able to browse the Federation Metadata URL successfully.

## More information

For more information, see [Netsh Technical Reference](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc725935(v=ws.10)).
