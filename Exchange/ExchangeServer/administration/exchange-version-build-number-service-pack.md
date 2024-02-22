---
title: Determine version number and service pack
description: Provides information about how to determine the version number, the build number, and the service pack level of Exchange Server through viewing server properties.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CI 119623
  - CSSTroubleshoot
ms.reviewer: pattim, v-six
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server
ms.date: 01/24/2024
---
# How to determine the version number, the build number, and the service pack level of Exchange Server

_Original KB number:_ &nbsp; 152439

## View server properties for Exchange Server 2010 or 2007

You can view the server properties of a computer that is running Exchange Server 2010 or Exchange Server 2007 in the Exchange Management shell or in the Exchange Management console.

To view the server properties in the Exchange Management console, follow these steps:

1. Start the Microsoft Exchange Management console.
2. In the navigation pane, expand the **Server Configuration** objects until you locate the server object, and then select the server object.
3. On the right side, notice the Exchange version number.
To view the server properties in the Exchange Management shell, follow these steps:

    1. Start the Microsoft Exchange Management shell.
    2. Run the following command at the command line:

        ```powershell
        get-exchangeserver
        ```

## View server properties for earlier versions of Exchange Server

To view the server properties of a computer that is running Exchange Server 4.0, Exchange Server 5.0, or Exchange Server 5.5, follow these steps:

1. Start the Microsoft Exchange Administrator program.
2. In the navigation pane, expand the objects until you locate the server object, and then click the server object.
3. On the **File** menu, click **Properties**.

To view the server properties of a computer that is running Exchange 2000 Server or Exchange Server 2003, follow these steps:

1. Start the Microsoft Exchange Administrator program.
2. In the navigation pane, expand the objects until you locate the server object.
3. Right-click the server object, and then click **Properties**.
