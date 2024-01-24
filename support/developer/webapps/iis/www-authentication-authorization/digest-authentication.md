---
title: Digest authentication fails
description: This article provides workarounds for the problem where digest authentication fails when a client sends a request through a proxy to a site IIS using digest authentication.
ms.date: 04/07/2020
ms.custom: sap:WWW authentication and authorization
ms.technology: www-authentication-authorization
ms.reviewer: atsushin, bariscag
---
# IIS digest doesn't permit pass-though authentication of proxy requests

This article helps you resolve the problem where digest authentication fails when a client sends a request through a proxy to a site and Microsoft Internet Information Services (IIS) uses digest authentication.

_Original product version:_ &nbsp; Internet Information Services 8.5, 8.0  
_Original KB number:_ &nbsp; 3050055

## Symptoms

Consider the following scenario:

- IIS is configured to use digest authentication.
- The server receives a request with the via HyperText Transfer Protocol(HTTP) header. (This occurs if the client request is rerouted through a proxy.)
- The resource requested is protected by digest authentication.
- A child request is created in the IIS pipeline. For example, a request is sent for a directory's default document, and the URL that is sent has a slash (/) as the last character.

In this scenario, digest authentication fails, and the server returns a 401 response.

## Cause

For security reasons, requests routed through a proxy and for which a child request is created in the IIS pipeline, IIS can't trust the digest authentication.

## Workaround

Configure the website to use a different kind of authentication. For example, use Windows Authentication or basic authentication over Transport Layer Security (TLS). If you can't, try the following methods:

- Have the client use a request URL including the file name after the last **/** character.
- Set the application pool's managed pipeline mode to **Classic**.
- Use the [URL Rewrite module](https://www.iis.net/downloads/microsoft/url-rewrite) to rewrite the URL path from **/** to **/filename**.

To use the URL Rewrite module to work around this issue, configure the module as follows:

```xml
<system.webServer>
    <rewrite>
        <rules>
            <rule name="<a rule name>" enabled="false">
                <match url="(^$|.*/$)" />
                <action type="Rewrite" url="{R:0}<a file name that you want the users to access>" />
            </rule>
        </rules>
    </rewrite>
</system.webServer>
```
