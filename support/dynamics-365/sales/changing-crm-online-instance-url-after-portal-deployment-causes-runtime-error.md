---
title: Runtime error when changing CRM Online instance URL
description: Changing the Microsoft Dynamics CRM Online instance URL after deployment of a portal, you receive a Runtime error. Provides a resolution.
ms.reviewer: jbirnbau
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-access
---
# Changing the Microsoft Dynamics CRM Online instance URL after deployment of a portal causes a Runtime error

This article provides a resolution for the issue that a Runtime error occurs when you change the Microsoft Dynamics CRM Online instance URL after deployment of a portal.

_Applies to:_ &nbsp; Microsoft Dynamics CRM Online  
_Original KB number:_ &nbsp; 3177288

## Symptoms

If the URL of a Microsoft Dynamics CRM Online instance is changed following the deployment of a Portal Add-on application, navigating to the portal website will present the following error:

> Server Error in '/' Application
>
> Runtime Error
>
> Description: An exception occurred while processing your request. Additionally, another exception occurred while executing the custom error page for the first exception. The request has been terminated.

## Cause

When deploying the Portal Add-on application to a Microsoft Dynamics CRM Online instance, the URL of the instance is captured for authentication purposes. If the URL of the Microsoft Dynamics CRM Online instance is changed following the deployment, the previously captured URL continues to be used and authentication between the portal website and the Microsoft Dynamics CRM Online instance will fail.

## Resolution

Changing the URL of the Microsoft Dynamics CRM Online instance back to its original value will allow the authentication to succeed and the error will no longer occur.

A fix is being developed to automatically update the portal configuration to reference the new URL in the event of a change. However, if changing the URL of the Microsoft Dynamics CRM Online instance back to its original value is not an option before this fix is available, contact Microsoft support to update the portal configuration manually.
