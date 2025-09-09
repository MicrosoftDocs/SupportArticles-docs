---
title: ASP.NET SignalR application cannot be accessed although all role instances are in running state
description: Provides information about troubleshooting issues in which the ASP.NET SignalR application is not able to access with error "Can't reach this page".
ms.date: 09/26/2022
ms.reviewer: 
author: JarrettRenshaw
ms.author: jarrettr
ms.service: azure-cloud-services-classic
ms.custom: sap:Development
---
# ASP.NET SignalR application cannot be accessed although all role instances are in running state

This article provides information about troubleshooting issues in which the ASP.NET SignalR application is not able to access with error "Can't reach this page".

_Original product version:_ &nbsp; API Management Service  
_Original KB number:_ &nbsp; 4464839

> [!NOTE]
> Referring to the article on [Azure Cloud Service Troubleshooting Series](https://support.microsoft.com/help/4466645), this is the seventh scenario of the lab. Make sure you have followed the lab setup instructions for Visitor Tracker application as per [this](https://github.com/prchanda/visitortracker), to recreate the problem.

## Symptoms

Visitor Tracker is an ASP.NET SignalR application that tracks the number of visitors accessing the website. But suddenly for some reason you are unable to access the application over default cloud service url (`http://cloudservicelabs.cloudapp.net/`) and getting an error on the IE browser stating that "Can't reach this page", although the role instances are in running state.

:::image type="content" source="media/asp-net-signair-app-cannot-access/visitor-tracker.png" alt-text="Screenshot of the application state in Visitor Tracker.":::

## Troubleshoot Steps

1. About application and service availability, the first thing that needs to check is whether the input endpoint is responding or not. By default HTTP port 80 is always opened for a cloud service web role, you can use [PsPing](/sysinternals/downloads/psping) to check if port 80 is open or not.

    ```console
    psping cloudservicelabs.cloudapp.net:80

    PsPing v2.01 - PsPing - ping, latency, bandwidth measurement utilityCopyright (C) 2012-2014 Mark RussinovichSysinternals - www.sysinternals.com

    Invalid destination address:Host not found.
    ```

    In this example, Port 80 is blocked.

2. Run [PortQry](https://www.microsoft.com/download/details.aspx?id=24009) tool that you can use to troubleshoot TCP/IP connectivity issues like this one. It comes in both flavors, command line and GUI version as well.

    ```console
    Starting portqry.exe -n cloudservicelabs.cloudapp.net -e 80 -p TCP ...

    Querying target system called:

    cloudservicelabs.cloudapp.net

    Attempting to resolve name to IP address...

    Name resolved to 40.124.28.4

    querying...

    TCP port 80 (http service): FILTEREDportqry.exe -n cloudservicelabs.cloudapp.net -e 80 -p TCP exits with return code 0x00000002.
    ```

    You can see the **Portqry.exe** reports the status of a TCP/IP port 80 as Filtered which means it is blocked as per [this](https://support.microsoft.com/help/310099/description-of-the-portqry-exe-command-line-utility) documentation. To check how the application responds over localhost, enable the RDP for the role and log into the instance to browse the application locally. When opening the IIS, you may find that there is an http binding over port 81 and not on default http port 80. So the request was not reaching the IIS and subsequently you were getting the error "Can't reach this page", whereas locally the website spawned up as expected.

3. Browse the cloud service url over port 81 - (`http://cloudservicelabs.cloudapp.net:81/`) and check the result. If it fails, run the following `psping` commands.

    ```console
    psping cloudservicelabs.cloudapp.net:81

    PsPing v2.01 - PsPing - ping, latency, bandwidth measurement utilityCopyright (C) 2012-2014 Mark RussinovichSysinternals - www.sysinternals.com

    TCP connect to 40.124.28.4:81:5 iterations (warmup 1) connecting test:Connecting to 40.124.28.4:81 (warmup): This operation returned because the timeout period expired.

    Connecting to 40.124.28.4:81: This operation returned because the timeout period expired.
    Connecting to 40.124.28.4:81: This operation returned because the timeout period expired.
    Connecting to 40.124.28.4:81: This operation returned because the timeout period expired.
    Connecting to 40.124.28.4:81: This operation returned because the timeout period expired.  

    TCP connect statistics for 40.124.28.4:81:Sent = 4, Received = 0, Lost = 4 (100% loss),Minimum = 0.00ms, Maximum = 0.00ms, Average = 0.00ms
    ```

    It seems like the client request is not reaching the server. In this situation, collect simultaneous network trace from client and server to get a holistic picture. From the server side, you may not see any request reaching from my client machine, however from client-side trace you may see that client tried to send SYN packets thrice as per TCP handshake sequence but server didn't acknowledged it.

    If the above network trace shows that request is getting blocked, the question is who is blocking it and how? May be firewall or ACL? After check the **ServiceConfiguration.cscfg** file of the cloud service solution, you may find that there is an ACL rule that is blocking the traffic.

    ```
    <NetworkConfiguration>
    <AccessControls>
    <AccessControl name="ACS">
    <Rule action="deny" description="ACS" order="100" remoteSubnet="0.0.0.0/0" />
    </AccessControl>
    </AccessControls>
    <EndpointAcls>
    <EndpointAcl role="Tracker" endPoint="Endpoint1" accessControl="ACS" />
    </EndpointAcls>
    </NetworkConfiguration>
    ```

4. Remove the ACL rule.

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
