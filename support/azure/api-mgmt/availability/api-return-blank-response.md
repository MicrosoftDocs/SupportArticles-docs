---
title: Azure API Management troubleshooting scenario 1 - API returns blank responses
description: Troubleshoot an Azure API that returns blank responses and learn how to restore the forward-request policy in Azure API Management to resolve the issue.
ms.date: 08/13/2026
ms.service: azure-api-management
manager: dcscontentpm
ms.topic: troubleshooting
ms.author: kaushika
author: kaushika-msft
ms.reviewer: kaushika
ms.custom: sap:Availability or Unexpected API Responses
---
# Troubleshoot API blank responses

## Summary 

This article explains how to troubleshoot an API that returns blank responses and restore request forwarding in Azure API Management.

This is the first scenario of the [Azure API Management troubleshooting series](apim-troubleshooting-series.md) lab. Make sure you follow the lab setup instructions as per the [API Management troubleshooting series lab instructions](https://github.com/prchanda/apimlab).

_Original product version:_ &nbsp; API Management Service  
_Original KB number:_ &nbsp; 4464936

## Symptoms

**Blank API** consists of two operations: **GetHeaders** and **GetMyIp**. **GetMyIp** returns the value of the `X-FORWARDED-FOR` header, and **GetHeaders** returns all the request header values. **GetMyIp** returns the expected output, but suddenly **GetHeaders** started returning a blank response (no response body).

:::image type="content" source="media/api-return-blank-response/blank-response.png" alt-text="Screenshot of the GetHeaders API operation returning a blank response body." lightbox="media/api-return-blank-response/blank-response.png":::

The expected output of the **GetHeaders** API should be similar to the following example:

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

## Troubleshooting

To troubleshoot this problem, the best approach is to collect an [API Management inspector trace](/azure/api-management/api-management-howto-api-inspector) to inspect request processing inside the API Management pipeline.

Notice that the `forward-request` policy is missing. The `forward-request` policy forwards the incoming request to the backend service specified in the request [context](/azure/api-management/api-management-policy-expressions#ContextVariables). Removing this policy results in the request not being forwarded to the backend service. The policies in the outbound section are evaluated immediately upon the successful completion of the policies in the inbound section.

Check the `<backend>` section of the **GetHeaders** operation under **Blank-API**. Notice that the `forward-request` policy is removed. 

Add the `forward-request` policy in the backend section or add the `<base />` element so that it inherits the `forward-request` policy from the parent level (API level). This change should resolve the problem.

For more information, see the [forward-request](/azure/api-management/api-management-advanced-policies#ForwardRequest) policy.