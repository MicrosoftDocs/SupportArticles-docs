---
title: The identity of the calling application could not be established
description: Provides solutions to the error "The identity of the calling application could not be established" when using Microsoft Graph.
ms.date: 03/28/2025
ms.service: entra-id
ms.custom: sap:Getting access denied errors (Authorization)
ms.reviewer: willfid, v-weizhu
---
# Error "The identity of the calling application could not be established"

This article provides solutions to the error message "The identity of the calling application could not be established" when using Microsoft Graph.

## Symptoms

When using Microsoft Graph or some services that rely on it, you encounter the following error message:

> The identity of the calling application could not be established

## Cause

This error occurs because the `oid` and `sub` claims are missing from the access token. The root cause is that the service principal doesn't exist in the tenant or the tenant isn't aware of the application.

## Solution for Partner scenario

If the application is a Partner application, ensure that you complete the Partner pre-consent process. For more information, see [Partner pre-consent](https://github.com/microsoft/Partner-Center-Explorer/blob/master/docs/Preconsent.md) and add your application or service principal to the AdminAgents group.

Here's an updated PowerShell script for using Microsoft Graph:

```powershell
Connect-MgGraph

$AppId = '<Application ID>'

$g = Get-MgGroup -All -Filter "displayName eq 'AdminAgents'"

$s = Get-MgServicePrincipal -All -Filter "appId eq '$AppId'"

$params = @{
        "@odata.id" = "https://graph.microsoft.com/v1.0/directoryObjects/$($s.id)"
}

New-MgGroupMemberByRef -GroupId $g.id -BodyParameter $params
```

Ensure that you replace `<Application ID>` with your application's actual Application ID.

## Solution for Non-Partner scenario

If the application isn't a Partner application, add the service principal to the tenant and consent to the permissions required by the application.

You can [build an admin consent URL](/entra/identity/enterprise-apps/grant-admin-consent?pivots=portal#construct-the-url-for-granting-tenant-wide-admin-consent) like the following one:

`https://login.microsoftonline.com/{organization}/adminconsent?client_id={client-id}`

Then, sign in with a Global Administrator account of the tenant where you are trying to access resources.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]