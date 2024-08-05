---
title: Standard port monitor for TCP/IP
description: Describes how the standard port monitor works in Windows Server 2003 and compares it with the LPR port monitor.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-dgit
ms.custom: sap:Print, Fax, and Scan\Print Configuration or Management, csstroubleshoot
---
# The standard port monitor for TCP/IP

This article describes how the standard port monitor works in Microsoft Windows Server 2003 and compares it with the LPR port monitor.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 814586

## Summary

This step-by-step article describes how to install the standard port monitor. The standard port monitor connects clients to network printers that use the TCP/IP protocol.

Microsoft Windows Server 2003 offers the standard port monitor for network print devices as an alternative to the Line Printer Remote (LPR) port monitor. The standard port monitor was introduced in Microsoft Windows 2000. In Windows Server 2003, the standard port monitor has been updated to provide better performance and more detailed device status.

The standard port monitor uses Simple Network Management Protocol (SNMP) to read the configuration of the target print device and to determine the device's detailed status. Additionally, the standard port monitor offers more accurate error reporting than the limited print error messages that are enabled by other port monitors, such as the LPR port monitor. For example, the standard port monitor supports a "paper out" error.

If the standard port monitor cannot use the default TCP ports to configure the target print device and SNMP, the standard port monitor uses the LPR protocol. (The target device must support the LPR protocol.)

> [!NOTE]
> The default TCP destination port is 9100. The default TCP source port is a randomly selected open port that is greater than 1023.

You can use a Web-based interface from any Internet-connected client to view the status of standard port monitor events.

## Install the standard port monitor

1. Click **Start**, and then click **Printers and Faxes**.
2. Double-click **Add Printer**.
3. When the Add New Printer Wizard starts, click **Next**.
4. Select the type of printer that you want to set up, and then click **Next**.
5. Click **Create a new port**, click **Standard TCP/IP Port** in the **Type of port** list, and then click **Next**.
6. Follow the instructions that appear on the screen to complete the Add Standard TCP/IP Printer Port Wizard. As you continue, the standard port monitor queries the print device and tries to configure it based on SNMP responses. If the printer model and the printer options are determined by using SNMP, you do not have to select the printer. The printer is automatically configured.

## More information

For network-connected print devices, the standard port monitor is the optimal choice. In comparison with the LPR port monitor, the standard of choice in network printing for the past several years, the standard port monitor is faster, more scalable, and has bidirectional capability. By contrast, the LPR port monitor is limited in all these areas.

The standard port monitor uses either the RAW or the LPR printing protocols to send documents to a printer. Together, these protocols support most current TCP/IP printers. Do not confuse these print protocols with transport protocols, such as TCP/IP or Data Link Control (DLC).

By default, the standard port monitor deviates from the LPR port monitor in two ways:  

- The standard port monitor does not comply with the RFC 1179 requirement that the source TCP port lie between port 721 and port 731. Standard port monitor uses ports from the general, unreserved pool of ports. This pool includes ports 1024 and greater.
- The LPR port monitor requires that print jobs include information about the size of print jobs. When you send a print job with job size information, the port monitor must spool the job two times, one time to determine size and one time to send the job to the spooler. Printing performance improves if the job is spooled only one time. Therefore, standard port monitor sends the job to the spooler without determining the actual job size. Standard port monitor claims the job is a default size, regardless of the job's actual size. The following table compares the standard port monitor to the LPR port monitor:

|LPR (RFC 1179 compliant)|standard port monitor|
|---|---|
|Limited to 721-731 source ports.|Source ports from ephemeral ports. (9100 is the default port.)|
|Four-minute time-out per port 3.|No source port time-out.|
|Unidirectional, single-error status reporting.|Uses SNMP for detailed status and error reporting.|
|Control file requires double spooling for accurate byte count.|Enables single-file spooling by default. (This is configurable through port properties.)|
|Prints to destination port 515.|Prints to destination port 515 in LPR mode.|
