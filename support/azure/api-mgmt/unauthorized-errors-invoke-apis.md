---
title: Azure API Management Troubleshooting Scenario 3 - Receiving unauthorized errors (401) while invoking APIs
description: Provides troubleshooting steps to an issue in which you are getting unauthorized errors (401) while invoking APIs.
ms.date: 08/14/2020
author: genlin
ms.author: genli
ms.service: api-management
ms.reviewer: 
---
# Unauthorized errors (401) while invoking APIs

Referring to the article on [Azure API Management Troubleshooting Series](apim-troubleshooting-series.md), this is the third scenario of the lab. Make sure you have followed the lab setup instructions as per [this](https://github.com/prchanda/apimlab), to recreate the problem.

_Original product version:_ &nbsp; API Management Service  
_Original KB number:_ &nbsp; 4464930

[!INCLUDE [Feedback](../../includes/feedback.md)]

## Symptoms

The **Echo API** suddenly started throwing diverse types of **HTTP 401 - Unauthorized** errors while invoking the operations under it. **Create resource** and **Retrieve resource** operations are showing this error message:

> {  
  "statusCode": 401,  
  "message": "Access denied due to invalid subscription key. Make sure to provide a valid key for an active subscription."  
}

Whereas rest of the operations are showing

> {  
  "statusCode": 401,  
  "message": "Access denied due to missing subscription key. Make sure to include subscription key when making requests to an API."  
}

The expected HTTP response code for all the operations is 200, however the response body will vary as the backend API always echoes whatever you send as a request body in addition to headers.

## Troubleshooting steps

- To get access to the API, developers must first subscribe to a product. When they subscribe, they get a subscription key that is sent as a part of request header that is good for any API in that product. **Ocp-Apim-Subscription-Key** is the request header sent for the subscription key of the product that is associated with this API. The key is filled in automatically.
- Regarding error **Access denied due to invalid subscription key. Make sure to provide a valid key for an active subscription**, it's clear that you are sending a wrong value of **Ocp-Apim-Subscription-Key** request header while invoking **Create resource** and **Retrieve resource** operations.
- You can check your subscription key for a particular product from APIM Developer portal by navigating to **Profile** page after sign-in as shown below.
- Select the **Show** button to see the subscription keys for respective products you have subscribed to.

    :::image type="content" source="media/unauthorized-errors-invoke-apis/subscription-keys.png" alt-text="Screenshot of the subscription keys for respective products." lightbox="media/unauthorized-errors-invoke-apis/subscription-keys.png":::
- If you check the headers being sent from **Test** tab, you notice that the value of **Ocp-Apim-Subscription-Key** request header is wrong. You might be wondering how come that is possible, because APIM automatically fills this request header with the right subscription key.
- Let's check the Frontend definition of **Create resource** and **Retrieve resource** operations under **Design** tab. Upon careful inspection, you would notice that these operations got a wrong hard-coded value of **Ocp-Apim-Subscription-Key** request header added under **Headers** tab.
- You can remove it, this should resolve the invalid subscription key problem, but still you would get missing subscription key error.

    You may get the following error message:

    > HTTP/1.1 401 Unauthorized
    >
    > Content-Length: 152  
    > Content-Type: application/json  
    > Date: Sun, 29 Jul 2018 14:29:50 GMT  
    > Vary: Origin
    > WWW-Authenticate: AzureApiManagementKey realm="`https://pratyay.azure-api.net/echo`",name="Ocp-Apim-Subscription-Key",type="header" {  
    >   "statusCode": 401,  
    >  "message": "Access denied due to missing subscription key. Make sure to  include subscription key when making requests to an API."
    }

- Go to the Echo APIsettings and check if it is associated with any of the available products. If not, then you must associate this API with a product so that you get a subscription key.

    Developers must first subscribe to a product to get access to the API. When they subscribe, they get a subscription key that is good for any API in that product. If you created the APIM instance, you are an administrator already, so you are subscribed to every product by default.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
