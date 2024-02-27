---
title: Outlook for Mac crashes when Proxy Auto Configuration file used
description: Introduces how to fix an Outlook 2016 for Mac crash that occurs when a Proxy Auto Configuration file is configured.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
- CSSTroubleshoot
- CI 162524
appliesto:
- Outlook 2016 for Mac
search.appverid: MET150
ms.reviewer: sercast, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/30/2024
---
# Outlook 2016 for Mac crashes when a Proxy Auto Configuration file is used

## Symptoms

Consider the following scenario:

- You use Microsoft Outlook 2016 for Mac on a Mac computer that's configured to use a Proxy Auto Configuration (PAC) file.
- You try to access a remote resource by using the HTTP protocol.

In this scenario, Outlook 2016 for Mac crashes.

## Cause

This issue occurs when a file-based PAC file is used in the **Automatic Proxy Configuration** setting in Mac operating system.

> [!NOTE]
> A file-based PAC file is a file whose URL begins with ***file://***.

## Resolution

To resolve this problem, host the PAC file on a web server that can be accessed by using the HTTP protocol, and then specify the URL of the file in the **Automatic Proxy Configuration** setting of the **Advanced** **Network** preferences in Mac operating system.

To edit the Automatic Proxy Configuration settings in Mac operating system, follow these steps:

1. Open **System Preferences**.
2. Select **Network**.
3. Select **Advanced**.
4. Select the **Proxies** tab.
5. Under **Select a protocol to configure**, select **Automatic Proxy Configuration**.
6. Enter the URL of the hosted PAC file.

## More information

- Talk to support

  To report issues or provide feedback, go to **Help** > **Contact Support** in Outlook for Mac.

- Ask the community

  Get help from experts in the [Microsoft 365 and Office](https://answers.microsoft.com/msoffice/forum).

### Third-party information disclaimer

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft does not guarantee the accuracy of this third-party contact information.

The information and the solution in this document represents the current view of Microsoft Corporation on these issues as of the date of publication. This solution is available through Microsoft or through a third-party provider. Microsoft does not specifically recommend any third-party provider or third-party solution that this article might describe. There might also be other third-party providers or third-party solutions that this article does not describe. Because Microsoft must respond to changing market conditions, this information should not be interpreted to be a commitment by Microsoft. Microsoft cannot guarantee or endorse the accuracy of any information or of any solution that is presented by Microsoft or by any mentioned third-party provider.

Microsoft makes no warranties and excludes all representations, warranties, and conditions whether express, implied, or statutory. These include but are not limited to representations, warranties, or conditions of title, non-infringement, satisfactory condition, merchantability, and fitness for a particular purpose, regarding any service, solution, product, or any other materials or information. In no event will Microsoft be liable for any third-party solution that this article mentions.
