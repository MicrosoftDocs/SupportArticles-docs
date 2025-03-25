---
title: Collect HTTPS Traffic using Fiddler from Python app with Microsoft Entra ID
description: Provide instructions on how to collect HTTPS traffic using Fiddler from Microsoft Entra ID Apps
ms.date: 03/20/2025
ms.author: bachoang
ms.service: entra-id
ms.custom: sap:Enterprise Applications
---
# Collect HTTPS traffic using Fiddler from Python Apps

Capturing encrypted HTTPS web traffic in Python with Fiddler can be challenging because Python uses its own trusted certificate store rather than the operating system’s certificate store. Additionally, Python does not use a proxy by default in certain scenario. This article explains how to capture SSL traffic using Fiddler for Python app across different scenarios.

## ADAL for Python

When you use Fiddler to capture HTTPs traffic in an Python app that integrates Azure Active Directory Authentication Library (ADAL), you may receive SSL errors. This issue occurs because Python doesn't trust the Fiddler certificate. Here are two methods to work around this issue:

> [!Note]
> Disabling SSL verification isis a security risk. It should only be used for troubleshooting purposes and avoided in production environments.

- Set an environment variable at the beginning of your Python app before initializing the AuthenticationContext object:

    ```python
    import os
    ...
    os.environ["ADAL_PYTHON_SSL_NO_VERIFY"] = "1"
    ```
- Pass the `verify_ssl=False` flag to the AuthenticationContext method:
    ```python
    context = adal.AuthenticationContext(authority, verify_ssl=False)
    ```

## MSAL for Python
When you use the Microsoft Authentication Library (MSAL) for Python, you can disable SSL verification as follows:

```python
app = msal.PublicClientApplication( client_id=appId, authority="https://login.microsoftonline.com/" + tenantId, verify=False )
```
## Python Requests Module

The Requests module does not use Proxy by default. You must force the request to go through the Fiddler proxy.  The following example shows how to do this:

```python
import requests

…
access_token = token.get('accessToken')
endpoint = "api_endpoint"
headers = {"Authorization": "Bearer " + access_token}
json_output = requests.get(
    endpoint,
    headers=headers,
    proxies={"http": "http://127.0.0.1:8888", "https": "http://127.0.0.1:8888"},
    verify=False
).json()
```
## AAD Libraries for Python or GraphRbacManagementClient

The following example shows how to disable SSL verification:

```python
from azure.graphrbac import GraphRbacManagementClient
from azure.common.credentials import UserPassCredentials

credentials = UserPassCredentials(
      <username>,    # Your user name
      <password>,    # Your password
      resource=”https://graph.windows.net”,
      verify=False
)
tenant_id = <tenant name or tenant id>
graphrbac_client = GraphRbacManagementClient(credentials, tenant_id)
graphrbac_client.config.connection.verify=False
res = graphrbac_client.users.get(<UPN or ObjectID>)
print(res.display_name)
```

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
