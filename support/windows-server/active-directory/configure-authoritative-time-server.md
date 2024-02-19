---
title: Configure an authoritative time
description: Explains how to configure the Windows Time service in Windows Server. Provides information about troubleshooting and Windows Time service synchronization.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:windows-time-service, csstroubleshoot
adobe-target: true
---
# How to configure an authoritative time server in Windows Server

This article describes how to configure the Windows Time service and troubleshoot when the Windows Time service doesn't work correctly.

_Applies to:_ &nbsp; Windows Server 2012 Standard, Windows Server 2012 Essentials  
_Original KB number:_ &nbsp; 816042

To configure an internal time server to synchronize with an external time source, use the following method:

To configure the PDC in the root of an Active Directory forest to synchronize with an external time source, follow these steps:

1. Change the server type to NTP. To do this, follow these steps:
   1. Select **Start** > **Run**, type *regedit*, and then select **OK**.
   2. Locate and then select the following registry subkey:  
      `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Parameters`

   3. In the pane on the right, right-click **Type**, and then select **Modify**.
   4. In **Edit Value**, type *NTP* in the **Value data** box, and then select **OK**.

2. Set `AnnounceFlags` to 5. To do this, follow these steps:
   1. Locate and then select the following registry subkey:
      `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Config`

   2. In the pane on the right, right-click **AnnounceFlags**, and then select **Modify**.
   3. In **Edit DWORD Value**, type *5* in the **Value data** box, and then select **OK**.

   > [!NOTE]
   >
   > - If an authoritative time server that is configured to use an `AnnounceFlag` value of **0x5** does not synchronize with an upstream time server, a client server may not correctly synchronize with the authoritative time server when the time synchronization between the authoritative time server and the upstream time server resumes. Therefore, if you have a poor network connection or other concerns that may cause time synchronization failure of the authoritative server to an upstream server, set the `AnnounceFlag` value to **0xA** instead of to **0x5**.
   > - If an authoritative time server that is configured to use an `AnnounceFlag` value of **0x5** and to synchronize with an upstream time server at a fixed interval that is specified in `SpecialPollInterval`, a client server may not correctly synchronize with the authoritative time server after the authoritative time server restarts. Therefore, if you configure your authoritative time server to synchronize with an upstream NTP server at a fixed interval that is specified in `SpecialPollInterval`, set the `AnnounceFlag` value to **0xA** instead of **0x5**.

3. Enable NTPServer. To do this, follow these steps:
   1. Locate and then select the following registry subkey:  
      `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpServer`

   2. In the pane on the right, right-click **Enabled**, and then select **Modify**.
   3. In **Edit DWORD Value**, type *1* in the **Value data** box, and then select **OK**.

   4. Specify the time sources. To do this, follow these steps:
      1. Locate and then click the following registry subkey:  
         `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Parameters`

      2. In the pane on the right, right-click **NtpServer**, and then select **Modify**.
      3. In **Edit Value**, type *Peers* in the **Value data** box, and then select **OK**.

         > [!NOTE]
         > **Peers** is a placeholder for a space-delimited list of peers from which your computer obtains time stamps. Each DNS name that is listed must be unique. You must append **,0x1** to the end of each DNS name. If you do not append **,0x1** to the end of each DNS name, the changes that you make in step 5 will not take effect.

4. Configure the time correction settings. To do this, follow these steps:
   1. Locate and then click the following registry subkey:
  `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Config`

   2. In the pane on the right, right-click **MaxPosPhaseCorrection**, and then select **Modify**.
   3. In **Edit DWORD Value**, click to select **Decimal** in the **Base** box.
   4. In **Edit DWORD Value**, type *TimeInSeconds* in the **Value data** box, and then select **OK**.

      > [!NOTE]
      > **TimeInSeconds** is a placeholder for a reasonable value, such as 1 hour (3600) or 30 minutes (1800). The value that you select will depend on the poll interval, network condition, and external time source.  
      > The default value of **MaxPosPhaseCorrection** is 48 hours in Windows Server 2008 R2 or later.

   5. Locate and then click the following registry subkey:  
      `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Config`

   6. In the pane on the right, right-click **MaxNegPhaseCorrection**, and then select **Modify**.
   7. In **Edit DWORD Value**, click to select **Decimal** in the **Base** box.
   8. In **Edit DWORD Value**, type *TimeInSeconds* in the **Value data** box, and then select **OK**.

      > [!NOTE]
      > **TimeInSeconds**  is a placeholder for a reasonable value, such as 1 hour (3600) or 30 minutes (1800). The value that you select will depend on the poll interval, network condition, and external time source.  
      > The default value of **MaxNegPhaseCorrection** is 48 hours in Windows Server 2008 R2 or later.

5. Close Registry Editor.
6. At the command prompt, type the following command to restart the Windows Time service, and then press Enter:

   ```cmd
   net stop w32time && net start w32time
   ```

## Troubleshooting

For the Windows Time service to function correctly, the networking infrastructure must function correctly. The most common problems that affect the Windows Time service include the following:

- There is a problem with TCP/IP connectivity, such as a dead gateway.
- The Name Resolution service is not working correctly.
- The network is experiencing high volume delays, especially when synchronization occurs over high-latency wide area network (WAN) links.
- The Windows Time service is trying to synchronize with inaccurate time sources.

We recommend that you use the Netdiag.exe utility to troubleshoot network-related issues. Netdiag.exe is part of the Windows Server 2003 Support Tools package. See Tools Help for a complete list of command-line parameters that you can use with Netdiag.exe. If your problem is still not solved, you can turn on the Windows Time service debug log. Because the debug log can contain very detailed information, we recommend that you contact Microsoft Customer Support Services when you turn on the Windows Time service debug log.

> [!NOTE]
> In special cases, charges that are ordinarily incurred for support calls may be canceled if a Microsoft Support Professional determines that a specific update will resolve your problem. The usual support costs will apply to additional support questions and issues that do not qualify for the specific update in question.

## More information

Windows Server includes W32Time, the Time Service tool that is required by the Kerberos authentication protocol. The Windows Time service makes sure that all computers in an organization that are running the Microsoft Windows 2000 Server operating system or later versions use a common time.

To guarantee appropriate common time usage, the Windows Time service uses a hierarchical relationship that controls authority, and the Windows Time service does not allow for loops. By default, Windows-based computers use the following hierarchy:

- All client desktop computers nominate the authenticating domain controller as their in-bound time partner.
- All member servers follow the same process that client desktop computers follow.
- All domain controllers in a domain nominate the primary domain controller (PDC) operations master as their in-bound time partner.
- All PDC operations masters follow the hierarchy of domains in the selection of their in-bound time partner.

In this hierarchy, the PDC operations master at the root of the forest becomes authoritative for the organization. We highly recommend that you configure the authoritative time server to obtain the time from a hardware source. When you configure the authoritative time server to sync with an Internet time source, there is no authentication. We also recommend that you reduce your time correction settings for your servers and stand-alone clients. These recommendations provide more accuracy and security to your domain.

## References

For more information about Windows Time service, see:

- [How to turn on debug logging in the Windows Time service](https://support.microsoft.com/help/816043)
- [How to configure the Windows Time service against a large time offset](https://support.microsoft.com/help/884776)

For more information about the Windows Time service, see [Windows Time Service (W32Time)](/windows-server/networking/windows-time-service/windows-time-service-top).
