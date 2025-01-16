---
# Required metadata
# For more information, see https://review.learn.microsoft.com/en-us/help/platform/learn-editor-add-metadata?branch=main
# For valid values of ms.service, ms.prod, and ms.topic, see https://review.learn.microsoft.com/en-us/help/platform/metadata-taxonomies?branch=main

title:       # Add a title for the browser tab
description: # Add a meaningful description for search results
author:      custorod # GitHub alias
ms.author:    # Microsoft alias
ms.service:  # Add the ms.service or ms.prod value
# ms.prod:   # To use ms.prod, uncomment it and delete ms.service
ms.topic:    # Add the ms.topic value
ms.date:     01/16/2025
---

# AADSTS500011 - Resource Principal Not Found

This article describes a problem in which a user receives the error message "AADSTS500011 - The resource principal named [resource URL] was not found in the tenant named [tenant ID]."

## Symptoms

The user receives the error `AADSTS500011` when trying to sign in to an application that has been integrated with Microsoft Entra ID.

## Cause

This error occurs when the resource principal (the application or service) is not found in the tenant. This can happen if:
1. The resource application has not been provisioned by the administrator in the tenant.

1. The resource application has not been consented to by any user in the tenant.

1. The [resource URL] is not correct.

1. The [tenant ID] is not correct.

## Resolution

To resolve this issue, follow these steps:

1. **Verify Resource Application Provisioning**: 

   - Ensure that the application (resource principal) is registered correctly in your Microsoft Entra ID tenant.
      
   - Go to the Azure Portal and navigate to Microsoft Entra > Enterprise Application.
      
   - Check if the application is listed and properly configured.
      
1. **Consent to the Application**:
   - Ensure that the resource application has been consented to by an administrator or a user in the tenant.
      
   - Go to the Azure Portal and navigate to Microsoft Entra > Enterprise applications.
   - Find the application and ensure that it has the necessary permissions and consent.

1. **Check [resource URL]**:
   - Verify if the error message’s [Resource URL] matches the resource application you've provisioned in your tenant ID.
      
   - Ensure that the authentication request is sent using the correct [resource URL].
      
1. **Check [tenant ID]**:
   - Verify if the error message’s [tenant ID] is the same as your tenant ID.
      
   - Ensure that the authentication request is sent to the correct Microsoft Entra ID tenant.
      
## More information

For a full list of authentication and authorization error codes, see [Microsoft Entra authentication and authorization error codes](/azure/active-directory/develop/reference-error-codes).

To investigate individual errors, go to [https://login.microsoftonline.com/error](https://login.microsoftonline.com/error).
