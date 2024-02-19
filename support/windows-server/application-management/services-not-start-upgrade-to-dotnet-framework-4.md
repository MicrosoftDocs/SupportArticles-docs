---
title: Services depending on ASP.NET State Service don't start
description: Describes an issue that may occur on a Windows Server computer. Provides a workaround.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:.net-framework-installation, csstroubleshoot
---
# Services that depend on the ASP.NET State Service do not start after you upgrade to the .NET Framework 4.0

This article provides a workaround for an issue where services that depend on the `ASP.NET` State Service don't start after you upgrade to the Microsoft .NET Framework 4.0.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2963657

## Symptoms

Consider the following scenario:  

- You have a computer that is running Windows Server.
- The ASP.NET State Service is installed as part of Internet Information Services (IIS).
- An installed service depends on the ASP.NET State Service.
- You upgrade the Microsoft .NET Framework 3.51 to the .NET Framework 4.0.

In this scenario, you notice that after you upgrade .NET Framework, any service that depends on the ASP.NET State Service does not start and generates the following error:

> Windows could not start the \<service name> service on \<computer name>.
>
> Error 1075: The dependency service does not exist or has been marked for deletion.

You also notice that the ASP.NET State Service is no longer listed in the Services Management console.

## Cause

This is a known issue that occurs when you update .NET Framework.

## Workaround

To work around this issue, follow these steps:  

1. Open the Services management console (services.msc).
2. Change to **Manual** the start type of any service that depends on the ASP.NET State Service and that is set to **Automatic**.
3. At an Administrative command prompt, type the following command, and then press Enter:

    ```console
    %SystemRoot%\ Microsoft.NET\Framework64\v4.0.30319 \aspnet_regiis /iru
    ```

4. Restart the computer.
5. Open the Services management console (services.msc) again.
6. Change to **Automatic**  the start type of the service or services that had their start type changed in step 2, that depend on the ASP.NET State Service, and that now have their start type set to **Manual**. Restart the computer, and then confirm that the issue is resolved.
