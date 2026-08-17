---
title: Azure API Management troubleshooting scenario 2 - SOAP-based API returns HTTP 404 and HTTP 500 errors
description: Learn how to troubleshoot SOAP-based API HTTP 404 and 500 errors in Azure API Management by tracing requests and correcting headers and input values.
ms.date: 08/14/2026
ms.service: azure-api-management
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: kaushika
ms.custom: sap:Availability or Unexpected API Responses
---
# Troubleshoot SOAP-based API HTTP 404 and HTTP 500 errors

## Summary

This article explains how to troubleshoot a SOAP-based API that returns **HTTP 404** and **HTTP 500** errors in Azure API Management.

This article is the second scenario of the [Azure API Management troubleshooting series](apim-troubleshooting-series.md) lab. Ensure you follow the lab setup instructions as per the [API Management troubleshooting series lab instructions](https://github.com/prchanda/apimlab).

_Original product version:_ &nbsp; API Management Service  
_Original KB number:_ &nbsp; 4464934

## Symptoms

The Calculator API found at [http://www.dneonline.com/calculator.asmx](http://www.dneonline.com/calculator.asmx) performs four operations: **Add**, **Subtract**, **Multiply**, and **Divide**, based on two input parameters: `intA` and `intB`. This API uses an ASMX file-based service that uses Simple Object Access Protocol (SOAP) 1.1 protocol so the input parameters are passed in the SOAP envelope body.

In this scenario, the **Add** and **Subtract** operations work as expected, but you encounter **HTTP 404** errors while performing a **Multiply** operation and **HTTP 500** errors when performing a **Divide** operation.

The expected output of a **Multiply** operation should be something like the following example:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
   <soap:Body>
      <MultiplyResponse xmlns="http://tempuri.org/">
         <MultiplyResult>int</MultiplyResult>
      </MultiplyResponse>
   </soap:Body>
</soap:Envelope>
```

The expected output of a **Divide** operation should be something like the following example:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
   <soap:Body>
      <DivideResponse xmlns="http://tempuri.org/">
         <DivideResult>int</DivideResult>
      </DivideResponse>
   </soap:Body>
</soap:Envelope>
```

## Troubleshooting

To determine what causes the **HTTP 404** and **HTTP 500** responses (whether it's API Management or the backend SOAP API), collect an [API Management inspector trace](/azure/api-management/api-management-howto-api-inspector) to inspect the request and response.

If multiple operations cause **HTTP 404** or **HTTP 500** errors, it indicates that the origin server can't find a current representation for the target resource or isn't able to disclose that one exists.

When you examine the backend section of an API Management inspector trace, the same observation is evident from the message as shown in the following example:

```
    {
      "backend": [
        {
          "source": "configuration",
          "timestamp": "2018-07-29T12:30:08.3500317Z",
          "elapsed": "00:00:00.7276962",
          "data": {
            "message": "Unable to identify Api or Operation for this request. Responding to the caller with 404 Resource Not Found."
          }
        }
      ]
    }
```

You need to first examine the request URL and headers sent from API Management to the backend API from **Test** and compare them with a sample of SOAP request for the **Multiply** operation you performed at [http://www.dneonline.com/calculator.asmx](http://www.dneonline.com/calculator.asmx).

Request headers from an API Management inspector trace look something like the following example:

```
    {
      "data": {
        "request": {
          "method": "POST",
          "url": "https://pratyay.azure-api.net/calc",
          "headers": [
            {
              "name": "Ocp-Apim-Subscription-Key",
              "value": "34ae22db7f2c4c5da7b74a55adf03223"
            },
            {
              "name": "X-Forwarded-For",
              "value": "223.226.79.35"
            },
            {
              "name": "Cache-Control",
              "value": "no-cache"
            },
            {
              "name": "Connection",
              "value": "Keep-Alive"
            },
            {
              "name": "Content-Length",
              "value": "292"
            },
            {
              "name": "Content-Type",
              "value": "application/soap+xml; action=http://tempuri.org/Multiply"
            },
            {
              "name": "Accept",
              "value": "*/*"
            },
            {
              "name": "Accept-Encoding",
              "value": "gzip,deflate,br"
            },
            {
              "name": "Accept-Language",
              "value": "en-US,en;q=0.5"
            },
            {
              "name": "Host",
              "value": "pratyay.azure-api.net"
            },
            {
              "name": "Referer",
              "value": "https://apimanagement.hosting.portal.azure.net/apimanagement/Content/1.0.385.3/apimap/apimap-apis/index.html?locale=en&trustedAuthority=https://ms.portal.azure.com"
            }
          ]
        }
      }
    }
```

The SOAP 1.1 request needs a request header `SOAPAction` that's missing in the initial request sent from API Management as shown in the following example:

```xml
    Host: www.dneonline.com
    Content-Type: text/xml; charset=utf-8
    Content-Length: length
    SOAPAction: "http://tempuri.org/Multiply"
```

Adding the `SOAPAction` header with the value `http://tempuri.org/Multiply` resolves the problem. Add the request header under the `Frontend` definition of the **Multiply** operation, and then set the value as a default value in the **Headers** tab. You no longer need to send that header value for each request.

:::image type="content" source="media/soap-based-api-return-404-500-http-code/header.png" alt-text="Screenshot of the Multiply operation Headers tab with the SOAPAction header and its default value." lightbox="media/soap-based-api-return-404-500-http-code/header.png":::

A **Divide** operation causing **HTTP 500 (Internal Server Error)** errors indicates the server encountered an unexpected condition that prevented it from fulfilling the request. This condition means the backend service can't process your request body sent from API Management. 

You can now examine the request body sent from API Management. The denominator (`intB`) is set to zero which leads to an unhandled exception. This condition is the cause of the **HTTP 500 (Internal Server Error)**. 

The following example shows the request body sent from API Management inspector trace for a **Divide** operation:

```xml
    POST calc HTTP/1.1
    
    Host: pratyay.azure-api.net
    SOAPAction: http://tempuri.org/Divide
    Cache-Control: no-cache
    Ocp-Apim-Trace: true
    Content-Type: application/soap+xml; action=http://tempuri.org/Divide
    Ocp-Apim-Subscription-Key: ********************************
    
    <?xml version="1.0" encoding="utf-8"?>
    <Envelope xmlns="http://www.w3.org/2003/05/soap-envelope">
      <Body>
        <Divide xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://tempuri.org/">
          <intA>1</intA>
          <intB>0</intB>
        </Divide>
      </Body>
    </Envelope>
```

When you check the request content representation from the **Request** tab present in the `Frontend` definition of the **Divide** operation, you can see that the **intB** value is set to zero. Change the value of `intB` to a non-zero value. This change should resolve the issue.

:::image type="content" source="media/soap-based-api-return-404-500-http-code/intb-value.png" alt-text="Screenshot of the Divide operation Request tab with the intB input value set to zero." lightbox="media/soap-based-api-return-404-500-http-code/intb-value.png":::

 
