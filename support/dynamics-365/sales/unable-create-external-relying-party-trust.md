---
title: Unable to create the External Relying Party Trust
description: This article provides a resolution for the problem that occurs when you configure the CRM External IFD Relying Party in AD FS.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Unable to successfully create the External Relying Party Trust for Microsoft Dynamics CRM 2011

This article helps you resolve the problem that occurs when you configure the CRM External IFD Relying Party in AD FS.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2546710

## Symptoms

When Configuring the CRM External IFD Relying Party in AD FS, the following error is displayed:

> An error occurred during an attempt to access the AD FS configuration database: Error message MSIS7612: Each identifier for a relying party trust must be unique across all relying party trusts in AD FS 2.0

## Cause

Two Relying Parties are needed to achieve Internal and External Claims access into CRM. Internal being access to CRM with no login screens shown (AD FS consumes a Kerberos ticket from the client) and External access being AD FS displays a login page.

If the Internal CRM Relying Party already was created and you attempt to configure the External CRM endpoint, this error will occur if the Internal CRM relying party displayed the External CRM  FederationMetadata.xml file. Microsoft Dynamics CRM 2011 will display the same FederationMetaData.xml file for both internal and external access when CRM is running on port 443 and 443 is defined in the Deployment Properties.

## Resolution

If CRM is running on the default SSL port 443, there is no need to define the port number in the Deployment Manager.

To change this, follow these steps:

1. Open the **CRM Deployment Manager**, click on **Microsoft Dynamics CRM**, and click **Properties**.
2. In the **Microsoft Dynamics CRM Properties**, click the **Web Address** tab.
3. If your URL is defined as `InternalCRM.contoso.com:443`, you must remove the port definition so it reads `InternalCRM.contoso.com`.
4. If Microsoft Dynamics CRM is using any other port, it must be defined in the **Web Address** tab. It is only port 443 that should be included.
5. After the change, run an IISReset on the CRM Server.
6. Then go to the AD FS server, right-click on the Relying party specified for your internal access endpoint, and then choose **Update** from **Federation Metadata**.
7. After this change, create the second relying party.
