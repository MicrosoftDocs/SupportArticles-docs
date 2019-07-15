---
title: UCWA client cannot make a call or join a meeting after installing Skype for Business Server update 6.0.9319.537 
description: UCWA client cannot make a call or join a meeting after installing Skype for Business Server update 6.0.9319.537
author: TobyTu
manager: willchen
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: jimmyv
appliesto:
-  Skype for Business Server 2015
---

# UCWA client cannot make a call or join a meeting after installing Skype for Business Server update 6.0.9319.537 

## Symptoms

After you install the January 2019 cumulative update 6.0.9319.537 (CU8) for Microsoft Skype for Business Server 2015, the Unified Communications Web API (UCWA) applications (such as Skype for Business on Mac, a web application for UCWA, and Skype for Business mobile clients) can’t make a call or join a meeting.

## Cause

This issue occurs because new headers are introduced in CU8 for UCWA clients to identify the network location and third-party software that's installed on Skype for Business Server 2015, such as Telrex and Clarity Connect. The third-party software installs its own Microsoft SIP Processing Language (MSPL) scripts which evaluate the SIP messages. These scripts cannot parse the SIP request and the request times out.

## Workaround

We recommend that you contact the third-party software providers to update their configuration.

**Third-party information disclaimer**

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.
