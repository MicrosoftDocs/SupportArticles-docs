---
title: Microsoft Dynamics CRM Email Router Collector
description: This article describes the Microsoft Dynamics CRM Email Router Collector.
ms.reviewer: 
ms.topic: article 
ms.date: 
---
# Microsoft Dynamics CRM Email Router Collector

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2695996

## Summary

The diagnostic tool that described in this article can be used on the following versions of Windows:

- Windows Server 2003
- Windows Server 2008
- Windows Server 2008 R2

### Information that is collected

The following data can be collected by the Dynamics CRM Email Router diagnostic tool of the Microsoft Support Diagnostic Tool.

> [!NOTE]
> All file names in the data collection are prefaced with the name of the computer (**ComputerName**) on which the Microsoft Support Diagnostic Tool is run.

- Operating system information

    | Description| File Name |
    |---|---|
    |Operating system version information| **ComputerName** _ **DateRan**.htm|

- Microsoft Dynamics CRM installed software and hotfix information

    | Description| File Name |
    |---|---|
    |List of the installed Microsoft Dynamics CRM software and hotfixes| **ComputerName** _ **DateRan**.htm|

- Microsoft CRM Email Router registry key information

    | Description| File Name |
    |---|---|
    |List of various settings from the `HKLM:\Software\Microsoft\MSCRM Email` registry hive| **ComputerName** _ **DateRan**.htm|

- Microsoft CRM Email Router configuration file contents

    | Description| File Name |
    |---|---|
    |List of the values that are contained in the Microsoft.Crm.Tools.EmailAgent.xml and Microsoft.Crm.Tools.EmailAgent.SystemState.xml files| **ComputerName_DateRan.htm** |

- Profiles information

    | Description| File Name |
    |---|---|
    |List of the configuration profiles that are set up for the CRM Email Router by using the Microsoft.Crm.Tools.Email.Management application| **ComputerName_DateRan.htm** |

- Deployments information

    | Description| File Name |
    |---|---|
    |List of the email deployments that are configured by using the Microsoft.Crm.Tools.Email.Management application| **ComputerName_DateRan.htm** |

- Recipients information per deployment information

    | Description| File Name |
    |---|---|
    |List of the users, the queues, and the forward mailboxes that are configured for each deployment by using the Microsoft.Crm.Tools.Email.Management application| **ComputerName_DateRan.htm** |

- Microsoft CRM Email Router program file information

    | Description| File Name |
    |---|---|
    |List of all the program files that the Email Router application uses based on the installation location that is retrieved from the `HKLM:\Software\Microsoft\MSCRM Email` registry hive| **ComputerName_DateRan.htm** |

- Microsoft CRM files that are installed in the assembly cache

    | Description| File Name |
    |---|---|
    |List of all Microsoft Dynamics CRM files that are installed in the global assembly cache on the CRM Server| **ComputerName_DateRan.htm** |

- Windows Services list

    | Description| File Name |
    |---|---|
    |Detailed list of the Windows Services on the server that hosts the Microsoft Dynamics CRM Email Router application| **ComputerName_DateRan.htm** |

- Running processes

    | Description| File Name |
    |---|---|
    |Detailed list of all running processes on the server that hosts the Microsoft Dynamics CRM Email Router application| **ComputerName_DateRan.htm** |

- Application event logs

    | Description| File Name |
    |---|---|
    |Event log errors and warnings from the last seven days| **ComputerName_DateRan.htm** |

- TCP/IP settings

    | Description| File Name |
    |---|---|
    |List of TCP/IP registry keys and their values| **ComputerName_DateRan.htm** |

For more information, click the following article number to view the article in the Microsoft Knowledge Base: [Frequently asked questions about the Microsoft Support Diagnostic Tool (MSDT)](https://support.microsoft.com/help/926079).
