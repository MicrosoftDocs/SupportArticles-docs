---
title: Exceptions occur if web servers use load balancer 
description: Support with CRM for Outlook and Email Router with Microsoft Dynamics CRM using cookie based persistence load balancer settings.
ms.reviewer: Derek Braun
ms.topic: troubleshooting
ms.date: 
---
# WCF failures occur when Dynamics 365 clients communicate through a load balancer

This article provides a resolution for the issue that you may receive errors from WCF-based clients when Microsoft Dynamics 365 web servers are configured to communicate via a load balancer.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011, Microsoft Dynamics CRM 2013  
_Original KB number:_ &nbsp; 2981140

## Symptoms

When Microsoft Dynamics 365 web servers are configured behind a load balancer, exceptions may occur from WCF-based clients such as the Outlook Client, Email Router, or SDK applications when communicating over web services. Examples of these exceptions may include:

> An unsecured or incorrectly secured fault was received from the other party  
SecurityContextException

## Cause

The issue occurs due to missing or incorrectly configured persistence settings on the load balancer, which can cause WCF failures when the web server attempts to read a token that was issued by a different web server.

## Resolution

Microsoft Dynamics 365 requires IP-based persistence to be configured on the load balancer.
