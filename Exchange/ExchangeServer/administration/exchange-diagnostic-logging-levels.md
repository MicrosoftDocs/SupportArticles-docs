---
title: Exchange server diagnostic logging levels
description: This article introduces the Exchange server diagnostic logging levels that you can use to control the amount of the saved information.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Server 2003 Enterprise Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Exchange server diagnostic logging levels

_Original KB number:_ &nbsp; 555232

One of the features that can be used to troubleshoot Microsoft Exchange server is diagnostic logging. Diagnostic logging saves information in the application log, the amount of information logged is controlled by the logging level defined.

## More information

The amount of information saved by diagnostic logging is controlled by the logging level defined. To define the logging level (and diagnostic logging), a system administrator can use the **Diagnostic Logging** tab on the Exchange servers properties.

The user interface provides the following levels of logging:

- **None:** By default the logging level for all objects is set to none. At this level, only errors and critical events are logged. This should be the level set when everything is running correctly.

- **Minimum:** Differs from None by adding informational and warning events to the data collected.

- **Medium:** A higher level of logging than Minimum, it should be used if the information provided by Minimum is not enough.

- **Maximum:** Specifies the highest logging level that can be configured using Exchange System Manager.

    When configuring the logging level using Exchange System Manager, the registry is changed.

    Each component that is changed has a registry key and value that is changed based on the change made by the Exchange System Manager:

    **Key:** `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\<component>\Diagnostics`  
    **Value:** \<component>  
    **Data:**  
    0 is none.  
    1 is minimum.  
    3 is medium.  
    5 is maximum.

- **Field Engineering:** The highest level of diagnostic logging that can be set by using the Exchange System Manager is Maximum (5). In some cases, the data provided by the Maximum (5) level is not enough. A higher level of diagnostic logging that is called Field Engineering (7) can be employed. This is the highest level of logging and it will provide very large amounts of information.

    To set the logging level to Field Engineering (7), the registry has to be edited and the keys specified above must be set to 7.

> [!WARNING]
> Diagnostic logging saves data to the Application log. The log should be carefully monitored since it can fill and/or cause performance degradation on the server monitored.
