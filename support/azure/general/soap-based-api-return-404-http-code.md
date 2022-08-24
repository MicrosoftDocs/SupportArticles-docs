---
title: Azure API Management Troubleshooting Scenario 2 - SOAP-based API returning 404 and 500 HTTP status codes
description: Provides troubleshooting steps to an issue in which SOAP-based API is returning 404 and 500 HTTP status codes
ms.date: 08/14/2020
author: genlin
ms.author: genli
ms.service: api-management
ms.reviewer: 
---
# SOAP-based API is returning 404 and 500 HTTP status codes

Referring to the article on [Azure API Management Troubleshooting Series](apim-troubleshooting-series.md), this is the second scenario of the lab. Make sure you have followed the lab setup instructions as per [this](https://github.com/prchanda/apimlab), to recreate the problem.

_Original product version:_ &nbsp; API Management Service  
_Original KB number:_ &nbsp; 4464934

## Symptoms

The Calculator API can perform four operations - **Add**, **Subtract**, **Multiply**, and **Divide**  based upon two input parameters **intA**  and **intB**. Name of the operations is self-explanatory to what function they perform. It's an ASMX service ([http://www.dneonline.com/calculator.asmx](http://www.dneonline.com/calculator.asmx)) following SOAP 1.1 protocol so the input parameters are passed in the soap envelope body section. Add and Subtract operations are working fine as expected, but you are encountering **HTTP 404**  while invoking Multiply operation and **HTTP 500**  while invoking Divide operation.

Expected output of Multiply operation should be something like below:

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

Expected output of Divide operation should be something like below:

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

## Troubleshooting steps

You need to understand who is throwing these HTTP 404 and 500 responses, APIM, or the backend SOAP API. The best way to get that answer is to collect [APIM inspector trace](/azure/api-management/api-management-howto-api-inspector) to inspect request and response.

- Multiply operation throwing HTTP - 404 (Not Found) status code indicates that the origin server did not find a current representation for the target resource or is not willing to disclose that one exists.
- If you examine the backend section of APIM inspector trace, the same observation is evident from the message as well:

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

- Hence you should first examine the request url and headers sent from APIM to the backend API from the **Test** tab and compare it with the sample of SOAP request for Multiply operation - [http://www.dneonline.com/calculator.asmx](http://www.dneonline.com/calculator.asmx).

    Request headers from APIM inspector trace look something like below:

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

- As per the backend ASMX service definition you would notice SOAP 1.1 request needs a request header **SOAPAction that is missing in the request sent from APIM.

    ```xml
    Host: www.dneonline.com
    Content-Type: text/xml; charset=utf-8
    Content-Length: length
    SOAPAction: "http://tempuri.org/Multiply"
    ```

- Adding **SOAPAction** header with the value [http://tempuri.org/Multiply](http://tempuri.org/Multiply) will resolve the problem. You can add the request header under the **Frontend** definition of the Multiply operation and set the value as a default one under **Headers** tab so that you don't have to send that header every time on each request.

    :::image type="content" source="media/soap-based-api-return-404-500-http-code/header.png" alt-text="Screenshot of the Headers tab, where SOAPAction header with the value is added.":::

- Divide operation throwing HTTP 500 (Internal Server Error) status code indicates that the server encountered an unexpected condition that prevented it from fulfilling the request.
- In other words, backend service is not able to process your request body sent from APIM. You can examine the request body sent from APIM.
- Upon checking the SOAP body, you would notice that denominator (**intB**) is set as zero, leading to an unhandled exception, hence causing HTTP 500 (Internal Server Error).

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

- If you check the request content representation from the **Request** tab present in **Frontend** definition of the Divide operation, you would notice that **intB** value is set to zero. You need to change the value of **intB** to a non-zero value and it should resolve the issue.

    :::image type="content" source="media/soap-based-api-return-404-500-http-code/intb-value.png" alt-text="Screenshot of the intB value that is set to zero.":::

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
