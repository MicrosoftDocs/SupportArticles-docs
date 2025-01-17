---
title: Guidance for Troubleshooting DHCP Authorization Failures
description: Introduces general guidance for troubleshooting authorization failures related to DHCP.
ms.date: 01/17/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, shpune, rnitsch, 5x5dnd
ms.custom: sap:Network Connectivity and File Sharing\Dynamic Host Configuration Protocol (DHCP), csstroubleshoot
---
# Troubleshooting guide: DHCP authorization failures

This guide provides a detailed step-by-step process for diagnosing and resolving Dynamic Host Configuration Protocol (DHCP) authorization failures in an Active Directory (AD) environment.

## Symptoms

During the post-installation phase of the DHCP role on a server, you encounter the following error message:

> Authorizing DHCP server ….. Failed  
> The authorization of DHCP server failed with Error Code: 20070. The DHCP service could not contact Active Directory.

The DHCP console displays a left-pointing red arrow in the IPv4 section, indicating that the server isn't authorized.

:::image type="content" source="media/troubleshooting-guide-dhcp-authorization-failures/dhcp-console-showing-unauthorized-status.png " alt-text="Screenshot of the DHCP console showing an unauthorized status.":::

Event ID 1046 is logged in the System event logs, indicating that the DHCP server isn't authorized to lease IP addresses:

> The DHCP/BINL service on the local machine, belonging to the Windows Administrative domain &lt;domain&gt;, has determined that it is not authorized to start. It has stopped servicing clients.

:::image type="content" source="media/troubleshooting-guide-dhcp-authorization-failures/event-log-indicating-unauthorized-status.png" alt-text="Screenshot of the event log indicating an unauthorized status.":::

Manual attempts to authorize the DHCP server can also fail with the following error message:

> The specified domain either does not exist or could be contacted.

## DHCP authorization flow

DHCP authorization ensures that only authorized servers can operate within an AD domain. This mechanism prevents unauthorized servers from distributing IP addresses, which can cause network conflicts and security issues.

When a DHCP server is authorized, an entry is created in AD under the list of authorized servers. This behavior is accomplished through Lightweight Directory Access Protocol (LDAP) communications between the domain controller (DC) and the DHCP server. This list resides in the **Configuration** container of the AD schema.

:::image type="content" source=" media/troubleshooting-guide-dhcp-authorization-failures/entry-created-in-ad.png" alt-text="Screenshot showing the entry created in AD.":::

The DHCP server validates its authorization status in Active Directory Domain Services (AD DS) every hour using LDAP. If the server's IP address isn't found in this list, the server deauthorizes itself.

## Causes of authorization failures

- **Permission issues: The account used to authorize the server doesn't have sufficient privileges.
- Missing entries in AD: The entry for the DHCP server might be deleted from AD's **Configuration** container.
- Connectivity Issues:** Network or firewall problems prevent communication between the DC and the DHCP server.
- AD replication problems: Delays or issues can cause inconsistent entries, leading to duplicate or conflicting entries (for example, Conflict (CNF) objects) in AD's **Configuration** container. The DHCP server can't be authorized with these entries.

## Troubleshooting steps

### Step 1: Verify permissions

Use an Enterprise Administrator account to authorize the DHCP server. This account has sufficient permissions to make changes to AD.

### Step 2: Check the authorization status

Run one of the following commands to verify if the DHCP server's entry exists in the list of authorized servers in AD:

**PowerShell command:**

```powershell
Get-DhcpServerInDC
```

**Command Prompt command:**

```cmd
netsh dhcp show server
```

Alternatively, use **ADSI Edit** to connect to the **Configuration** partition and verify if the server appears there:

1. Open **adsiedit.msc** on the DC.
2. Connect to the **Configuration** container.
3. Navigate to **Configuration** > **Services** > **NetServices**.
4. Check if the DHCP server's name appears on the right pane.

### Step 3: Try manual authorization

If there's no existing entry for your server, follow these steps:

1. Open **DHCP Management Console**.
2. Right-click your DHCP server name.
3. Select **Authorize**.

If this fails, proceed further.

### Step 4: Verify the connectivity

Use the following tools to test the connectivity between the DHCP server and the DC:

- **Ping** command for basic network connectivity checks between both servers.
- **Test-NetConnection** command for TCP port 389 via PowerShell. For example:

  ```powershell
  Test-NetConnection -ComputerName <DC-IP> -Port 389
  ```

Verify LDAP ports (TCP/UDP 389) are open and functional. Review firewall settings to ensure these ports aren't blocked. Resolve detected connectivity issues accordingly.

Additionally, you can capture Wireshark traces to identify packet drops between the DC and the DHCP server.

### Step 5: Identify and resolve conflicting entries

1. Open **adsiedit.msc** and navigate to **Configuration** > **Services** > **NetServices**.

2. Look for entries with the CNF tag that include the server name. The CNF tag will be added under the attribute CN. For example:

   > cn &nbsp; &nbsp; &lt;fqdn&gt;CNF:ca69f501234

In this case, the CNF object needs to be deleted. We recommend that you take an AD backup and then delete this object. Once the object is deleted, you can reauthorize the DHCP server.

## Extra troubleshooting steps

When you manually try to authorize the server, it might work, but it fails again in a few days because its entry is deleted in AD. In such cases, it's important to understand why the entry keeps getting deleted in AD or who is deleting the entry from AD.

To find who deleted the entry from the DC for the DHCP server, you can enable auditing on the DC, which isn't enabled by default. Follow these steps to enable auditing:

### Enable auditing of AD changes

1. Open the **Group Policy Management console** on the DC or run **gpmc.msc**.

2. Navigate to **Domains** > *Domain_Name* > **Domain Controllers** > **Default Domain Controller Policy**.

3. Right-click and edit the **Default Domain Controller Policy**.

4. Navigate to: **Computer Configuration** > **Policies** > **Windows Settings** > **Advanced Audit Policy Configuration** > **Audit Policies** > **DS Access** > **Audit Directory Service Changes**. Enable **Success** and **Failure** attempts.

### Set up auditing within the "Configuration" container

1. Open **adsiedit.msc**.

2. Connect to the **Configuration** container.

3. Navigate to **Services** > **NetServices**.

4. Right-click and select **Properties**.

5. Go to the **Security** tab and select **Advanced**.

6. In the **Auditing** tab, select **Add**.

7. Add the **Everyone** group and enable auditing for:

   - **Write All Properties**
   - **Delete**
   - **Delete Subtree**

8. Apply the changes.

9. When the issue recurs, export the security event logs on the DC to identify who deleted or modified the DHCP entry.

See the following example of event deletion:

```output
A directory service object was deleted.

Subject:
    Security ID: <domain>\administrator
    Account Name: Administrator
    Account Domain: <domain>
    Logon ID: 0x35D447

Directory Service:
    Name: <url>
    Type: Active Directory Domain Services

Object:
    DN: CN=<fqdn>,CN=NetServices,CN=Services,CN=Configuration,DC=<domain>,DC=com
```

For more information, see [Configure auditing on the configuration container](/defender-for-identity/deploy/configure-windows-event-collection#configure-auditing-on-the-configuration-container).

## Data collection

Before contacting Microsoft support, you can gather information about your issue. 

Follow the steps provided in [Introduction to TroubleShootingScript toolset (TSS)](../../windows-client/windows-tss/introduction-to-troubleshootingscript-toolset-tss.md) to download and collect logs using the TSS tool. Then, use this command to enable log collection on the impacted computer.

```powershell
.\TSS.ps1 -Scenario NET_DHCPsrv
```
