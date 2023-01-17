---
title: Configure load balancing to use session persistence
description: Describes how to ensure session persistence when you configure the load balancer in Microsoft Identity Manager.
ms.date: 08/18/2020
ms.reviewer: 
---
# Configure load balancing to use session persistence in Microsoft Identity Manager

When you configure load balancing for the Microsoft Identity Manager (MIM) Service component, it's important that you make sure that session persistence is maintained.

_Original product version:_ &nbsp; Microsoft Identity Manager 2016 SP1  
_Original KB number:_ &nbsp; 4492890

When a particular session is established, all requests that are made during that session must be sent to the same back-end server behind the load balancer.

## Configure load balancing to use session persistence

If session persistence to **MIM Portal and Service** isn't maintained, the following functionalities will fail:

- Approval response request submissions in the MIM Portal
- Self-service password reset (SSPR) registration in the MIM Password Registration Portal
- SSPR operations from the MIM Password Reset Portal or the MIM Windows Credential Provider Extension for SSPR (logon screen)

When you configure the load balancer for accessing the MIM Service, use source IP address persistence. Don't use HTTP cookie persistence. This is because Windows Communication Foundation (WCF) and SOAP clients don't use HTTP cookies or other HTTP headers for session management.

## HTTP user agents

There are different kinds of HTTP user agents, such as web browsers and SOAP clients.

Web browsers usually store HTTP cookies and send them together with the next request to the same server. HTTP cookies are used to remember stateful information for session management.

SOAP clients are another kind of HTTP user agent. They communicate to SOAP servers, and they don't use HTTP cookies or other HTTP headers for session management. In MIM, the SSPR Reset and Registration portals are SOAP clients. They communicate to the MIM Service (a SOAP server). And the web services infrastructure protocols that are used by MIM don't rely on cookies. Therefore, HTTP cookie-based persistence doesn't work in such a scenario.
