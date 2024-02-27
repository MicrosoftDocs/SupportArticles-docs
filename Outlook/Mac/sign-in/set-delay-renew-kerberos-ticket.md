---
title: How to set Outlook 2016 for Mac to delay trying to renew a Kerberos ticket
description: Describes how to suppress credentials prompting when connecting with Kerberos authentication.
author: cloud-writer
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - Outlook for Mac
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: meerak
appliesto: 
  - Outlook 2016 for Mac
ms.date: 01/30/2024
---

# How to set Outlook 2016 for Mac to delay trying to renew a Kerberos ticket

## Summary

You can set Outlook 2016 for Mac to delay trying to renew a Kerberos ticket. This will prevent Outlook from prompting for credentials during the defined period. When Outlook is set with the delay and a Kerberos ticket is renewed, the program will use the new ticket and try to connect online.

> [!NOTE]
> The version of Outlook 2016 for Mac must be **15.35.170603** or later. 

Here's how to set the delay: 

1. Select **Finder **> **Applications **> **Utilities **> **Terminal**.    
2. Run the following command:

    **defaults write com.microsoft.Outlook WaitForKerberosIdentityTimeout \<timeout>**

    > [!NOTE]
    > The \<timeout> value represents the period before Outlook 2016 for Mac tries to renew a Kerberos ticket in seconds. You can set the value up to a maximum of 3,600 seconds (1 hour). But you can also set the value to 1,000,000, which represents infinity, causing Outlook to never try to renew a Kerberos ticket. See the following examples:
      -  120 = Delay of 2 minutes: 
**defaults write com.microsoft.Outlook WaitForKerberosIdentityTimeout 120**     
      -  3600 = Delay of 1 hour: 
**defaults write com.microsoft.Outlook WaitForKerberosIdentityTimeout 3600**     
      -  1000000 = Delaying infinity: 
**defaults write com.microsoft.Outlook WaitForKerberosIdentityTimeout 1000000**