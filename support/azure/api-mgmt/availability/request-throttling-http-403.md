---
title: Azure API Management troubleshooting scenario 5 - HTTP 403 and HTTP 429 errors due to request throttling
description: Troubleshoot Azure API Management HTTP 403 and HTTP 429 errors caused by request throttling. Follow these steps to identify and resolve restrictive policies.
ms.date: 08/13/2026
ms.service: azure-api-management
ms.topic: troubleshooting
manager: dcscontentpm
ms.author: kaushika
author: kaushika-msft
ms.reviewer: kaushika
ms.custom: sap:Availability or Unexpected API Responses
---
# Troubleshoot HTTP 403 and HTTP 429 errors due to request throttling

## Summary

This article explains how to troubleshoot HTTP 403 and HTTP 429 errors caused by Azure API Management request throttling policies, so you can identify restrictive policies and restore expected API behavior. 

This article is the fifth scenario of the [Azure API Management troubleshooting series](apim-troubleshooting-series.md) lab. Ensure you follow the lab setup instructions as per the [API Management troubleshooting series lab instructions](https://github.com/prchanda/apimlab).

_Original product version:_ &nbsp; API Management Service  
_Original KB number:_ &nbsp; 4464928

## Symptoms

The **Resources** API fetches a user's personal details, social media posts, comments, and photos and uses the response for a machine learning project. The **GetPosts** operation starts to return **HTTP 403 - Forbidden** errors while the other operations work as expected. 

The following example shows the error message returned by the **GetPosts** operation:

> "statusCode": 403,  
> "message": "Forbidden"  

You might also encounter **HTTP 429 - Too many requests** errors while performing the **GetComments** operation for every second request. The issue resolves automatically after 10 seconds. However, it recurs once the first call to the API is made again. This behavior doesn't happen for the other operations. 

The following example shows the error message returned by the **GetComments** operation:

> "statusCode": 429,  
> "message": "Rate limit is exceeded. Try again in 5 seconds."

## Troubleshooting 

### HTTP 403 - Forbidden error 

This error occurs when an access restriction policy is implemented. Check the [API Management inspector trace](/azure/api-management/api-management-howto-api-inspector). You should notice the existence of an `ip-filter` policy that filters (allows or denies) calls from specific IP addresses and address ranges as shown in the following example:

```xml
    <inbound>
        <base />
        <choose>
            <when condition="@(context.Operation.Name.Equals("GetPosts"))">
                <ip-filter action="forbid">
                    <address-range from="0.0.0.0" to="255.255.255.255" />
                </ip-filter>
            </when>
        </choose>
    </inbound>
```

To check the scope of the `ip-filter` policy, select **Calculate effective policy**. If you don't see any access restriction policy implemented at any scopes, check the product level. Go to the associated product and then select **Policies**.

### HTTP 429 - Too many requests error

Use the same procedure as previously mentioned by checking the API Management inspector trace to see if there's any `rate-limit` or `rate-limit-by-key` policy implemented at any scope.

You should notice an access restriction policy (`rate-limit-by-key`) implemented at Global scope, like in `Inbound processing` in the `All APIs` option as shown in the following example:

```xml
    <inbound>
        <choose>
            <when condition="@(context.Operation.Name.Equals("GetComments"))">
                <rate-limit-by-key calls="1" renewal-period="10" increment-condition="@(context.Response.StatusCode == 200)" counter-key="@(context.Request.IpAddress)" />
            </when>
        </choose>
    </inbound>
```

For more information, see [API Management policy reference](/azure/api-management/api-management-policies#access-restriction-policies).

 
