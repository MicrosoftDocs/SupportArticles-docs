---
title: How to check SQL Server dynamic versus static ports
description: Check if an instance of the SQL Server database engine listens on a dynamic versus a static port using the SQL Server Configuration Manager.
ms.date: 02/23/2022
ms.reviewer: v-jayaramanp
ms.custom: sap:Connection Issues
---

# How to check if SQL Server is listening on a dynamic port or static port

This article discusses how to determine whether your Microsoft SQL Server named instance is listening on a dynamic port versus a static port. This information can be helpful when you troubleshoot different connection issues that are related to SQL Server.

By default, a SQL Server named instance is configured to listen on dynamic ports. It gets an available port from the operating system. You can also configure SQL Server named instances to start at a specific port. This is known as a static port. For more information about static and dynamic ports in the context of SQL Server, see [Static vs Dynamic Ports](/sql/tools/configuration-manager/tcp-ip-properties-ip-addresses-tab).

Use the following procedure to determine whether the SQL Server named instance is listening on a dynamic port versus a static port.

## Option 1: Use SQL Server Configuration Manager

1. In **SQL Server Configuration Manager**, expand **SQL Server Network Configuration**, expand **Protocols** for *instance name*, and then double-click **TCP/IP**.
1. In **TCP/IP Properties**, select **Protocol**.
1. Check the value in the **Listen All** setting. If it's set to **Yes**, go to step 4. If it's set to **No**, go to step 6.
1. Go to **IP Addresses**, and scroll to the bottom of the **TCP/IP Properties** page.
1. Check the values in **IP All**, and use the following table to determine whether the named instance is listening on a dynamic or static port.

    |TCP dynamic ports  |TCP port  |SQL Server instance using dynamic or static ports?  |
    |---------|---------|---------|
    |Blank     |       Blank  |     Dynamic ports    |
    | `<Number>`   |     Blank    |   Dynamic ports -   `<Number>` is the dynamic port that SQL Server is currently listening on    |
    |`<Number1>`   |      `<Number2>` |  Concurrently listening on a dynamic port `<Number1>` and a static port `<Number2>`      |
1. Switch to **IP Addresses**.
   Notice that several IP addresses appear in the format of *IP1*, *IP2*, up to *IP All*. One of these IP addresses is intended for the loopback adapter, *127.0.0.1*. More IP addresses appear for each IP address on the computer. (You will probably see both IP4 and IP6 addresses.) To check whether a specific IP address is configured for a dynamic versus static port, use the following table.

    |TCP dynamic ports  |TCP port  |SQL Server instance using dynamic or static ports?  |
    |---------|---------|---------|
    |Blank     |       Blank  |     Dynamic ports    |
    |`<Number>`   |     Blank    |   Dynamic ports -   `<Number>` is the dynamic port that SQL Server is currently listening on.    |
    |`<Number1>`   |      `<Number2>` |  Concurrently listening on a dynamic port `<Number1>` and a static port `<Number2>`      |

> [!NOTE]
> A value of **0** in **TCP dynamic ports** indicates that the named instance is currently not running and is configured for dynamic ports. After you start the instance, the value field will reflect the dynamic port that the instance is currently using.

## Option 2: Use PowerShell

1. Run the following script in the PowerShell ISE. The Console window displays all the relevant TCP/IP for all your SQL Server instances (SQL Server 2014 through SQL Server 2019) that are currently installed on the system.

    ```Powershell
    clear
    Write-Host "SQL Server 2019"
    Write-Host "====================="
    Get-ItemProperty  -Path "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL15.*\MSSQLServer\SuperSocketNetLib\Tcp" | Select-Object -Property Enabled, KeepAlive, ListenOnAllIps,@{label='ServerInstance';expression={$_.PSPath.Substring(74)}} |Format-Table -AutoSize
    Get-ItemProperty  -Path "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL15.*\MSSQLServer\SuperSocketNetLib\Tcp\IP*\" | Select-Object -Property TcpDynamicPorts,TcpPort,DisplayName, @{label='ServerInstance_and_IP';expression={$_.PSPath.Substring(74)}}, IpAddress |Format-Table -AutoSize
    
    Write-Host "SQL Server 2017"
    Write-Host "====================="
    Get-ItemProperty  -Path "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL14.*\MSSQLServer\SuperSocketNetLib\Tcp" | Select-Object -Property Enabled, KeepAlive, ListenOnAllIps,@{label='ServerInstance';expression={$_.PSPath.Substring(74)}} |Format-Table -AutoSize
    Get-ItemProperty  -Path "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL14.*\MSSQLServer\SuperSocketNetLib\Tcp\IP*\" | Select-Object -Property  TcpDynamicPorts,TcpPort, DisplayName, @{label='ServerInstance_and_IP';expression={$_.PSPath.Substring(74)}}, IpAddress |Format-Table -AutoSize
    
    Write-Host "SQL Server 2016"
    Write-Host "====================="
    Get-ItemProperty  -Path "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL13.*\MSSQLServer\SuperSocketNetLib\Tcp" | Select-Object -Property Enabled, KeepAlive, ListenOnAllIps,@{label='ServerInstance';expression={$_.PSPath.Substring(74)}} |Format-Table -AutoSize
    Get-ItemProperty  -Path "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL13.*\MSSQLServer\SuperSocketNetLib\Tcp\IP*\" | Select-Object -Property  TcpDynamicPorts,TcpPort, DisplayName, @{label='ServerInstance_and_IP';expression={$_.PSPath.Substring(74)}}, IpAddress |Format-Table -AutoSize
    
    Write-Host "SQL Server 2014"
    Write-Host "====================="
    Get-ItemProperty  -Path "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL12.*\MSSQLServer\SuperSocketNetLib\Tcp" | Select-Object -Property Enabled, KeepAlive, ListenOnAllIps,@{label='ServerInstance';expression={$_.PSPath.Substring(74)}} |Format-Table -AutoSize
    Get-ItemProperty  -Path "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL12.*\MSSQLServer\SuperSocketNetLib\Tcp\IP*\" | Select-Object -Property  TcpDynamicPorts,TcpPort, DisplayName, @{label='ServerInstance_and_IP';expression={$_.PSPath.Substring(74)}}, IpAddress |Format-Table -AutoSize
    ```
1. In the output, check the value in the **ListenOnAllIPs** column for your SQL Server instance (refer to the corresponding value in **ServerInstance** for that row). If the value is set to **1**, go to step 3. If it's set to **0**, go to step 4.
1. Scan the output for a row that has an **Any IP Address** entry in the **DisplayName** column for your instance, or check the values of **TcpDynamicPorts** and **TcpPort** for the row. Then use the following table to determine whether the named instance is listening on a dynamic or static port.

    |TCP dynamic ports  |TCP port  |SQL Server instance using dynamic or static ports?  |
    |---------|---------|---------|
    |Blank     |       Blank  |     Dynamic ports    |
    | `<Number>`   |     Blank    |   Dynamic ports -   `<Number>` is the dynamic port SQL is currently listening on    |
    |`<Number1>`   |      `<Number2>` |  Concurrently listening on a dynamic port `<Number1>` and a static port `<Number2>`      |
    
4. Notice that several IP addresses appear in the format of *IP1*, *IP2*, up to *IP All*. One of these IP addresses is intended for the loopback adapter, *127.0.0.1*. More IP addresses appear for each IP address on the computer. (You will probably see both IP4 and IP6 addresses.) To check whether a specific IP address is configured for a dynamic versus static port, use the following table.

    |TCP dynamic ports  |TCP port  |SQL Server instance using dynamic or static ports?  |
    |---------|---------|---------|
    |Blank     |       Blank  |     Dynamic ports    |
    |`<Number>`   |     Blank    |   Dynamic ports -   `<Number>` is the dynamic port that SQL Server is currently listening on.    |
    |`<Number1>`   |      `<Number2>` |  Concurrently listening on a dynamic port `<Number1>` and a static port `<Number2>`      |

> [!NOTE]
> A value of **0** in **TCP dynamic ports** indicates that the named instance is currently not running and is configured for dynamic ports. After you start the instance, the value field will reflect the dynamic port that the instance is currently using.

## See also

- [0400 Consistent Authentication Issue](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/0400-Consistent-Authentication-Issue).

- [Configure a Server to Listen on a Specific TCP Port](/sql/database-engine/configure-windows/configure-a-server-to-listen-on-a-specific-tcp-port)

- [TCP/IP Properties (IP Addresses Tab)](/sql/tools/configuration-manager/tcp-ip-properties-ip-addresses-tab?view=sql-server-ver15&preserve-view=true)
