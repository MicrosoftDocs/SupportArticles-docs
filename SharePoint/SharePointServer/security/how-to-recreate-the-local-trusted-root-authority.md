---
title: How to re-create the local Trusted Root Authority
description: Describes that how to re-create the local Trusted Root Authority.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Administration\Farm Administration
  - CSSTroubleshoot
appliesto: 
  - SharePoint Foundation 2013
  - SharePoint Server 2013
  - SharePoint Foundation 2010
  - SharePoint Server 2010
ms.date: 12/17/2023
---

# How to re-create the local Trusted Root Authority  

## Symptoms  

In Microsoft SharePoint Foundation/Server 2010 or Microsoft SharePoint Foundation/Server 2013, you see the following error getting logged in the Application Event Log:  

```
Log Name: Application  
Source: Microsoft-SharePoint Products-SharePoint Foundation  
Event ID: 8311  
Task Category: Topology  
Level: Error   
Description: An operation failed because the following certificate has validation errors:  
\n\nSubject Name: CN=SharePoint Security Token Service, OU=SharePoint, O=Microsoft, C=US\nIssuer   
Name: CN=SharePoint Root Authority, OU=SharePoint, O=Microsoft, C=US\nThumbprint:   
7884622F8B800E7AFAAFD3DDF98BE8AC96D4F952\n\nErrors:\n\n The root of the certificate chain   
is not a trusted root authority.   
```

Additionally, other areas such as search, claims authentication also do not function correctly.  

## Cause  

This problem occurs when an administrator deletes the **local** trust relationship of the farm from the **Security** section of the Central Administration website   

**Note** Specifically, the local trust is located in Central Administration > Security > Manage Trust.  

## Resolution  

In order to resolve this problem, the local trust relationship has to be created. This can be done by running the following PowerShell commands:

```
$rootCert = (Get-SPCertificateAuthority).RootCertificate   
New-SPTrustedRootAuthority -Name  "localNew" -Certificate  $rootCert   
```

After running the above commands, perform an IISReset on all servers in the farm.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
