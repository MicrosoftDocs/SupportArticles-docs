---
title: An attempt was made to access a socket in a way forbidden by its access permissions message - Azure App Service
description: Learn how to troubleshoot the "An attempt was made to access a socket in a way forbidden by its access permissions" message in Azure App Service.
author: kaushika-msft
ms.author: kaushika
ms.reviewer: kaushika
manager: dcscontentpm
ms.topic: troubleshooting
ms.service: azure-app-service
ms.date: 08/18/2026
ms.custom: sap:Availability, Performance, and Application Issues
---
# An attempt was made to access a socket in a way forbidden by its access permissions message

## Summary

This article explains possible causes and solutions for the **An attempt was made to access a socket in a way forbidden by its access permissions** message in Azure App Service and helps you troubleshoot the error.

## Symptom

You encounter the following message:

> An attempt was made to access a socket in a way forbidden by its access permissions.

## Cause 1: Outbound TCP connections are exhausted

This error usually occurs if the outbound TCP connections on the virtual machine (VM) instance are exhausted. In App Service, the platform enforces limits for the maximum number of outbound connections that you can make for each VM instance.

## Solution 1: Review cross-VM numerical limits

For more information, see [Cross-VM numerical limits](https://github.com/projectkudu/kudu/wiki/Azure-Web-App-sandbox#cross-vm-numerical-limits).

## Cause 2: The application accesses a local address

This error might also occur if you try to access a local address from your application. 

## Solution 2: Review local address requests

For more information, see [Local address requests](https://github.com/projectkudu/kudu/wiki/Azure-Web-App-sandbox#local-address-requests).

## Resources

For more information about outbound connections in your web app, see the blog post about [outgoing connections to Azure websites](https://www.freekpaans.nl/2015/08/starving-outgoing-connections-on-windows-azure-web-sites/). 

