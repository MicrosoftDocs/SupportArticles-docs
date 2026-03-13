---
title: An Attempt was Made to Access a Socket in a Way Forbidden by its Access Permissions Message 
description: This article discusses possible causes and solutions for the message "An attempt was made to access a socket in a way forbidden by its access permissions" in Azure App Service.
author: JarrettRenshaw
manager: dcscontentpm
ms.topic: troubleshooting-general
ms.date: 12/19/2025
ms.author: jarrettr
ms.reviewer: v-ryanberg
ms.service: azure-app-service
ms.custom: sap:Availability, Performance, and Application Issues
---
# "An attempt was made to access a socket in a way forbidden by its access permissions" message

## Summary

This article discusses possible causes and solutions for the message "An attempt was made to access a socket in a way forbidden by its access permissions" in Azure App Service.

## Symptom

You see the message "An attempt was made to access a socket in a way forbidden by its access permissions."

## Cause 1

This error typically occurs if the outbound TCP connections on the virtual machine (VM) instance are exhausted. In App Service, limits are enforced for the maximum number of outbound connections that can be made for each VM instance. 

## Solution 1

For more information, see [Cross-VM numerical limits](https://github.com/projectkudu/kudu/wiki/Azure-Web-App-sandbox#cross-vm-numerical-limits).

## Cause 2

This error might also occur if you try to access a local address from your application. 

## Solution 2

For more information, see [Local address requests](https://github.com/projectkudu/kudu/wiki/Azure-Web-App-sandbox#local-address-requests).

## Resources

For more information about outbound connections in your web app, see the blog post about [outgoing connections to Azure websites](https://www.freekpaans.nl/2015/08/starving-outgoing-connections-on-windows-azure-web-sites/). 

