---
title: Lync Mobile users cannot sign in after they update to client version 5.4
description: Describes an issue in Lync Mobile  that occurs because of certificate errors.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Lync Server 2013
ms.date: 03/31/2022
---

# Lync Mobile users cannot sign in after they update to client version 5.4

## Symptoms

After Lync users update to the latest Microsoft Lync Mobile 2013 client (5.4), they cannot sign in, and they receive the following error message:

**Can't verify the certificate from the server. Please contact your support team.**

Additionally, users may see the following entry or entries in the logs if the issue occurred on an iOS device: 

```AsciiDoc
2014-04-23 15:18:31.230 Lync[247:6975000] INFO TRANSPORT CHttpRequestProcessor.cpp/173:Received response of request(UcwaAutoDiscoveryRequest) with status = 0x22020002
2014-04-23 15:18:31.230 Lync[247:6975000] INFO TRANSPORT CHttpRequestProcessor.cpp/201:Request UcwaAutoDiscoveryRequest resulted in E_SslError (E2-2-2). The retry counter is: 0
2014-04-23 15:18:31.230 Lync[247:6975000] INFO TRANSPORT CHttpRequestProcessor.cpp/266:Sending event to main thread for request(0x13dede8)
2014-04-23 15:18:31.230 Lync[247:3b2ae18c] INFO APPLICATION CTransportRequestRetrialQueue.cpp/822:Req. completed, Stopping timer.
2014-04-23 15:18:31.230 Lync[247:3b2ae18c] ERROR APPLICATION CUcwaAutoDiscoveryGetUserUrlOperation.cpp/325:Request failed. Error - E_SslError (E2-2-2)
2014-04-23 15:18:31.351 Lync[247:3b2ae18c] INFO UI CMUIUtil.mm/409:Mapping error code = 0x22020002, context = , type = 201
2014-04-23 15:18:31.351 Lync[247:3b2ae18c] INFO UI CMUIUtil.mm/1722:Mapped error message is 'We can't verify the certificate from the server. Please contact your support team.
```

## Resolution

To resolve this issue, install your Enterprise Root CA Certificate on the iOS Device. You can do this manually or by using the [Apple Configurator](https://www.apple.com/support/business-education/apple-configurator/). 

## More Information

The cause of each message is slightly different, but both errors are caused by the inability to verify the authenticity of a certificate or certification authority.

For more information, go to the following Apple website: 
[Digital certificates - iOS Deployment Reference](https://help.apple.com/deployment/ios/#/apddb157952e)

Or, contact [Apple Enterprise Support](https://www.apple.com/support/enterprise/) for help with managing your iOS devices.

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).