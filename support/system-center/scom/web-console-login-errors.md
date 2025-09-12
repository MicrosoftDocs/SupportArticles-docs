---
title: Login errors when installing the web console
description: Describes how to work around an issue in which host header or IP address binding causes web console login errors in System Center Operations Manager version 1801, 1807, 2019, or 2022.
ms.date: 04/15/2024
ms.custom: sap:Web Console installation
ms.reviewer: msadoff
---
# Host header or IP address binding causes web console login errors in Operations Manager

This article helps you work around an issue where you receive login errors when installing the web console in System Center Operations Manager version 1801, 1807, 2019, or 2022.

_Original product version:_ &nbsp; System Center Operations Manager  
_Original KB number:_ &nbsp; 4469591

## Symptoms

When you install the web console in System Center Operations Manager, you receive the following error message when you select the **Use Windows Authentication** sign-in option:

> The user credentials are invalid or user does not have permissions...

If you instead select the **Use Alternate Credentials** sign-in option, you receive the following error message after you enter credentials in the form:

> The remote server returned an error: (404) Not Found.

## Cause

This problem can occur when you configure a specific IP address or host header in the bindings of the web console website.

The problem occurs because web console consists of two separate web applications, `OperationsManager` and `MonitoringView`. Both web applications run as virtual directories under the same website. During login, the `OperationsManager` application makes an outbound request to the `MonitoringView` application's Login.aspx page. The hostname in this request is hard-coded as `localhost`. If the website has a host header or isn't bound to the loopback address, the site can't service the localhost request. Therefore, the site returns the **404** message.

## Workaround

If you bind the web console website to a specific IP address or use a host header, create additional bindings on the website for the same ports by using the loopback address or the `localhost` hostname, depending on the scenario.

Specifically, assume that you configure the following HTTP and HTTPS bindings:

|Type|IP address|Port|Host name|
|---|---|---|---|
|HTTP|\<_specific IP address_>|80||
|HTTPS|\<_specific IP address_>|443||
  
In the above bindings, host name is left blank.

In this scenario, you also must configure the following two bindings:

|Type|IP address|Port|Host name|
|---|---|---|---|
|HTTP|[::1]|80||
|HTTPS|[::1]|443||
  
> [!NOTE]
> Recent Windows versions use `[::1]` for the loopback address by default. If you have disabled IPv6 by using the `DisabledComponents` registry value, use _127.0.0.1_ in the binding.

Additionally, assume that you configure the following HTTP and HTTPS bindings:

|Type|IP address|Port|Host name|
|---|---|---|---|
|HTTP|All unassigned|80|\<_host name_>|
|HTTPS|All unassigned|443|\<_host name_>|
  
In the above bindings, \<_host name_> is the DNS name of the web server.

In this scenario, you also must configure the following two bindings:

|Type|IP address|Port|Host name|
|---|---|---|---|
|HTTP|All unassigned|80|localhost|
|HTTPS|All unassigned|443|localhost|
