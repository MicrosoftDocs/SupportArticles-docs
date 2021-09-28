---
title: Troubleshoot printing and best practices
description: Overview of printing troubleshooting and best practices.
ms.date: 27/09/2021
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:management-and-configuration-installing-print-drivers, csstroubleshoot
ms.technology: windows-server-printing
---
# Troubleshoot printing and best practices

When solving printing problems, a good first step is to identify the process creating the problem. You can often determine it by testing different scenarios. Successful troubleshooting depends on your ability to identify the source of the problem. Printing problems occur because of trouble with:

- The printing device
- The connection between the printer and the network
- The network, protocols, and other communication components
- Other printing components in Windows

## Troubleshooting checklist

A quick way to solve most problems associated with printing is to follow these steps:

- Verify the physical printer is operational. If other users can print, it is probably not a problem with the printer, or with the print server.
- Verify that the printer on the print server is using the correct printer driver. If print clients are using other operating systems, make sure you installed all necessary drivers for the other platforms.
- Verify the print server is operational, make sure there is enough disk space for spooling, and make sure the print spool service is running.
- Verify the client computer has the correct printer driver.
- Check the physical printer and make sure it is in the ready state (ready to print). With most printers, you can print a test page from the printer console itself to verify correct operation.
- Check the cable connecting the printer and make sure it is connected properly. If the printer is connected directly to the network with a network adapter, check the light on the card, which indicates network connectivity.
- Make sure you can communicate with the printer over the network. As an example, if a printer communicates over the TCP/IP protocol, you can use the ping command to verify connectivity.
- Verify communication to the print server from other computers.
- Check that any service required for the printer and the client submitting the print job is working properly.
- Make sure the print spool service is running on the print server.

The modularity of the printing architecture makes diagnosing problems fairly easy. By testing each process, you can generally identify the problem.

- The administrator adds a printer and shares it.

    1. Check the property of the logical printer; make sure the driver is correct for that printer.
    1. Using the Add Printer Wizard, you can add another logical printer for the same physical printer to quickly identify whether the problem is with the logical printer.
    1. If you can't browse printer connections, or can't find the printer port, you might have a network problem.
    1. Verify you are logged on as administrator, or as a member of the administrator group.

- A network client connects to that share.

    1. Check the property of the logical printer on the client computer; make sure the driver is correct for that printer.
    1. Using the Add Printer Wizard, you can add another logical printer for the same physical printer to quickly identify whether the problem is with the logical printer.
    1. Check the users' permissions to print to that printer, and check which Group Policy settings for printers are enabled.
    1. If you can't browse printer connections, you might have a network problem.

- The client application creates a print job.

    1. Check whether the document the client is trying to print consists of text only or includes graphics. Check the printer driver and the fonts settings.
    1. Check whether there is a problem with the separator page selection.
    1. Try to reproduce the same print job from another client; if it prints properly, the problem is most likely not caused by this process.
    1. The client system sends the print job to the printer share on the print server.
    1. Check the network transport; for example, TCP/IP or NWLink.
    1. Check other network components that are required to print.

## Printing best practices

- Planning your printing environment.

    Consider the physical location of your users and their printing needs to determine the number and types of printers and print servers you need, and where to physically locate them.  
- Using the search for printers utility.
  
    The best and fastest way to find and connect to a printer is by using the search for printers utility. From the Start menu select **Search**, then select **For Printers**, and then type the criteria for the printers you are searching for. For more information, see [Connect to a printer published in Active Directory](/previous-versions/windows/it-pro/windows-server-2003/cc783221(v=ws.10)).  
- Installing extra printer drivers.

    If you share printers with clients other than Windows clients, install the required extra printer drivers for these clients.
- Using the same guidelines that apply to any shared resource.

    Create a local *printer\_name* Users group with print permission, and then put global groups in the local group.  
- Removing Print permission from the default group Everyone.

    Instead, assign the Print permission to the built-in group Users. This limits printer use to those users in the domain for which you have created accounts.  

- Distributing the administrative load.
  
    If security is not an issue, assign the *printer\_name* Users group the Manage Documents or Manage Printers print permission.  

- Maintaining physical security.

    Secure the printer in a locked room if it is used for printing confidential information. When printing confidential documents, you may want to set the paper source to manual so the document will not print until the user is physically at the printer. Let only members of the administrators group manage the printer.  

- Maintaining data security.

    To help mitigate client-to-server eavesdropping, consider deploying IPSec. For more information, see [Internet Protocol Security (IPSec)](/previous-versions/windows/it-pro/windows-server-2003/cc783420(v=ws.10)). To help mitigate server-to-print device document interception, deploy an IPv4 or IPv6-compatible printer. You can use a printer that provides password authentication (that is, the printer does not print until the user enters a password that was sent with the print job). You can also print to a local printer.  

- Choosing a physical location for printing pools.
  
    For printing pools, place the printers physically close to each other so users do not have to check separate locations for their printed documents.  

- Managing printer traffic.

    Create multiple logical printers with different schedules to reduce printer traffic during peak hours. Have users send large documents, such as accounting reports, to a logical printer that is available only at night so that those documents wait until off-peak hours to be printed.  

- Maintaining records.

    Document information about printers and the users who have the ability to administer them.  

- Auditing printers.

    Use the audit feature to keep track of changes made by administrators who manage shared printers.  

- Using network adapters.

    It is better to use printers that connect directly to the network with a network adapter than to use a parallel port (LPT) printer that connects directly to print servers. A printer attached with a parallel port prints slower, and the parallel port requires considerably more CPU time.  

- Using the printer troubleshooter.

    To solve problems quickly, use the printing troubleshooter. Also, you can use the networking (TCP/IP) troubleshooter for networking problems.  

- Creating a custom folder for printers.

    To ease printer administration, create a custom folder for the printers and for the folders of any print server you manage regularly. You can also create a shortcut for that folder on the Desktop.
