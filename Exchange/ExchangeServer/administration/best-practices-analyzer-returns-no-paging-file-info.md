---
title: Warning when you run the Exchange 2010 Best Practices Analyzer
description: Describes an issue where a waning (The AutomaticManagedPagefile property is set to True) occurs when you run the Microsoft Exchange Best Practices Analyzer.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: nasira, exchblt, v-six
appliesto: 
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Warning message when you run the Exchange 2010 Best Practices Analyzer: The AutomaticManagedPagefile property is set to True

_Original KB number:_ &nbsp;2695093

## Symptoms

Consider the following scenario:

- You install Microsoft Exchange Server 2010 Service Pack 2 (SP2) or Exchange Server 2007 SP3.
- You enable the **Automatically manage paging file size for all drives** option in Windows Server.
- You run the Microsoft Exchange Best Practices Analyzer.

In this scenario, the Exchange Best Practices Analyzer returns no information about the paging file. Additionally, you may receive a warning message like this one:

> The AutomaticManagedPagefile property is set to True, if you want to retrieve page file settings, please set the AutomaticManagedPagefile property to False.

## Cause

This issue can occur if Windows Server is configured to automatically manage the size of the paging file.

## Workaround

To work around this issue, disable the **Automatically manage paging file size for all drives** option, and set the paging file to a custom size. To do this, follow these steps:

1. In Control Panel, click **System**.
2. Click **Advanced system settings**.
3. On the **Advanced** tab, under **Performance**, click **Settings**.
4. On the **Advanced** tab, under **Virtual memory**, click **Change**.
5. Click to clear the **Automatically manage paging file size for all drives** check box.
6. Click **Custom size**, and then enter the page file size in the **Initial size (MB)** and **Maximum size (MB)** fields, and then click **Set**.
    > [!NOTE]
    > We recommend that you set initial and maximum values to how much RAM is installed on the server plus 10 megabytes.
7. Click **OK** three times, and then click **Restart Now**.

## More information

After you disable the **Automatically manage paging file size for all drives** option, you may receive a warning message that resembles the following when you run the Best Practices Analyzer:

> Paging file size less than Physical Memory... Server: < **server_name** >
>
> The paging file size (**paging_file_size**) is less than the physical memory size (**amount_of_physical_memory**) plus 10 MB. It is recommended that the paging file size equal the physical memory size plus 10 MB.

You receive this message if you don't set a custom size for the paging file.

## References

For information about how to set the paging file size on a server that's running Exchange Server, see [Page File Size is Less than Physical Memory Size Plus 10 MB](/previous-versions/office/exchange-server-analyzer/cc431357(v=exchg.80)).