---
title: Azure API Management troubleshooting scenario 4 - Performance issues in API calls
description: Learn how to troubleshoot Azure API Management performance issues in API calls, including backend latency and HTTP 500 and 429 errors.
ms.date: 08/13/2026
ms.service: azure-api-management
manager: dcscontentpm
ms.topic: troubleshooting
ms.author: kaushika
author: kaushika-msft
ms.reviewer: kaushika
ms.custom: sap:Availability or Unexpected API Responses
---
# Troubleshoot Azure API Management performance issues in API calls

## Summary 

This article explains how to troubleshoot Azure API Management performance issues in API calls, including backend latency and HTTP 500 and 429 errors. Use these steps to isolate faults and improve API response times. 

This article is the fourth scenario of the [Azure API Management troubleshooting series](apim-troubleshooting-series.md) lab. Ensure you follow the lab setup instructions as per the [API Management troubleshooting series lab instructions](https://github.com/prchanda/apimlab).

_Original product version:_ &nbsp; API Management Service  
_Original KB number:_ &nbsp; 4464929

## Symptoms

The API **ProductStore** in API Management communicates with the backend endpoint (`https://productstoreapp.azurewebsites.net`) to create, read, update, and delete records as needed. However, you might encounter performance issues and exceptions when you perform the following API operations.  

> [!NOTE]
> For the best testing results, keep only three products with IDs ranging from one to three.

- **Products_GetAllProducts** takes five seconds to return results, but the expected response time is less than a second.
- When you use the **Products_DeleteProduct** operation to delete a product with any of the previously mentioned IDs (one to three), you get an **HTTP 500 - Internal Server Error** with the following message:

    >  "Message": "An error has occurred."  

- An operation that updates a product gets throttled unexpectedly and results in an **HTTP 429 - Too many requests** error. This error happens regardless of product ID and request body. For example, if the customer updates the product price of "Tomato soup" with the product ID set to one by using the following example, they get an HTTP 429 status code.

    > Template parameter ID : 1  
   Request Body: {"Name": "Tomato soup","Category": "Groceries","Price": 2.45}  
   Response Body:  
    {  
    Rate limit is exceeded. Try again after some time.  
    }

## Troubleshooting 

While troubleshooting performance issues, the best way to isolate faults is by capturing an [API Management inspector trace](/azure/api-management/api-management-howto-api-inspector) that shows the time taken for each section (**Inbound**, **Backend**, and **Outbound**).

### Products_GetAllProducts latency

If you analyze the API Inspector trace for this issue, you see that the backend takes the most time (roughly five seconds). This result means there's some slowness or a long running operation on the backend. The following example shows the backend response time in the API Inspector trace:

> "source": "forward-request",  
> "timestamp": "2018-07-29T16:16:46.6615081Z",  
> "elapsed": "00:00:05.5844430",  
> "data": {  
> "response": {  
> "status": {  
> "code": 200,  
> "reason": "OK"
> }  

Once you isolate that the slowness happens on the backend, you need to investigate the backend application code of the web API application. For scenarios where you don't have access to the backend, you can implement caching at API Management level as shown in the following example. 

```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <policies>
       <inbound>
          <base />
          <cache-lookup vary-by-developer="true" vary-by-developer-groups="true" must-revalidate="true" downstream-caching-type="public" />
       </inbound>
       <backend>
          <base />
       </backend>
       <outbound>
          <base />
          <cache-store duration="60" />
       </outbound>
       <on-error>
          <base />
       </on-error>
    </policies>
```

For more information about caching, see [Add caching to improve performance in Azure API Management](/azure/api-management/api-management-howto-cache).

### Products_DeleteProduct HTTP 500 internal server error

For this issue, follow the same procedure of analyzing the API Management inspector trace. You likely see an HTTP 500 status code under the `forward-request` response attribute.

This status code means the backend API returns HTTP 500 due to an unhandled exception in the backend code. There's no issue at the API Management level as shown in the following example:

> forward-request (841.060 ms)  
> {  
> "response": {  
> "status": {  
> "code": 500,  
> "reason": "Internal Server Error"  
> }

### Products_PutProduct HTTP 429 too many requests error

For this issue, it appears like you're hitting an API call rate limit. Check if there's any `rate-limit` or `rate-limit-by-key` policy implemented at the operation level.

If you can't find any policies like that at the operation level, select **Calculate effective policy**. This action shows all the inherited policies from various levels, including policies at the product level that can cause this issue.

You might see some policies that are implemented at the API level which don't actually limit the API call rate. Instead, it mimics its actions by returning a customized response back to the client by using `return-response` and `set-status` policies for the **Outbound** section as shown in the following example:

```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <outbound>
       <!--base: Begin Api scope-->
       <return-response>
          <set-status code="429" reason="Too many requests" />
          <set-body><![CDATA[{

    Rate limit is exceeded. Try again after some time.

    }]]></set-body>
       </return-response>
       <!--base: End Api scope-->
    </outbound>
```

 
