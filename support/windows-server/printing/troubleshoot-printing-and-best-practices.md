---
title: Troubleshoot printing and best practices
description: Overview of printing troubleshooting and best practices.
ms.date: 45286
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:errors-and-troubleshooting-general-issues, csstroubleshoot
---
# Troubleshoot printing problem and printing best practices

When you troubleshoot printing problems, you can often determine the process that created the problem by testing different scenarios. Successful troubleshooting depends on your ability to identify the source of the problem. Printing problems are typically caused by the following items:

- The printing device
- The network connection to the printer
- The network, protocols, and other communication components
- Other printing components in Windows

## Troubleshooting checklist

Here's a list of basic steps to resolve most printing problems:

- Verify that the physical printer is operational. If other users can print, the cause is probably not the device or the print server.
- Verify that the printer on the print server is using the correct printer driver. If print clients are using other operating systems, make sure that you installed all necessary drivers for the other platforms.
- Verify the following:
  - The print server is operational.
  - There is sufficient disk space for spooling.
  - The print spool service is running.
- Verify that the client computer has the correct printer driver.
- Check whether the physical printer is in the ready state (ready to print). Most printers can print a test page to confirm correct operation.
- Check whether the printer data cable is connected correctly. If the printer is connected directly to the network by using a network adapter, check the status of the light on the card that indicates network connectivity.
- Make sure that you can communicate with the printer over the network. For example, if the printer communicates over the TCP/IP protocol, you can use the ping command to verify connectivity.
- Verify communication to the print server from other computers.
- Check whether any service that's required for the printer and the client that's submitting the print job is working correctly.
- Verify that the print spool service is running on the print server.

The modularity of the printing architecture makes diagnosing problems fairly easy. By testing each process, you can generally identify the problem. Follow the steps for each process that applies.

- The administrator adds a printer and shares it.

    1. Check the property of the logical printer. Make sure that the driver is correct for that printer.
    1. Use the **Add Printer Wizard** to add another logical printer for the same physical printer. By doing this, you can quickly identify whether the problem is the logical printer.
    1. Try to browse printer connections, or locate the printer port. If you can't do this, the problem might be the network connectivity.
    1. Verify that you are logged on as administrator, or as a member of the Administrator group.

- A network client connects to that share.

    1. Check the property of the logical printer on the client computer. Make sure that the driver is correct for that printer.
    1. Use the **Add Printer Wizard** to add another logical printer for the same physical printer. By doing this, you can quickly identify whether the problem is the logical printer.
    1. Check the user permissions to print to that printer, and check which Group Policy settings for printers are enabled.
    1. Try to browse printer connections. If you can't do this, the problem might be the network connectivity.

- The client application creates a print job.

    1. Check whether the document that the client is trying to print consists of text only or includes graphics. Check the printer driver and the fonts settings.
    1. Check whether there is a problem that affects the separator page selection.
    1. Try to reproduce the same print job from another client. If the job prints correctly from the other client, the problem is most likely not caused by this process.
    1. Check whether the client system sends the print job to the printer share on the print server.
    1. Check the network transport. For example, check the TCP/IP or NWLink status.
    1. Check other network components that are required to print.

## Printing best practices

- **Planning your printing environment**

    Consider the physical location of your users and their printing needs to determine the number and types of printers and print servers you need, and where to physically locate them.  
- **Using the search for printers utility**
  
    The fastest way to find and connect to a printer is by using the search for printers utility. Select **Start** > **Search** > **For Printers**, and then type the criteria for the printers you are searching for. For more information, see [Connect to a printer published in Active Directory](/previous-versions/windows/it-pro/windows-server-2003/cc783221(v=ws.10)).  
- **Installing extra printer drivers**

    If you share printers with clients other than Windows clients, install the required extra printer drivers for these clients.
- **Using the same guidelines that apply to any shared resource**

    Create a local \<printer_name\> users group that has the Print permission, and then put global groups in the local group.  
- **Removing Print permission from the default group Everyone**

    Alternatively, assign the Print permission to the built-in group users. This limits printer use to those users in the domain for which you have created accounts.  

- **Distributing the administrative load**
  
    If security is not a concern, assign the \<printer_name\> users group the Manage Documents or Manage Printers print permission.  

- **Maintaining physical security**

    Secure the printer in a locked room if it's used for printing confidential information. When printing confidential documents, you may want to set the paper source to manual so that the document will not print until the user is physically at the printer. Let only members of the administrators group manage the printer.  

- **Maintaining data security**

    To help mitigate client-to-server eavesdropping, consider deploying IPSec. For more information, see [Internet Protocol Security (IPSec)](/previous-versions/windows/it-pro/windows-server-2003/cc783420(v=ws.10)). To help mitigate server-to-print device document interception, deploy an IPv4 or IPv6-compatible printer. You can use a printer that provides password authentication (that is, the printer does not print until the user enters a password that was sent together with the print job). You can also print to a local printer.

- **Choosing a physical location for printing pools**
  
    For printing pools, put the printers close to one another so that users don't have to check separate locations for their printed documents.  

- **Managing printer traffic**

    Create multiple logical printers that have different schedules to reduce printer traffic during peak hours. Have users send any large documents, such as accounting reports, to a logical printer that is available only at night so that those documents wait until off-peak hours to be printed. 

- **Maintaining records**

    Carefully document information about the printers and the users who have the ability to administer them.  

- **Auditing printers**

    Use the audit feature to keep track of changes that are made by administrators who manage shared printers.  

- **Using network adapters**

    It's preferable to use printers that connect directly to the network through a network adapter instead of using a parallel port (LPT) printer that connects directly to print servers. A printer that's attached through a parallel port prints slower, and the parallel port requires considerably more CPU time.  

- **Using the printer troubleshooter**

    To solve problems quickly, use the printing troubleshooter. Also, you can use the networking (TCP/IP) troubleshooter for networking problems.  

- **Creating a custom folder for printers**

    To ease printer administration, create a custom folder for the printers and for the folders of any print server that you manage regularly. You can also create a shortcut for that folder on the desktop.
