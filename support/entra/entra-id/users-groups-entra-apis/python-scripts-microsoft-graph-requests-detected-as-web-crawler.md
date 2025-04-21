---
title: Python Scripts Making Microsoft Graph Requests Are Detected as Web Crawlers
description: Provides solutions to an issue where Python Scripts might be detected as web crawlers when making Microsoft Graph requests.
ms.date: 04/21/2025
ms.service: entra-id
ms.custom: sap:Problem with using the Graph SDK - libraries
ms.reviewer: daga, v-weizhu
---
# Python scripts making Microsoft Graph requests are detected as web crawlers

This article provides solutions to an issue where Python scripts might be detected as web crawlers when making Microsoft Graph requests.

## Symptoms

A Python script that makes a Microsoft Graph request might sometimes be detected by the gateway as web crawlers. If Python scripts use a pool manager, the following error message is returned when you block the request:

```output
{'error': {'code': 'UnknownError', 'message': '\r\n403 Forbidden\r\n\r\n
403 Forbidden
\r\n
Microsoft-Azure-Application-Gateway/v2
\r\n\r\n\r\n', 'innerError': {'date': '{UTC Date/Time}', 'request-id': '{guid}', 'client-request-id': '{guid}'}}}
```

## Cause

The issue occurs because some Python scripts might not structure their requests in a way that conforms to the expected patterns. As a result, the gateway mistakenly identifies the requests as coming from a web crawler.

## Solution

To resolve this issue, use the [Microsoft Graph SDK for Python](https://github.com/microsoftgraph/msgraph-sdk-python-core). If you don't want to use it, structure your requests similarly to how the SDK handles them by using Python's `Session` object to send requests.

Here's an example of how you can structure your requests manually:

```python
from requests import Request, Session

def example_request(url):
    http = Session()
    req = Request('GET', url, headers=h)
    prepped = req.prepare()
    resp = http.send(prepped)
    return resp.json()
```

> [!NOTE]
> - The `User-Agent` string in the HTTP request header should be unique to your application or script, differentiating it from generic traffic.
> - Including additional headers such as `Accept: application/json` can help clarify the intent of your request.
> - Incorrectly identified as crawler traffic might result in throttling or other automated mitigations by Microsoft's backend systems. Properly identifying your client helps avoid these issues.

If you use a different HTTP client, ensure that similar headers are set appropriately. Refer to your HTTP client's documentation for customizing request headers.

## More information

For more guidance on best practices when using Microsoft Graph, see the following articles:

- [Use the Microsoft Graph API](/graph/use-the-api)
- [Microsoft Graph throttling guidance](/graph/throttling)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
