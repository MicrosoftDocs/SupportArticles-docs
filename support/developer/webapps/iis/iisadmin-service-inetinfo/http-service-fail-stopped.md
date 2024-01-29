---
title: HTTP services can't be stopped
description: This article describes the problem where you can't stop the HTTP service by using the NET STOP HTTP command when the Microsoft Web Deployment Service (MSDEPSVC) is installed, and provides a solution.
ms.date: 02/27/2020
ms.reviewer: bretb
ms.custom: sap:IISAdmin service and Inetinfo process operation
ms.subservice: iisadmin-service-inetinfo
---
# HTTP services can't be stopped when the Microsoft Web Deployment Service is installed

This article helps you resolve the problem where you can't stop HTTP services by using the NET STOP HTTP command when the Microsoft Web Deployment Service (MSDEPSVC) is installed.

_Original product version:_ &nbsp; Microsoft Web Deployment Service  
_Original KB number:_ &nbsp; 2597817

## Symptoms

Consider the following scenario. You are attempting to stop the HTTP service on a server running Internet Information Services (IIS) 6, 7, or 7.5. The server also has the Microsoft Web Deployment Service (MSDEPSVC) installed. When you try to stop the HTTP service by using the `NET STOP HTTP` command-line instruction, the following error message is displayed in the command prompt:

> The HTTP service is stopping.....  
> The HTTP service could not be stopped.

If you run the `NET STOP HTTP` command again, the following message is displayed:

> The service is starting or stopping. Please try again later.

## Cause

This problem occurs because the Microsoft Web Deployment Service (MSDEPSVC) depends on the HTTP service, but when the MSDEPSVC is initially installed that dependency is not registered with the Service Control Manager. When HTTP tries to stop, it needs to stop its dependent services as well. However, HTTP is not aware that it needs to stop MSDEPSVC due to the unregistered dependency and therefore the service stoppage fails.

## Resolution

To resolve this problem, copy the following script and run it as a PowerShell script on the server. The script will ensure that all dependencies of the HTTP service are properly registered.

```PowerShell
$bFoundHttp = $false
$msdepsvc = Get-Service -name MsDepSvc
$reqsvcs = "HTTP"
$msdepsvc.ServicesDependedOn | ForEach-Object `
{
    if($_.Name -eq "HTTP")
    {
      $bFoundHttp = $true
    }
    else
    {
    if($_.Name -ne "")
     {
       $reqsvcs += "/" + $_.Name
     }
    }
}
if ($bFoundHttp -eq $false)
{
    $status = $msdepsvc.Status
    if($status -eq "Running")
    {
      Stop-Service -name MsDepSvc
    }

    sc.exe config MsDepSvc depend= $reqsvcs
    if($status -eq "Running")
    {
      Start-Service -name MsDepSvc
    }
}
```

Check whether the problem is fixed. If the problem is fixed, you are finished with this section. If the problem is not fixed, you can [contact support](https://support.microsoft.com/contactus/).

## References

For more information about the Web Deployment Tool, see [Web Deploy 3.6](https://www.iis.net/download/webdeploy).
