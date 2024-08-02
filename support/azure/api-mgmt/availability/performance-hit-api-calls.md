---
title: Azure API Management Troubleshooting Scenario 4 - Performance hit in API calls
description: Provides troubleshooting guide to an error in which some performance issues and exceptions occur while invoking the API operations.
ms.date: 08/14/2020
ms.service: azure-api-management
ms.author: genli
author: genlin
ms.reviewer: 
ms.custom: sap:Availability or Unexpected API Responses
---
# Troubleshoot performance issues in API calls

Referring to the blog on [Azure API Management Troubleshooting Series](apim-troubleshooting-series.md), this is the fourth scenario of the lab. Make sure you have followed the lab setup instructions as per [this](https://github.com/prchanda/apimlab), to recreate the problem.

_Original product version:_ &nbsp; API Management Service  
_Original KB number:_ &nbsp; 4464929

## Symptoms

The API **ProductStore** in APIM communicates with the backend endpoint (`https://productstoreapp.azurewebsites.net`) to easily create, read, update, and delete records as and when required. However, you may face some performance issues and exceptions while invoking the API operations listed below. For ease in testing, keep only three products having IDs ranging from 1 to 3.

- One of the API functions **Products_GetAllProducts** is taking 5 seconds to return the results, whereas the expected response time is less than a second.
- While deleting a product having any of the above mentioned IDs (1 to 3), you are getting **HTTP 500 - Internal Server Error**  with the below message by calling **Products_DeleteProduct** operation.

    > {  
        "Message": "An error has occurred."  
    }

- **Products_PutProduct** operation that updates a product is getting throttled unexpectedly, throwing **HTTP 429 - Too many requests** with the below error message irrespective of product ID and request body, which you send in the request. For example, if the customer updates the product price of "Tomato Soup" having product ID = 1 with the below Json body he gets HTTP 429 status code.

    > Template parameter ID : 1  
   Request Body: {"Name": "Tomato soup","Category": "Groceries","Price": 2.45}  
   Response Body:  
    {  
    Rate limit is exceeded. Try again after some time.  
    }

## Troubleshooting steps

- While troubleshooting performance issues, the best way fault isolation technique is capturing [APIM inspector trace that shows time taken in each section (Inbound / Backend / Outbound).
- If you analyze the API Inspector trace for the first issue you would notice that Backend section is taking most of the time (approx. 5 seconds), which means there is some slowness or long running operation is taking place at the backend.

    > "source": "forward-request",  
    "timestamp": "2018-07-29T16:16:46.6615081Z",  
     **"elapsed": "00:00:05.5844430",**"data": {  
    "response": {  
    "status": {  
    "code": 200,  
    "reason": "OK"  
    }

- Once you have isolated that the slowness is at the backend, you need to investigate the backend application code of the Web API application. For scenarios where you don't have access to the backend, you can implement caching at APIM level like below. Read about how you can implement [caching policies](/azure/api-management/api-management-howto-cache)  to improve performance in Azure API Management.

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

- For the second issue (**HTTP 500 - Internal Server Error**), follow the same procedure of analyzing the APIM inspector trace and we should see HTTP 500 status code under 'forward-request' response attribute.
- This means backend API returned HTTP 500 due to some unhandled exception occurred at the backend code, there is no issue at APIM level.

    > forward-request (841.060 ms)  
    {  
    "response": {  
    "status": {  
    "code": 500,  
    "reason": "Internal Server Error"  
    }

- For the third issue (**HTTP 429 - Too many requests**) it looks like you are hitting API call rate limit. Probably you can check if there is any 'rate-limit' or 'rate-limit-by-key' policy implemented at operation level.
- If you cannot find any such policies at operation level, click on the **Calculate effective policy** button, which will show all the inherited policies from various levels, like you may have some policies at product level that can cause this issue.
- Here you should notice that some policies are implemented at API level which not really limiting the API call rate but mimics its action by returning a customized response back to the client using 'return-response' and 'set-status' policies at outbound section.

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

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
