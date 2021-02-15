---
title: Web Deploy publishing endpoint is changed
description: This article describes a change in functionality that's provided by Windows Azure Pack.
ms.date: 03/19/2020
ms.prod-support-area-path: Deployment and migration
ms.topic: article
---
# WebDeploy publishing endpoint is changed in WAP-Websites [UR6]

This article introduces changes in Web Deploy publishing endpoint.

_Original product version:_ &nbsp; Windows Azure Pack (on Windows Server 2012 R2)  
_Original KB number:_ &nbsp; 3080425

## Summary

Tenants and admins of Wireless Application Protocol (WAP) Websites V2U6 may notice that the WebDeploy protocol publishes URL for new websites no longer points to the publisher location, but instead points to the GIT protocol publish URL.

## Changes in WAP Websites V2U6

Starting with V2U6 (April 2015), the Web Deploy publishing protocol was moved from the Publisher role to the Worker role for WAP Websites. The publishing profile for newer sites now points to the new Web Deploy location. However, the system still honors old profiles that point to the Web Deploy protocol on the publisher.

Example of the new V2U6 publishing profile (snip):

```xml
<publishData>
    <publishProfile profileName="Site1 - Web Deploy" publishMethod="MSDeploy"
        publishUrl="Site1.SCM.contosocloud.com:443"
        msdeploySite="Site1" userName="$Site1" userPWD="<password>"
        destinationAppUrl="http://Site1.contosocloud.com">
    </publishProfile>
</publishData>
```

Example of the old publishing profile:

```xml
<publishData>
    <publishProfile profileName="Site1 - Web Deploy" publishMethod="MSDeploy"
        publishUrl="publish.contosocloud.com"
        msdeploySite="Site1" userName="$Site1" userPWD="<password>"
        destinationAppUrl="http://Site1.contosocloud.com">
    </publishProfile>
</publishData>
```

## Changes in WAP Websites V2U7

In V2U7 (July 2015), this change was refined slightly in response to customer concerns so that only new installations of WAP Websites will change the WebDeploy endpoint from the Publisher to the Worker. It will let existing systems continue to operate without a publishing change while the new method is pushed out to new WAP Website deployments.  

In V2U7, you can control the WebDeploy publishing configuration to use either the publisher or the web worker by using the following PowerShell cmdlets:

```console
Import-Module WebSites
```

- Set publishing to use web worker:

   ```powershell
    Set-WebSitesConfig -Type Global -UseWebDeployScm $true
    ```

- Set publishing to use publisher

    ```powershell
    Set-WebSitesConfig -Type Global -UseWebDeployScm $false
    ```
