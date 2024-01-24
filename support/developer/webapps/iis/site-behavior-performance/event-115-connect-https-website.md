---
title: Event 115 when you connect HTTPS website
description: This article provides workarounds for the Event ID 115 error that occurs when you connect to a Web site by using HTTPS.
ms.date: 03/23/2020
ms.custom: sap:Site behavior and performance
ms.reviewer: lauras, martinsm
ms.subservice: site-behavior-performance
---
# Event ID 115 occurs when you try to connect to a HTTPS Website

This article helps you resolve the error (Event ID 115) that occurs when Microsoft Internet Information Services (IIS) is unable to bind to the port or IP address specified in the settings because they're used by another program or service.

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 284984

> [!NOTE]
> Upgrading to IIS version 7.0 running on Windows Server 2008 significantly increases Web infrastructure security.

## Symptoms

Error message when attempting to connect to an Hypertext Transfer Protocol Secure (HTTPS) website with Internet Explorer:

> This page cannot be displayed

The following information occurs in the event logs:

> Event Type:Error  
> Event Source:W3SVC  
> Event ID:115  
> Description: The service could not bind instance 1. The data is the error code.  
> Data: 0000: 34 00 00 00 4...

> [!NOTE]
> The **instance** in the error description refers to the website number. Websites are numbered incrementally as they are added to IIS. This error indicates that the Default website (or site number 1) is having problems. In this example, Event ID: 115 refers to the Secure Sockets Layer (SSL) portion of the Default website that's unable to start. Event ID: 113 refers to the port 80 bindings (non-SSL) having trouble to start.

## Workaround 1

Website number 3 has the following settings:

- IP address assigned as 192.168.0.1
- TCP Port assigned as 80
- SSL Port assigned as 443
- Host Header of `www.company.com`

Website number 10 has the following settings:

- IP address assigned as 192.168.0.1
- TCP Port assigned as 80
- SSL Port assigned as 443
- Host Header of `www.different.com`

To host multiple websites on IIS, websites must use different IP addresses, different port numbers, or different Host Headers. In this example, the settings seem correct because the Host Header on each site is different. However, Host Headers can't be used, for the purpose of SSL. That means the SSL portion of the websites have the same settings. When the web service initializes, it can start the first website completely. When it tries to start website 10, it can start the port 80 portion, but can't start the port 443 portion, which causes the Event ID 115 error. To resolve this problem, assign a different IP address to one of the websites. That will make them unique for both TCP and SSL considerations.

Since IIS 8, the new feature Server Name Indication (SNI) is provided to resolve such issue.

## Workaround 2

Website number 3 has the following settings:

- IP address assigned as **All Unassigned**
- TCP Port assigned as 80
- SSL Port assigned as 443
- Host Header is blank since we cannot use it with SSL

Website number 10 has the following settings:

- IP address assigned as 192.168.0.1
- TCP Port assigned as 80
- SSL Port assigned as 443
- Host Header is blank since we cannot use it with SSL

In this example, there are unique settings for both SSL and TCP, because Web site 1 is not bound to any particular IP address, and Website 10 is bound to a particular IP address. If you are using SSL, when the SSL portion of Website 1 initializes, it essentially binds to all IP addresses on port 443, which causes Event ID 115 on instance 10.

Since IIS 8, the new feature `SNI` is provided to resolve such issue.

## Workaround 3

If you have assigned each SSL website a unique IP address and you still receive an Event ID 115, there may be some Advanced settings on a website which are preventing the SSL portions of your websites from being unique. To view these settings go into the Properties for each website and select **Advanced** on the website tab. You will see a section called **Multiple SSL Identities for this website**. If only one IP address is assigned to the website, make sure there's a single SSL identity.

Since IIS 8, the new feature `SNI` is provided to resolve such issue.

## Workaround 4

If all else fails, another program or service is probably bound to port 443. In this case, all your websites (instances) using SSL are logged with an Event ID 115.

Here's how to check this:

1. From a command prompt, type `net stop iisadmin` , and press ENTER to stop the IISADMIN service.

    > [!NOTE]
    > You may need to stop other IIS services.

2. Type `netstat -a` and press ENTER. (If the output is too long, you may need to pipe the output by using `|` more or `> output.txt`)
3. Look for `0.0.0.0:443` or any other IP address ending in **:443** under the **Local Address**. For example, *column. 0.0.0.0* means something is bound to all IP addresses on port 443 and 192.0.0.1:443. After the IIS Admin Service (IISADMIN) service is stopped, if you see `0.0.0.0:443`, something else than IIS is bound and listening on port 443. Stop programs using port 443 to allow your websites to run normally.
