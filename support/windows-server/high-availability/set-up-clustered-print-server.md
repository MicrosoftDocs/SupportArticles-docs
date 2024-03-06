---
title: How to set up a clustered print server
description: Describes how to set up a clustered print server.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: eldenc, kaushika
ms.custom: sap:print-clusters-and-high-availability-printing, csstroubleshoot
---
# How to set up a clustered print server

This article describes the steps to set up a clustered print server.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 278455

## More information

You can use Windows Clustering to host print server functionality. The configuration steps in Microsoft Windows Server 2003 differ from those in Microsoft Windows NT Server 4.0, Enterprise Edition, Microsoft Windows 2000 Advanced Server, and Microsoft Windows 2000 Datacenter Server. To set up a clustered print server, you need to configure only the Spooler resource in Cluster Administrator and then connect to the virtual server to configure the ports and print queues. This is an improvement over previous versions of Windows Clustering in which you had to repeat the configuration steps on each node in the cluster.

### How to configure the spooler resource for the cluster

The first step in setting up a clustered printer server is to create a Spooler resource for the service on a clustered server. The appropriate resources need to be made available to the spooler service. To do this, create a Spooler resource in Cluster Administrator:

1. To open Cluster Administrator, click **Start**, click **Run**, type cluadmin, and then click **OK**.
2. Right-click in the left pane, and then click **Configure Application**.
3. At the Welcome screen, click **Next**, and then click **Next** again to create a new virtual server.
4. Click **Use an existing Resource Group**, and then click an existing group that has a Disk resource in which you want to store the spooler and printer drivers. Click **Next**.
5. For the resource group name, provide a name that accurately represents the group, such as "SPOOLER."

    > [!NOTE]
    > This name is for administrative purposes only in Cluster Administrator.
6. At the Virtual Server Access Information screen:

    1. Under Network Name, enter a NetBIOS name to which clients will connect. This is the NetBIOS virtual server name that is used by clients to access the printers:  
        \\\\**VirtualServer**\Printer
        > [!NOTE]
        > Microsoft recommends adhering to the 8.3-naming standard to assure compatibility with earlier versions of the client.
    1. Enter the IP address that clients will use to connect to this virtual print server. If the nodes of the cluster have Print Services for Unix installed and running, clients can connect using line printer remote (LPR) to this IP address.
7. Click **Next**.
8. At the Advanced Properties screen, you can make modifications to the resources that are about to be created, and then click **Next**.
9. At the Create a Resource for My Application screen, click **Next**.
10. Click **Print Spooler**, and then click **Next**.
11. Give the Spooler resource a name.

    > [!NOTE]
    > This name is for administrative purposes only in Cluster Administrator.
12. Set the dependencies for the Spooler resource:

    1. Click **Advanced Properties**, and on the **Dependencies** tab, click **Modify**.
    2. Double-click the Physical Disk resource on which you want the spooler files to be located, and the Network Name resource that you just created.
    3. Click **OK** twice.
13. Click **Next**.
14. Click **Finish** to complete the wizard.
15. Verify configuration and test failover:

    1. Right-click the spooler group, and then click **Bring Online**.
    2. Verify that all resources come online, and then check the event logs for errors.
    3. Right-click the spooler group, click **Move Group**, move the Spooler resource to each node in the cluster that is a possible owner, and then verify that all resources come online.

    > [!NOTE]
    > If you are setting up an active/active print server, you need to create one group for each node and you want to set each spooler group to have a different preferred owner. You cannot have multiple Spooler resources in the same group. An active/active print server configuration is one in which there are multiple nodes in the cluster that are processing print jobs for clients with multiple spoolers. This could include as many as two to four nodes that are actively handling requests.

When a single node is hosting multiple groups with print spoolers, you'll be able to browse all printers from all groups.

### How to create the printer queues

Now that you've properly configured the Spooler resource with the necessary resources, you can create all of the print queues for all of the physical printers. You can also use the Clustool utility from the Resource Kit to migrate previously existing printer queues on a server to a clustered server. After that, use the Print Migrate utility to migrate the printer drivers. For best results, avoid having multiple servers configured to communicate directly with the same printer.

1. From one of the nodes or a remote computer that has administrative permissions to the cluster click **Start**, click **Run**, type \\\\**VirtualServer** where **VirtualServer** is the name that is specified for the Network Name resource on which the Spooler resource is dependent.
2. Double-click the **Printers** folder.
3. Double-click **Add Printers** to open the Add Printer Wizard, and then click **Next**.
4. Select **Create a new port**, and then click **Next**.

    > [!NOTE]
    > TCP/IP ports are the only supported port type on a Windows Clustering. Use the **Standard TCP/IP Port** option unless the printing clients need RFC-compliant LPR ports. If this is the case, follow these steps:
    >
    > 1. In Control Panel, double-click **Add/Remove Programs**, and then click **Add/Remove Windows Components** to start the Windows Components Wizard.
    > 2. Under **Components**, scroll down and click to select the **Other Network File and Print Services** check box.
    > 3. Click **Details** to open the Other Network File and Print Services window, click to select the **Print Services for UNIX** check box, and then click **OK** to close the Other Network File and Print Services window.
    > 4. Click **Next** to continue with the Windows Components Wizard.

    When you complete the wizard, the LPR port will be available as a port type. By default, according to RFC 1179, LPR will use only 11 TCP ports.

5. Type the IP address of the network printer that you want to process the print jobs in the **Printer Name or IP Address** box.

    > [!NOTE]
    > Bi-directional printing can also be a problem when using LPR printing. Some printer drivers enable this option by default. When you create the LPR port and printer, disable the **Bi-directional printing** option. If this option is enabled, it may cause a printer to accept one or more print jobs, and then stop accepting jobs until the printer is physically reset.

    You no longer have to create a locally defined printer port configuration for each node. In Windows 2000 (and later) the port configuration is stored in the cluster registry and is therefore shared between all cluster nodes, under the following key:  
    `HKEY_Local_Machine\Cluster\Resources\%Spooler GUID%\Parameters\Monitors\`

6. Choose the appropriate driver for this printer, and then click **Next**.
7. Give the printer a unique name on the cluster server.
8. Choose a share name for the printer; this name must also be unique on this cluster. You don't want to have any other printers with the same share name on this cluster, even if they are in a different group and associated with a different Spooler resource. In the event of a failure, in an active/active configuration the same node in the cluster may own both spooler groups. If this occurs, printers that share a common name won't be available. Again, it's recommended to adhere to the 8.3-naming standard for compatibility with earlier versions.

    > [!NOTE]
    > The installation process then copies the printer driver files to the \\\\**VirtualServer**\print$ share. The printer drivers are copied to the %SystemRoot%\System32\Spool\Drivers\\**Spooler GUID**\Drivers folder of the node in the cluster that owns the Network Name resource for this virtual name. The drivers are also copied to the shared disk in the \PrinterDrivers folder.
9. Test the printing for this printer:

    After you add all the desired print queues, use Cluster Administrator to move the group that contains the Print Spooler resource to all other nodes. This copies the printer drivers from the \PrinterDrivers folder on the shared disk to the %SystemRoot%\System32\Spool\Drivers\%Spooler GUID%\Drivers folder on that node.

    > [!NOTE]
    > Printing is available immediately to clients when the queue has been created even though the drivers have not been copied to all other available nodes. It is not necessary to move the spooler group over to all other nodes immediately after creating the queues for the cluster to function. You can do this later when you can schedule a brief outage during which time you can take the Spooler resource offline.

When you set up a print cluster, you have to set the Quorum log size to a size that is large enough to comply with the number of printers that will be installed. You should increase the size of the reset quorum log when you increase the size of the Quorum log size. To help determine whether you have to increase the reset quorum log size value, verify the size of the Clusdb file. Each node includes a local copy of this file in the %SystemRoot%\Cluster folder. The size of the reset quorum log for the transactional log should be larger than the size of the Clusdb file for the cluster registry.

For example, if you have installed printers and the size of the Clusdb file is 6 megabytes (MB), you should increase the size of the reset quorum log to 8192 bytes (8 MB). By default, the size of the reset quorum log on Windows Server 2003 is 4 MB. You should increase the size of the reset quorum log in 64-KB increments. A good rule is to double the current size of the reset quorum log.
