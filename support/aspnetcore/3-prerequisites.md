---
title: Getting ready for troubleshooting prerequisites
description: This article is the prerequisite for part 3.
ms.date: 03/18/2021
ms.topic: include
ms.prod: aspnet-core
ms.reviewer: ramakoni
---

**Prerequisites**

As in the [previous parts](2-1-create-configure-aspnet-core-applications.md), this part is structured to put more emphasis on the theory and principals to follow when you start to troubleshoot. It does not have any prerequisites. However, you should have following items already set up if you followed all the steps of this training so far:

- Nginx has two websites:
  - The first website listens for requests by using the **myfirstwebsite** host header (`http://myfirstwebsite`), and routes the requests to the demo ASP.NET Core application that is listening on port 5000.
  - The second website listens for requests by using the **buggyamb** (`http://buggyamb`) host header, and routes the requests to the second ASP.NET Core sample buggy application that is listening on port 5001.
- Both ASP.NET Core applications are running as services that restart automatically when the server is rebooted, or the applications stops responding or fails.
- A Linux local firewall is enabled and configured to allow SSH and HTTP traffic.
