---
title: Azure API Management Troubleshooting Scenario 5 - Request throttling problems and HTTP 403 - Forbidden issues
description: Provides troubleshooting steps to an issue in which GetPosts operation throws HTTP 403 - Forbidden error.
ms.date: 08/14/2020
ms.service: api-management
ms.author: genli
author: genlin
ms.reviewer: 
---
# Request throttling problems and HTTP 403 - Forbidden issues

Referring to the article on [Azure API Management Troubleshooting Series](apim-troubleshooting-series.md), this is the fifth scenario of the lab. Make sure you have followed the lab setup instructions as per [this](https://github.com/prchanda/apimlab), to recreate the problem.

_Original product version:_ &nbsp; API Management Service  
_Original KB number:_ &nbsp; 4464928

## Symptoms

The **Resources** API fetches user's personal details, social media posts, comments, and photos and utilizes the response returned for a machine learning project. Strangely after few days of using it, **GetPosts** operation started throwing **HTTP 403 - Forbidden** error whereas the other operations are working fine as expected.

> {  
   "statusCode": 403,  
   "message": "Forbidden"  
}

Apart from the above, we are also encountering **HTTP 429 - Too many requests** error while invoking **GetComments** operation for every second request. The issue automatically gets resolve after 10 secs, however it reoccurs once the first call to API is made again. The behavior is not observed for the other operations.

> {  
   "statusCode": 429,  
   "message": "Rate limit is exceeded. Try again in 5 seconds."  
}

## Troubleshooting steps

- **HTTP 403 - Forbidden** error can be thrown when there is any access restriction policy implemented.
- Check the [APIM inspector trace](/azure/api-management/api-management-howto-api-inspector) and you should notice the existence of a 'ip-filter' policy that filters (allows/denies) calls from specific IP addresses and/or address ranges.
- To check the scope of the 'ip-filter' policy, select the **Calculate effective policy** button. If you don't see any access restriction policy implemented at any scopes, next validation step should be done at product level, by navigating to the associated product and then click on Policies option.

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

- For the second issue (**HTTP 429 - Too many requests**) we will follow the same procedure by checking the APIM inspector trace and check if there is any 'rate-limit' or 'rate-limit-by-key' policy implemented at any scope.
- If you calculate the effective policy, you should notice an access restriction policy (rate-limit-by-key) implemented at Global scope, i.e under 'Inbound processing' in 'All APIs' option.

    ```xml
    <inbound>
        <choose>
            <when condition="@(context.Operation.Name.Equals("GetComments"))">
                <rate-limit-by-key calls="1" renewal-period="10" increment-condition="@(context.Response.StatusCode == 200)" counter-key="@(context.Request.IpAddress)" />
            </when>
        </choose>
    </inbound>
    ```

Read more about [ip-filter](/azure/api-management/api-management-access-restriction-policies#RestrictCallerIPs)  and [rate-limit-by-key](/azure/api-management/api-management-access-restriction-policies#LimitCallRateByKey) policies in APIM.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
