---
title: Exception when you configure BizTalk Server
description: Fixes a System.EnterpriseServices.TransactionProxyException issue in which you receive an error when you configure BizTalk Server. This issue occurs in BizTalk Server 2006, 2006 R2, 2009, or 2010.
ms.date: 03/06/2020
ms.custom: sap:BizTalk Server Setup and Configuration
---
# System.EnterpriseServices.TransactionProxyException was thrown when you configure BizTalk Server

This article provides information about resolving a `System.EnterpriseServices.TransactionProxyException` issue when you configure BizTalk Server.

_Original product version:_ &nbsp; BizTalk Server 2010, 2009, 2006 R2, 2006  
_Original KB number:_ &nbsp; 2556390

## Symptoms

When you configure BizTalk Server, the configuration fails. For example, a BizTalk group isn't created when you try to create a new BizTalk group. Additionally, you receive the following error message:

> Exception of type 'System.EnterpriseServices.TransactionProxyException' was thrown

## Cause

This issue occurs because of an error in the Microsoft Distributed Transaction Coordinator (MSDTC) connection between BizTalk Server and SQL Server.

This error can occur when the following situations occur:

- MS DTC service is configured incorrectly
- MS DTC Ports are not allowed in the Firewall rules

## Configure the MSDTC service

To resolve this issue, configure the MSDTC service correctly both on the computer that is running BizTalk Server and on the computer that is running SQL Server, and open the DTC ports on your Firewall.

1. Open the MSDTC **Security Configuration** page.

   To do this in Windows Server 2003, follow these steps:

      1. Click **Start**, click **Run**, type **dcomcnfg**, and then click **OK** to start the **Component Services** management console.
      2. Expand **Component Services**, and then expand **Computers**.
      3. Right-click **My Computer**, and then click **Properties**.
      4. Click the **MSDTC** tab, and then click **Security Configuration** to display the **Security Configuration** page.
  
   To do this in Windows Vista, Windows Server 2008, Windows 7, and Windows Server 2008 R2, follow these steps:

      1. Click **Start**, click **Run**, type **dcomcnfg**, and then click **OK** to start the **Component Services** management console.
      2. Expand **Component Services**, and then expand **Computers**.
      3. Expand **My Computer**, expand **Distributed Transaction Coordinator**, right-click **Local DTC**, and then click **Properties**.
      4. Click the **Security** tab to display the **Security Configuration** page.

2. Configure the settings to the recommended values in the following table.

    |Configuration option|Default value|Recommended value|
    |---|---|---|
    |Network DTC Access|Disabled|Enabled|
    |Client and Administration|||
    |Allow Remote Clients|Disabled|Disabled|
    |Allow Remote Administration|Disabled|Disabled|
    |Transaction Manager Communication|||
    |Allow Inbound|Disabled|Enabled|
    |Allow Outbound|Disabled|Enabled|
    |Mutual Authentication Required|Enabled|Enabled if all remote machines are running Windows Server 2003 Service Pack 1 (SP1), Windows XP Service Pack 2 (SP2), or a later Windows XP service pack, and if the **Mutual Authentication Required** option is enabled on all remote machines.
    |Incoming Caller Authentication Required|Disabled|Enabled if MSDTC is running on a cluster.|
    |No Authentication Required|Disabled|Enabled if remote machines are pre-Windows Server 2003 SP1 or pre-Windows XP SP2.|
    |Enable TIP|Disabled|Enabled if you run the BAM Portal.|
    |Enable XA Transactions|Disabled|Enabled if you create connections to an XA-based transactional system. For example, you create connections to IBM WebSphere MQ by using the MQSeries adapter.|

      After you configure the properties page, the properties page settings resemble the settings in the following image.

    :::image type="content" source="media/cannot-configure-biztalk-server/local-dtc-property-setting.png" alt-text="Screenshot of local D T C properties settings." border="false":::

3. Save the configurations, and then wait for the MSDTC service to restart.

## Open the MS DTC ports in your Firewall

- [Ports for the Administration Server](https://go.microsoft.com/fwlink/p/?linkid=275568)

- [How to Install BizTalk Server 2010 in a Basic Multi-Computer Environment](/archive/technet-wiki/6845.how-to-install-biztalk-server-2010-in-a-basic-multi-computer-environment)

## More information

For more information about this issue, visit the following Microsoft websites:

- [Troubleshooting problems in MSDTC](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc753620(v=ws.10))

- [Enable Network Access Securely for MS DTC](/biztalk/core/troubleshooting-problems-with-msdtc)
