---
title: Collect HTTPS Traffic using Fiddler from Python app with Microsoft Entra ID
description: Provide instructions to collect HTTPS traffic by using Fiddler from Microsoft Entra ID apps
ms.date: 03/20/2025
ms.author: bachoang
ms.service: entra-id
ms.custom: sap:Enterprise Applications
---
# Collect HTTPS traffic by using Fiddler from Python apps

Capturing encrypted HTTPS web traffic in Python by using Fiddler can be challenging because Python uses its own trusted certificate store instead of the operating system certificate store. Additionally, by default, Python doesn't use a proxy in certain scenarios. This article explains how to capture SSL traffic by using the Fiddler for Python app in different scenarios.

## ADAL for Python

When you use Fiddler to capture HTTPS traffic in a Python app that integrates Azure Active Directory Authentication Library (ADAL), you might receive SSL error messages. This issue occurs because Python doesn't trust the Fiddler certificate. You can use either of two methods to work around this issue.

> [!Note]
> Disabling SSL verification presents a security risk. You should use this method only to troubleshoot. You should not use it in production environments.

- Set an environment variable at the beginning of your Python app before the `AuthenticationContext` object is initialized:

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
## Python Requests module

By default, the Requests module doesn't use a proxy. You must force the request to go through the Fiddler proxy, per the following example:

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
## Azure Active Directory SDK for Python (GraphRbacManagementClient)

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
