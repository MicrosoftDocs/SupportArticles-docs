---
title: Bad gateway error deploying software updates
description: Describes a problem in which you receive a Bad gateway error message when you deploy software updates in System Center 2012 Configuration Manager.
ms.date: 12/05/2023
ms.reviewer: kaushika, ErinWi, prakask, keiththo, btoth, soalves
---
# Bad gateway error when deploying software updates in System Center 2012 Configuration Manager

This article provides a solution for the issue that a **Bad gateway** error occurs when you try to deploy software updates in Microsoft System Center 2012 Configuration Manager.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 2688030

## Symptoms

Consider this scenario:

- You use Forefront Threat Management Gateway as a Web Proxy Auto-Discovery Protocol (WPAD) server that provides proxy an autoconfiguration script file (Wpad.dat) to client computers.
- You update the WPAD server to add proxy exception entries.

In this scenario, when you use System Center 2012 Configuration Manager to deploy software updates in the enterprise, you receive an error message that resembles the following:

> Http: Response, HTTP/1.1, Status: Bad gateway, URL: `http://Exception_URL/ClientWebService/client.asmx`

## Cause

This problem occurs because of a case-sensitive issue in the Wpad.dat file. The entries in the Wpad.dat file must be in lowercase. The proxy exception checks in the script file (Wpad.dat) that Threat Management Gateway provides works only if the destination URL (This URL is determined for the proxy server) is passed to the WPAD server in lowercase.

## Resolution

To resolve this problem, enable the `ConvertUrlToLowerCase` property to allow for URLs that are in lowercase and that are passed to the routing script. By default, this property is disabled.

To enable the `ConvertUrlToLowerCase` property, follow these steps:

1. Back up the Threat Management Gateway settings.
2. In Notepad, create a file that is named *TMG_ConvertUrlToLowerCase.vbs*.
3. Copy and paste the following script to the file:

    ```vb
    '
    ' set wpad script to lowercase its input url - for Internal network
    '
    set fpc = CreateObject("FPC.ROOT")
    set net_internal = fpc.GetContainingArray().NetworkConfiguration.Networks("Internal")
    set wpad = net_internal.ClientConfig.Browser.AutoScript
    wpad.ConvertUrlToLowerCase = -1
    wpad.save
    ```

4. Save and close the file.
5. Open a command prompt with administrative permissions, and run the `cscript TMG_ConvertUrlToLowerCase.vbs` command.

6. Make sure that you wait a long enough time to sync with Forefront Threat Management Gateway Enterprise Management Server (EMS).
