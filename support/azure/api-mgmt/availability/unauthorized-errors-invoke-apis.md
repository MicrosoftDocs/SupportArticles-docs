---
title: Azure API Management troubleshooting scenario 3 - HTTP 401 errors encountered when using APIs
description: Learn how to troubleshoot HTTP 401 errors in Azure API Management by correcting invalid or missing subscription keys and API product associations.
ms.date: 08/14/2026
ms.service: azure-api-management
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: kaushika
ms.custom: sap:Availability or Unexpected API Responses
---
# Troubleshoot HTTP 401 errors encountered when using APIs

## Summary

This article explains how to troubleshoot **HTTP 401** errors encountered when using APIs in Azure API Management.

This article is the third scenario of the [Azure API Management troubleshooting series](apim-troubleshooting-series.md) lab. Ensure you follow the lab setup instructions as per the [API Management troubleshooting series lab instructions](https://github.com/prchanda/apimlab).

_Original product version:_ &nbsp; API Management Service  
_Original KB number:_ &nbsp; 4464930

## Symptoms

**Echo API** begins causing diverse types of **HTTP 401 - Unauthorized** errors when performing operations. **Create resource** and **Retrieve resource** operations display this error message:

> "statusCode": 401,  
> "message": "Access denied due to invalid subscription key. Make sure to provide a valid key for an active subscription."  

Other operations display this error message:

> "statusCode": 401,  
> "message": "Access denied due to missing subscription key. Make sure to include subscription key when making requests to an API."  

## Troubleshooting 

In the API product subscription process, you get a subscription key. You send it as part of the request header, and it works for any API in that product. The **Ocp-Apim-Subscription-Key** request header is for the subscription key of the product that's associated with this API. The key is filled in automatically.

For the **Access denied due to invalid subscription key. Make sure to provide a valid key for an active subscription** error, you send the wrong **Ocp-Apim-Subscription-Key** value in the request header when you perform the **Create resource** and **Retrieve resource** operations.

Sign in to the API Management Developer portal and check your subscription key for a particular product by going to the **Profile** page after sign-in as shown in the following example:

:::image type="content" source="media/unauthorized-errors-invoke-apis/subscription-keys.png" alt-text="Screenshot of the subscription keys for respective products." lightbox="media/unauthorized-errors-invoke-apis/subscription-keys.png":::

Select **Show** to see the subscription keys for respective products you subscribed to.

Check the headers you're sending from the **Test** tab. Notice the value of the **Ocp-Apim-Subscription-Key** request header is wrong. 

Now check the `Frontend` definition of the **Create resource** and **Retrieve resource** operations in the **Design** tab. Notice that these operations have a wrong hard-coded value of the **Ocp-Apim-Subscription-Key** request header added in the **Headers** tab.

When you remove it, it resolves the invalid subscription key problem but not the missing subscription key error.

You might encounter the following error message:

  > HTTP/1.1 401 Unauthorized
  >
  > Content-Length: 152  
  > Content-Type: application/json  
  > Date: Sun, 29 Jul 2018 14:29:50 GMT  
  > Vary: Origin
  > WWW-Authenticate: AzureApiManagementKey realm="`https://pratyay.azure-api.net/echo`",name="Ocp-Apim-Subscription-Key",type="header" {  
  >   "statusCode": 401,  
  >  "message": "Access denied due to missing subscription key. Make sure to  include subscription key when making requests to an API."
  
Go to the **Echo API** settings and check if it's associated with any of the available products. If not, then you must associate this API with a product so that you get a subscription key.

During the subscription process, if you created the API Management instance, you're an admin by default. This means you're subscribed to every product.

 
