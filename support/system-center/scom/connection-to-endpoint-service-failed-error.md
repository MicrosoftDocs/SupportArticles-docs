---
title: Connection to EndPoint Service failed
description: Fixes an issue that triggers a Connection to EndPoint Service failed error in System Center 2012 Operations Manager. This issue occurs when you try to import the Office 365 management pack for Operations Manager.
ms.date: 07/06/2020
---
# Connection to EndPoint Service failed error after importing the Office 365 management pack for Operations Manager

This article helps you fix an issue in which you receive the **Connection to EndPoint Service failed** error when you import the Office 365 management pack for Operations Manager.

_Original product version:_ &nbsp; System Center 2012 R2 Operations Manager, Microsoft System Center 2012 Operations Manager, Microsoft Entra ID  
_Original KB number:_ &nbsp; 3026285

## Symptom

After you import the Office 365 management pack for Operations Manager, you receive the following error message:

> Connection to EndPoint Service failed

## Cause

This issue may occur if the management server cannot access the Office 365 API endpoint. For example, traffic could be blocked by a firewall or by another security device on the network.

## Resolution

To resolve this issue, make sure that there are no network restrictions that are prohibiting a connection between the Management server and the Office 365 portal endpoint. Most connections use TCP 443, or else they first connect over TCP 80 and are redirected.

Also make sure that the credentials for the Office 365 subscription's account are correct and that you have granted access to the Office 365 API endpoint. You can test your access to `https://office365servicehealthcommunications.cloudapp.net/` from the management server. When you do this, you may encounter an **Access Denied** error, but this indicates that there are no restrictions to the Office 365 API endpoint. For example, you may receive an error message that resembles the following:

> 403 - Forbidden: Access is denied. You do not have permission to view this directory or page using the credentials that you supplied

## More information

One of the following alert messages may be returned after you import the Office 365 management pack for Operations Manager:

- Authorization failed (wrong credentials for configured subscription)
- Connection to EndPoint Service failed (network problems or unavailable Office 365 API)
- Account doesn't have administrator permissions (the specified cloud user account doesn't have Global Administrator permissions for the subscription)

For more information, see [Office 365 URLs and IP address ranges](/office365/enterprise/urls-and-ip-address-ranges).
