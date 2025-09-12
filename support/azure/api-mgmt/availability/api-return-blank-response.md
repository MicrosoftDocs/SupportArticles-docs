---
title: Azure API Management Troubleshooting Scenario 1 - API returning blank response
description: Provides troubleshooting steps to an issue in which Azure API is returning blank response.
ms.date: 03/04/2021
ms.service: azure-api-management
ms.author: jarrettr
author: JarrettRenshaw
ms.reviewer: 
ms.custom: sap:Availability or Unexpected API Responses
---
# Azure API is returning blank response

Referring to the article on [Azure API Management Troubleshooting Series](apim-troubleshooting-series.md), this is the first scenario of the lab. Make sure you have followed the lab setup instructions as per [this](https://github.com/prchanda/apimlab), to recreate the problem.

_Original product version:_ &nbsp; API Management Service  
_Original KB number:_ &nbsp; 4464936

## Symptoms

The API **Blank API** consists of two operations **GetHeaders** and **GetMyIp**. **GetMyIp** returns the value of X-FORWARDED-FOR header value and **GetHeaders** returns all the request header values. **GetMyIp** returns expected output but suddenly **GetHeaders** started returning a blank response (no response body).

:::image type="content" source="media/api-return-blank-response/blank-response.png" alt-text="Screenshot of a blank response.":::

Expected output of **GetHeaders**  API should be something like below:

```html
{
  "headers": {
    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", 
    "Accept-Encoding": "gzip, deflate", 
    "Accept-Language": "en-US,en;q=0.5", 
    "Connection": "close", 
    "Cookie": "_gauges_unique_day=1; _gauges_unique_month=1; _gauges_unique_year=1; _gauges_unique=1", 
    "Host": "eu.httpbin.org", 
    "Upgrade-Insecure-Requests": "1", 
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:59.0) Gecko/20100101 Firefox/59.0"
  }
}
```

## Troubleshooting Steps

To debug this kind of issues, the best approach is collect [APIM inspector trace](/azure/api-management/api-management-howto-api-inspector) to inspect request processing inside APIM pipeline.

- If you look into the trace, you would notice that forward-request policy is missing.
- The forward-request policy forwards the incoming request to the backend service specified in the request [context](/azure/api-management/api-management-policy-expressions#ContextVariables).
- Removing this policy results in the request not being forwarded to the backend service and the policies in the outbound section are evaluated immediately upon the successful completion of the policies in the inbound section.
- Hence if you check the \<backend> section of the **GetHeaders** operation under **Blank-API** you would notice that forward-request policy is removed.
- Add the forward-request policy in the backend section or add **\<base />** element so that it inherits forward-request policy from the parent level (i.e. from the API level), which should resolve the problem.

Read about the [forward-request](/azure/api-management/api-management-advanced-policies#ForwardRequest) policy to know more about it.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
