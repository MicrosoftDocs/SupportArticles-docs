---
title: Errors using Azure Active Directory Graph API custom applications
description: Describes an issue in which you receive error messages when you try to use Azure Active Directory Graph API custom applications in Microsoft 365. Provides a resolution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Azure Active Directory
ms.date: 03/31/2022
---

# Error messages when using Azure Active Directory Graph API custom applications in Microsoft 365

## Symptoms

When you try to use Microsoft Azure Active Directory Graph API custom applications in Microsoft 365, you may receive one of the following messages:

- **Cannot find custom tool 'DataServicesCoreClientGenerator' on this system**
- **Could not resolve this reference. Could not locate the assembly Microsoft.Data.Odata**
- **Could not resolve this reference. Could not locate the assembly Microsoft.Data.Services.Client**
- **Could not resolve this reference. Could not locate the assembly System Spatial**
- **There was a mismatch between the processor architecture of the project being built "MSIL" and the processor architecture of the reference "Microsoft.WindowsAzure.ActiveDirectory.Authentication"**
- **The type or namespace name 'Services' does not exist in the namespace 'System.Data'**
- **The type or namespace name 'DataServiceQueryContinuation' could not be found**
- **The referenced component 'Microsoft.Data.OData' could not be found**
- **The referenced component 'Microsoft.Data.Services.Client' could not be found**

## Cause

This issue occurs if WCF Data Services 5.0 for OData V3 is not installed.

## Resolution

To resolve this issue, download and install WCF Data Services 5.0 for OData V3 from the Microsoft Download Center:

[WCF Data Services 5.0 for OData V3](https://www.microsoft.com/download/details.aspx?id=29306)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).