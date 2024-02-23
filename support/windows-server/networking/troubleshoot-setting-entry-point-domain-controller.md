---
title: Troubleshoot setting the entry point domain controller
description: Learn how to troubleshoot issues related to the Set-DAEntryPointDC cmdlet.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, brianlic, jgerend, v-lianna
ms.custom: sap:remote-access-multisite, csstroubleshoot
ms.assetid: b12dd0e8-1d80-4d4b-bb45-586f19d17ef0
---
# Troubleshoot setting the entry point domain controller

This article contains troubleshooting information for issues related to the `Set-DAEntryPointDC` cmdlet. To confirm that the error you received is related to setting the entry point domain controller, check in the Windows Event log for the event ID 10065.

_Applies to:_ &nbsp; Windows Server 2022, Windows Server 2019, Windows Server 2016

## <a name="SaveGPOSettings"></a>Saving server GPO settings

**Error received**

An error occurred while saving Remote Access settings to GPO \<GPO_name\>.

To troubleshoot this error, see Saving server GPO settings.

## Remote Access isn't configured

**Error received**

Remote Access isn't configured on \<server_name\>. Specify the name of a server that belongs to a multisite deployment.

Or

Remote Access isn't configured on the server \<server_name\>. Specify a computer with DirectAccess enabled.

**Cause**

Remote Access isn't configured on the computer specified by the `ComputerName` parameter.

The `Set-DaEntryPointDC` cmdlet is available only on servers that are part of a configured multisite deployment.

**Solution**

Run the cmdlet and make sure to specify the `ComputerName` parameter with the name of the server that is already configured as part of the multisite deployment.

## Multisite isn't enabled

**Error received**

You must enable a multisite deployment before performing this operation. Use the `Enable-DAMultiSite` cmdlet to do this.

**Cause**

Multisite isn't enabled on the server specified by the `ComputerName` parameter.

The `Set-DaEntryPointDC` cmdlet is available only on servers that are part of a configured multisite deployment.

**Solution**

Run the cmdlet and make sure to specify the `ComputerName` parameter with the name of the server that is already configured as part of the multisite deployment.

## Entry point and domain controller not provided in cmdlet

The `Set-DaEntryPointDC` cmdlet enables you to change the domain controller that is associated with different entry points, for example, if a particular domain controller is no longer available. You can update a specific entry point to use a different domain controller, or you can update all entry points that use a specific domain controller to use a new domain controller. In the first case, you should use the `EntryPointName` parameter to specify which entry point should be updated. In the second case, you should use the `ExistingDC` parameter to specify which domain controller should be replaced. You can specify only one of these parameters.

**Error received**

No required parameters were specified. Provide the name of an entry point or an existing domain controller.

Or

Cmdlet `Set-DaEntryPointDC` is missing all required parameters.

**Cause**

The `EntryPointName` or `ExistingDC` parameters weren't specified, or both parameters were specified, for the `Set-DaEntryPointDC` cmdlet.

**Solution**

Run the cmdlet and make sure to specify either the `EntryPointName` parameter or the `ExistingDC` parameter.

## Could not locate domain controller

**Error received**

Unable to locate a new domain controller automatically. Retry later or verify domain controller settings.

**Cause**

The computer specified with the `ComputerName` parameter isn't reachable over RPC or the domain does not contain any available writable domain controllers.

**Solution**

Make sure that the remote computer is accessible over RPC and that there's a writable domain controller available for the domain. If a writable domain controller is available for the domain, you can also specify its name explicitly using the `NewDC` parameter.

## Could not connect to domain controller

### Issue 1

**Error received**

The domain controller \<domain_controller\> can't be reached. Check network connectivity and server availability.

**Cause**

The domain controller can't be reached. This occurs only when the administrator specifies a domain controller in the `NewDC` or `ExistingDC` parameters.

**Solution**

Make sure that the domain controller's name is spelled correctly. If you used a short name to specify the name, use the FQDN and try again.

### Issue 2

**Error received**

The domain controller \<domain_controller\> can't be contacted.

**Cause**

There may be a network issue that means the domain controller specified in the `NewDC` parameter, or any other existing domain controller in the configuration can't be reached.

**Solution**

Make sure that the domain controller's name is spelled correctly, make sure it exists, is running, is writable, and that there's a trust relationship between the domain controller and the domain.

### Issue 3

**Error received**

Domain controller \<domain_controller\> can't be reached for %2!s!.

**Cause**

To maintain the configuration consistency in a multisite deployment, it is important to make sure that each GPO is managed by a single domain controller. When the domain controller that manages an entry point's server GPO isn't available, Remote Access configuration settings can't be read or modified.

**Solution**

Follow the procedure "To change the domain controller that manages server GPOs" described in [2.4. Configure GPOs](/windows-server/remote/remote-access/ras/multisite/configure/step-2-configure-the-multisite-infrastructure#ChangeDC).

### Issue 4

**Error received**

The primary domain controller in domain \<domain_name\> can't be reached.

**Cause**

To maintain the configuration consistency in a multisite deployment, it is important to make sure that each GPO is managed by a single domain controller. Client GPOs are managed on the primary domain controller. If the primary domain controller isn't available, Remote Access configuration settings can't be read or modified.

**Solution**

Follow the procedure "To transfer the PDC emulator role" described in [2.4. Configure GPOs](/windows-server/remote/remote-access/ras/multisite/configure/step-2-configure-the-multisite-infrastructure#TransferPDC).

## Read-only domain controller

**Error received**

The domain controller \<domain_controller\> is read-only. Specify a domain controller that isn't read-only.

**Cause**

The domain controller specified with the `NewDC` parameter is read-only.

**Solution**

When using the `Set-DAEntryPointDC`, the `NewDC` parameter is used to update the domain controller associated with a particular entry point, or to update all entry points associated with a domain controller. Therefore, the new domain controller must be writable. Specify a writable domain controller in the `NewDC` parameter and try again.

## Cannot retrieve GPO

### Issue 1

**Error received**

GPO \<GPO_name\> on domain controller \<previous_domain_controller\> can't be retrieved from domain controller \<replacement_domain_controller\> because they are not in the same domain.

**Cause**

The Remote Access server and the domain controller are not in the same domain; therefore, the GPO can't be retrieved.

**Solution**

If you tried to update a specific entry point, make sure that the new domain controller is in the same domain as the entry point server. If you tried to update a specific domain controller, make sure that the new domain controller is in the same domain as the one you are trying to replace.

### Issue 2

**Error received**

GPO \<GPO_name\> on domain controller \<previous_domain_controller\> can't be retrieved from domain controller \<replacement_domain_controller\>. Wait until domain replication completes and then try again.

**Cause**

When trying to update an entry point domain controller, the cmdlet tries to read the server GPO from the new domain controller; however, the GPO can't be found on the new domain controller because it has not yet replicated.

**Solution**

The server GPO does not exist on the new domain controller. Make sure that the GPOs have replicated successfully to the new domain controller and try again.

### Issue 3

**Error received**

You do not have permissions to access GPO \<GPO_name\>.

**Cause**

When trying to update an entry point domain controller, the cmdlet tries to read the server GPO from the new domain controller; however, the GPO can't be read on the new domain controller because you do not have the correct permissions.

**Solution**

The GPO exists on the domain controller, but it can't be read. Make sure that you have the required permissions and try again.

## Entry point not part of multisite deployment

**Error received**

Entry point \<entry_point_name\> isn't part of the multisite deployment. Specify an alternate value.

**Cause**

The entry point name you specified was not found.

**Solution**

Make sure that the entry point name is spelled correctly and that GPOs are replicated to the required domain controllers, and then try again. To view the assigned domain controller for each entry point, use `Get-DAEntryPointDC`.

## Remote Access server settings

### Issue 1

**Error received**

Server \<server_name\> in entry point \<entry_point_name\> can't be accessed.

**Cause**

When trying to update an entry point domain controller, the cmdlet tries to read and write the entry point domain controller from all relevant Remote Access servers. The cmdlet was not able to read the data from one or more Remote Access servers.

**Solution**

Make sure that all relevant Remote Access servers are running and that you have local administrator permissions on all of them and then try again.

### Issue 2

**Error received**

Settings can't be saved to the registry on server <server_name> in entry point <entry_point_name>.

**Cause**

When trying to update an entry point domain controller, the cmdlet tries to read and write the entry point domain controller from all relevant Remote Access servers. The cmdlet was not able to write the data to one or more Remote Access servers.

**Solution**

Make sure that all relevant Remote Access servers are running and that you have local administrator permissions on all of them and then try again.

### Issue 3

**Error received**

GPO updates can't be applied on \<server_name\>. Changes will not take effect until the next policy refresh.

**Cause**

When using the cmdlet `Set-DAEntryPointDC`, the `ComputerName` parameter specified is a Remote Access server in an entry point other than the last one added to the Multisite deployment.

**Solution**

Any servers that weren't updated can be seen using the **Configuration Status** in the **DASHBOARD** of the Remote Access Management Console. This does not cause any functional problems; however, you can run `gpupdate /force` on any servers that weren't updated to get the configuration status updated immediately.

## Problem resolving FQDN

**Error received**

Server \<server_name\> in entry point \<entry_point_name\> can't be accessed.

**Cause**

While getting the list of DirectAccess servers to modify, the cmdlet was not able to resolve the fully qualified domain name (FQDN) of one of the servers from its computer SID.

**Solution**

The entry point specified in the error message is associated with a domain controller. Make sure that the domain controller is available for the entry point. If the computer to which the specified SID belongs was removed from the domain, ignore this message and then remove the server from the multisite deployment.

## No entry points to update

**Warning received**

Domain controller settings weren't modified. If you think changes are required, ensure that cmdlet parameters are configured correctly, and that GPOs are replicated to the required domain controllers.

**Cause**

When calling the `Set-DaEntryPointDC` cmdlet with the `ExistingDC` parameter, DirectAccess checks all the entry points and updates the entry points that are associated with the specified domain controller. However, no entry point uses the specified `ExistingDC`.

**Solution**

To see the list of entry points and their associated domain controllers, use the `Get-DAEntryPointDC` cmdlet. If changes should have been made, make sure that the cmdlet parameters are spelled correctly, and that the GPOs are replicated to the required domain controllers, and then try again.
