---

title: Error AADSTS500011 - Resource Principal Not Found
description: Describes a problem in which a user experiences an AADSTS500011 error when trying to sign in to Microsoft Entra ID.
author: custorod
ms.author: custorod
ms.service: entra-id
ms.topic: troubleshooting-problem-resolution
ms.date: 01/16/2025
ms.subservice: authentication
ms.custom: sap:Issues Signing In to Applications
---

# AADSTS500011 - Resource Principal Not Found

This article describes a problem in which users experiences an "AADSTS500011" error when they try to sign in to Microsoft Entra ID.

## Symptoms

When users try to sign in to an application that uses Microsoft Entra ID authentication, they receive the following error message:

> `AADSTS500011 - The resource principal named [resource URL] was not found in the tenant named [tenant ID]`

## Cause

This issue occurs if the resource principal (the application or service) is not found in the tenant. This issue occurs if:

- The resource application isn't provisioned by the administrator in the tenant.
- The resource application isn't consented to by any user in the tenant.
- The resource URL is not configured correctly.
- The tenant ID is not correct.

## Resolution

To resolve this issue, follow these steps:

1. **Verify resource application provisioning**: 

   - Make sure that the application (resource principal) is registered correctly in your Microsoft Entra ID tenant.
   - Go to the [Azure portal](https://portal.azure.com), and navigate to Microsoft Entra ID > Enterprise applications.
   - Check whether the application is listed and correctly configured.
      
1. **Consent to application**:
   - Make sure that the resource application has been consented to by an administrator or a user in the tenant.
   - Go to the [Azure portal](https://portal.azure.com), and navigate to Microsoft Entra > Enterprise applications.
   - Find the application, and make sure that it has the necessary permissions and consent.

1. **Check resource URL**:
   - Verify that the resource URL that appears in the error message matches the resource application that you provisioned in your tenant ID.
   - Make sure that the authentication request is sent by using the correct resource URL.
      
1. **Check tenant ID**:
   - Verify that the tenant ID that appears in the error message is the same as your tenant ID.
   - Make sure that the authentication request is sent to the correct Microsoft Entra ID tenant.
      
## More information

For a full list of authentication and authorization error codes, see [Microsoft Entra authentication and authorization error codes](/azure/active-directory/develop/reference-error-codes).

To investigate individual errors, go to [https://login.microsoftonline.com/error](https://login.microsoftonline.com/error).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)] 
