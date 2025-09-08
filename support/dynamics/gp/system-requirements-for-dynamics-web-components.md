---
title: System Requirements for Microsoft Dynamics Web Components
description: Describes the system Requirements for Microsoft Dynamics Web Components.
ms.reviewer: Theley, cwaswick
ms.date: 04/17/2025
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# System Requirements for Microsoft Dynamics Web Components

This article introduces the system Requirements for Microsoft Dynamics Web Components.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 3035914

This information is to be used along with the Microsoft Dynamics GP Web Components system requirements to properly determine the server specs for your Microsoft Dynamics GP Web Client and Service Based Architecture (SBA) deployment. To best determine the system requirements for a typical deployment of both the web client and service-based architecture on the same server, you need to understand how SBA requests are processed and the impact this has on the shared system resources. If you have a web client only deployment, use the web component system requirements as published. If you have a deployment that includes SBA, refer to the information below to determine your system requirements.

Microsoft Dynamics Service Based Architecture uses a Dexterity process on the session host server to process a request. A Dexterity process can handle a single concurrent request and can then be reused for subsequent requests. The Dexterity Service running on the session host creates and removes the Dexterity processes as needed based on incoming requests up to an administrator defined limit. So if, for example, five concurrent requests are received, the Dexterity Service would send the requests to any currently running processes that can handle the request and if there are more requests than processes it will create new processes up to the defined limit. By default this maximum number of processes limit is set to 30 by the installation. A single Dexterity process can complete up to 900 requests per hour depending on execution time per request.

In determining the system requirements for your web components deployment that includes SBA, you need to determine the number of concurrent SBA requests the system needs to process along with the total requests per hour. That information along with the total number of concurrent web client users is used to determine the recommended RAM on the server. For example, if you needed to process 2,700 requests per hour, you would need to set the maximum concurrent processes to at least 3. (that is, 2,700 requests/hour divided by 900 requests/process/hour) If you also needed to have 20 concurrent web client users, you would then need to have enough RAM to run 20 web client users and 3 Dexterity processes concurrently. There's a 2 to 1 ratio of RAM required for web client users to Dexterity processes. So if you had a 4-GB server, you would be able to get between 25 web client users with zero Dexterity processes or web client users with 50 Dexterity processes. In our example, we would determine that a server with 4 GB of RAM would be recommended using the calculation of 20 web client users plus 1.5 dexterity process equivalent web client users (three Dexterity processes divided by two Dexterity processes/web client user) for a total of 21.5 web client users.

Steps to change the maximum concurrent processes (Max Concurrent Processes) setting. Make sure you set this appropriately depending on the server's available RAM using the sizing guidance above. If you don't set appropriately, more processes could be started than the available RAM can support which could lead to poor performance or web client users not being able to create a new session.

1. Sign in to the Web Management Console.
2. Select **Dexterity Service Management** in the navigation list.
3. Select the Host Properties option in the ribbon at the top left of the page.
4. Change the Max Concurrent Processes to your calculated value for maximum concurrent processes.
