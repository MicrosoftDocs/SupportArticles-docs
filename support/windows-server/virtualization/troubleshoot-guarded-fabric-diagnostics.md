---
title: Troubleshoot using the Guarded Fabric Diagnostic Tool
description: Provides information about troubleshooting using the Guarded Fabric Diagnostic Tool.
ms.date: 11/16/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, dongill, inhenkel, v-lianna
ms.custom: sap:shielded-virtual-machines, csstroubleshoot
ms.subservice: hyper-v
ms.assetid: 07691d5b-046c-45ea-8570-a0a85c3f2d22
---
# Troubleshoot using the Guarded Fabric Diagnostic Tool

This article describes the use of the Guarded Fabric Diagnostic Tool to identify and remediate common failures in the deployment, configuration, and on-going operation of guarded fabric infrastructure. This includes the Host Guardian Service (HGS), all guarded hosts, and supporting services such as DNS and Active Directory.

_Applies to:_ &nbsp; Windows Server 2022, Windows Server 2019, Windows Server 2016

The diagnostic tool can be used to perform a first-pass at triaging a failing guarded fabric, providing administrators with a starting point for resolving outages and identifying misconfigured assets. The tool isn't a replacement for a sound grasp of operating a guarded fabric and only serves to rapidly verify the most common issues encountered during day-to-day operations.

Full documentation of the cmdlets used in this article can be found in the [HgsDiagnostics module reference](/powershell/module/hgsdiagnostics/).

> [!NOTE]
> When running the Guarded Fabric diagnostics tool (Get-HgsTrace -RunDiagnostics), incorrect status may be returned claiming that the HTTPS configuration is broken when it is, in fact, not broken or not being used. This error can be returned regardless of HGS' attestation mode. The possible root-causes are as follows:
>
> - HTTPS is indeed improperly configured/broken
> - You're using admin-trusted attestation and the trust relationship is broken.
>     This is irrespective of whether HTTPS is configured properly, improperly, or not in use at all.
> Note that the diagnostics will only return this incorrect status when targeting a Hyper-V host. If the diagnostics are targeting the Host Guardian Service, the status returned will be correct.

## Quick start

You can diagnose either a guarded host or an HGS node by calling the following from a Windows PowerShell session with local administrator privileges:

```PowerShell
Get-HgsTrace -RunDiagnostics -Detailed
```

This will automatically detect the role of the current host and diagnose any relevant issues that can be automatically detected. All of the results generated during this process are displayed due to the presence of the `-Detailed` switch.

The remainder of this topic will provide a detailed walkthrough on the advanced usage of `Get-HgsTrace` for doing things like diagnosing multiple hosts at once and detecting complex cross-node misconfiguration.

## Diagnostics overview

Guarded fabric diagnostics are available on any host with shielded virtual machine related tools and features installed, including hosts running Server Core. Presently, diagnostics are included with the following features/packages:

- Host Guardian Service Role
- Host Guardian Hyper-V Support
- VM Shielding Tools for Fabric Management
- Remote Server Administration Tools (RSAT)

This means that diagnostic tools will be available on all guarded hosts, HGS nodes, certain fabric management servers, and any Windows 10 workstations with [RSAT](https://www.microsoft.com/download/details.aspx?id=45520) installed. Diagnostics can be invoked from any of the above machines with the intent of diagnosing any guarded host or HGS node in a guarded fabric; using remote trace targets, diagnostics can locate and connect to hosts other than the machine running diagnostics.

Every host targeted by diagnostics is referred to as a "trace target." Trace targets are identified by their hostnames and roles. Roles describe the function a given trace target performs in a guarded fabric. Presently, trace targets support `HostGuardianService` and `GuardedHost` roles. Note it's possible for a host to occupy multiple roles at once and this is also supported by diagnostics, however this shouldn't be done in production environments. The HGS and Hyper-V hosts should be kept separate and distinct at all times.

Administrators can begin any diagnostic tasks by running `Get-HgsTrace`. This cmdlet performs two distinct functions based on the switches provided at runtime: trace collection and diagnosis. These two combined make up the entirety of the Guarded Fabric Diagnostic Tool. Though not explicitly required, most useful diagnostics require traces that can only be collected with administrator credentials on the trace target. If insufficient privileges are held by the user executing trace collection, traces requiring elevation will fail while all others will pass. This allows partial diagnosis in the event an under-privileged operator is performing triage.

### Trace collection

By default, `Get-HgsTrace` will only collect traces and save them to a temporary folder. Traces take the form of a folder, named after the targeted host, filled with specially formatted files that describe how the host is configured. The traces also contain metadata that describe how the diagnostics were invoked to collect the traces. This data is used by diagnostics to rehydrate information about the host when performing manual diagnosis.

If necessary, traces can be manually reviewed. All formats are either human-readable (XML) or may be readily inspected using standard tools (for example, X509 certificates and the Windows Crypto Shell Extensions). Note however that traces aren't designed for manual diagnosis and it's always more effective to process the traces with the diagnosis facilities of `Get-HgsTrace`.

The results of running trace collection don't make any indication as to the health of a given host. They simply indicate that traces were collected successfully. It's necessary to use the diagnosis facilities of `Get-HgsTrace` to determine if the traces indicate a failing environment.

Using the `-Diagnostic` parameter, you can restrict trace collection to only those traces required to operate the specified diagnostics. This reduces the amount of data collected as well as the permissions required to invoke diagnostics.

### Diagnosis

Collected traces can be diagnosed by provided `Get-HgsTrace` the location of the traces via the `-Path` parameter and specifying the `-RunDiagnostics` switch. Additionally, `Get-HgsTrace` can perform collection and diagnosis in a single pass by providing the `-RunDiagnostics` switch and a list of trace targets. If no trace targets are provided, the current machine is used as an implicit target, with its role inferred by inspecting the installed Windows PowerShell modules.

Diagnosis will provide results in a hierarchical format showing which trace targets, diagnostic sets, and individual diagnostics are responsible for a particular failure. Failures include remediation and resolution recommendations if a determination can be made as to what action should be taken next. By default, passing and irrelevant results are hidden. To see everything tested by diagnostics, specify the `-Detailed` switch. This causes all results to appear regardless of their status.

It's possible to restrict the set of diagnostics that are run using the `-Diagnostic` parameter. This allows you to specify which classes of diagnostic should be run against the trace targets, and suppressing all others. Examples of available diagnostic classes include networking, best practices, and client hardware. Consult the [cmdlet documentation](/powershell/scripting/developer/cmdlet/cmdlet-overview) to find an up-to-date list of available diagnostics.

> [!WARNING]
> Diagnostics aren't a replacement for a strong monitoring and incident response pipeline. There is a System Center Operations Manager package available for monitoring guarded fabrics, as well as various event log channels that can be monitored to detect issues early. Diagnostics can then be used to quickly triage these failures and establish a course of action.

## Targeting diagnostics

`Get-HgsTrace` operates against trace targets. A trace target is an object that corresponds to an HGS node or a guarded host inside a guarded fabric. It can be thought of as an extension to a `PSSession`, which includes information required only by diagnostics such as the role of the host in the fabric. Targets can be generated implicitly (for example, local or manual diagnosis) or explicitly with the `New-HgsTraceTarget` cmdlet.

### Local diagnosis

By default, `Get-HgsTrace` will target the localhost (i.e. where the cmdlet is being invoked). This is referred as the implicit local target. The implicit local target is only used when no targets are provided in the `-Target` parameter and no pre-existing traces are found in the `-Path`.

The implicit local target uses role inference to determine what role the current host plays in the guarded fabric. This is based on the installed Windows PowerShell modules, which roughly correspond to what features have been installed on the system. The presence of the `HgsServer` module causes the trace target to take the role `HostGuardianService` and the presence of the `HgsClient` module causes the trace target to take the role `GuardedHost`. It's possible for a given host to have both modules present in which case it will be treated as both a `HostGuardianService` and a `GuardedHost`.

Therefore, the default invocation of diagnostics for collecting traces locally:

```PowerShell
Get-HgsTrace
```

That is equivalent to the following:

```PowerShell
New-HgsTraceTarget -Local | Get-HgsTrace
```

> [!TIP]
> `Get-HgsTrace` can accept targets via the pipeline or directly via the `-Target` parameter. There is no difference between the two operationally.

### Remote diagnosis using trace targets

It's possible to remotely diagnose a host by generating trace targets with remote connection information. All that is required is the hostname and a set of credentials capable of connecting using Windows PowerShell remoting.

```PowerShell
$server = New-HgsTraceTarget -HostName "hgs-01.secure.contoso.com" -Role HostGuardianService -Credential (Enter-Credential)
Get-HgsTrace -RunDiagnostics -Target $server
```
This example generates a prompt to collect the remote user credentials, and then diagnostics run using the remote host at `hgs-01.secure.contoso.com` to complete trace collection. The resulting traces are downloaded to the localhost and then diagnosed. The results of diagnosis are presented the same as when performing [local diagnosis](#local-diagnosis). Similarly, it isn't necessary to specify a role as it can be inferred based on the Windows PowerShell modules installed on the remote system.

Remote diagnosis utilizes Windows PowerShell remoting for all accesses to the remote host. Therefore it's a prerequisite that the trace target have Windows PowerShell remoting enabled (see [Enable PSRemoting](/powershell/module/microsoft.powershell.core/enable-psremoting?view=powershell-7&preserve-view=true)) and that the localhost is properly configured for launching connections to the target.

> [!NOTE]
> In most cases, it's only necessary that the localhost be a part of the same Active Directory forest and that a valid DNS hostname is used. If your environment utilizes a more complicated federation model or you wish to use direct IP addresses for connectivity, you may need to perform additional configuration such as setting the WinRM [trusted hosts](/previous-versions/technet-magazine/ff700227(v=msdn.10)).

You can verify that a trace target is properly instantiated and configured for accepting connections by using the `Test-HgsTraceTarget` cmdlet:

```PowerShell
$server = New-HgsTraceTarget -HostName "hgs-01.secure.contoso.com" -Role HostGuardianService -Credential (Enter-Credential)
$server | Test-HgsTraceTarget
```

This cmdlet returns `$True` if and only if `Get-HgsTrace` would be able to establish a remote diagnostic session with the trace target. Upon failure, this cmdlet returns relevant status information for further troubleshooting of the Windows PowerShell remoting connection.

#### Implicit credentials

When performing remote diagnosis from a user with sufficient privileges to connect remotely to the trace target, it isn't necessary to supply credentials to `New-HgsTraceTarget`. The `Get-HgsTrace` cmdlet will automatically reuse the credentials of the user that invoked the cmdlet when opening a connection.

> [!WARNING]
> Some restrictions apply to reusing credentials, particularly when performing what is known as a "second hop." This occurs when attempting to reuse credentials from inside a remote session to another machine. It's necessary to [setup CredSSP](/powershell/module/microsoft.wsman.management/enable-wsmancredssp?view=powershell-7&preserve-view=true) to support this scenario, but this is outside of the scope of guarded fabric management and troubleshooting.

#### Using Windows PowerShell Just Enough Administration (JEA) and diagnostics

Remote diagnosis supports the use of JEA-constrained Windows PowerShell endpoints. By default, remote trace targets will connect using the default `microsoft.powershell` endpoint. If the trace target has the `HostGuardianService` role, it will also attempt to use the `microsoft.windows.hgs` endpoint, which is configured when HGS is installed.

If you want to use a custom endpoint, you must specify the session configuration name while constructing the trace target using the `-PSSessionConfigurationName` parameter, such as below:

```PowerShell
New-HgsTraceTarget -HostName "hgs-01.secure.contoso.com" -Role HostGuardianService -Credential (Enter-Credential) -PSSessionConfigurationName "microsoft.windows.hgs"
```

#### Diagnosing multiple hosts

You can pass multiple trace targets to `Get-HgsTrace` at once. This includes a mix of local and remote targets. Each target is traced in turn and then traces from every target will be diagnosed simultaneously. The diagnostic tool can use the increased knowledge of your deployment to identify complex cross-node misconfigurations that wouldn't otherwise be detectable. Using this feature only requires providing traces from multiple hosts simultaneously (in the case of manual diagnosis) or by targeting multiple hosts when calling `Get-HgsTrace` (in the case of remote diagnosis).

Here is an example of using remote diagnosis to triage a fabric composed of two HGS nodes and two guarded hosts, where one of the guarded hosts is being used to launch `Get-HgsTrace`.

```PowerShell
$hgs01 = New-HgsTraceTarget -HostName "hgs-01.secure.contoso.com" -Credential (Enter-Credential)
$hgs02 = New-HgsTraceTarget -HostName "hgs-02.secure.contoso.com" -Credential (Enter-Credential)
$gh01 = New-HgsTraceTarget -Local
$gh02 = New-HgsTraceTarget -HostName "guardedhost-02.contoso.com"
Get-HgsTrace -Target $hgs01,$hgs02,$gh01,$gh02 -RunDiagnostics
```

> [!NOTE]
> You don't need to diagnose your entire guarded fabric when diagnosing multiple nodes. In many cases it's sufficient to include all nodes that may be involved in a given failure condition. This is usually a subset of the guarded hosts, and some number of nodes from the HGS cluster.

## Manual diagnosis using saved traces

Sometimes you may want to rerun diagnostics without collecting traces again, or you may not have the necessary credentials to remotely diagnose all of the hosts in your fabric simultaneously. Manual diagnosis is a mechanism by which you can still perform a whole-fabric triage using `Get-HgsTrace`, but without using remote trace collection.

Before performing manual diagnosis, you'll need to ensure the administrators of each host in the fabric that will be triaged are ready and willing to execute commands on your behalf. Diagnostic trace output doesn't expose any information that is generally viewed as sensitive, however it's incumbent on the user to determine if it's safe to expose this information to others.

> [!NOTE]
> Traces aren't anonymized and reveal network configuration, PKI settings, and other configuration that is sometimes considered private information. Therefore, traces should only be transmitted to trusted entities within an organization and never posted publicly.

Steps to performing a manual diagnosis are as follows:

1. Request that each host administrator run `Get-HgsTrace` specifying a known `-Path` and the list of diagnostics you intend to run against the resulting traces. For example:

   ```PowerShell
   Get-HgsTrace -Path C:\Traces -Diagnostic Networking,BestPractices
   ```

2. Request that each host administrator package the resulting traces folder and send it to you. This process can be driven over e-mail, via file shares, or any other mechanism based on the operating policies and procedures established by your organization.

3. Merge all received traces into a single folder, with no other contents or folders.

    For example, assume you had your administrators send you traces collected from four machines named HGS-01, HGS-02, RR1N2608-12, and RR1N2608-13. Each administrator would have sent you a folder by the same name. You would assemble a directory structure that appears as follows:

      ```output
      FabricTraces
      |- HGS-01
      |  |- TargetMetadata.xml
      |  |- Metadata.xml
      |  |- [any other trace files for this host]
      |- HGS-02
      |  |- [...]
      |- RR1N2608-12
      |  |- [...]
      |- RR1N2608-13
         |- [..]
      ```

4. Execute diagnostics, providing the path to the assembled trace folder on the `-Path` parameter and specifying the `-RunDiagnostics` switch as well as those diagnostics for which you asked your administrators to collect traces. Diagnostics will assume it can't access the hosts found inside the path and will therefore attempt to use only the precollected traces. If any traces are missing or damaged, diagnostics will fail only the affected tests and proceed normally. For example:

   ```PowerShell
   Get-HgsTrace -RunDiagnostics -Diagnostic Networking,BestPractices -Path ".\FabricTraces"
   ```

### Mixing saved traces with additional targets

In some cases, you may have a set of precollected traces that you wish to augment with additional host traces. It's possible to mix precollected traces with additional targets that will be traced and diagnosed in a single call of diagnostics.

Following the instructions to collect and assemble a trace folder specified above, call `Get-HgsTrace` with additional trace targets not found in the precollected trace folder:

```PowerShell
$hgs03 = New-HgsTraceTarget -HostName "hgs-03.secure.contoso.com" -Credential (Enter-Credential)
Get-HgsTrace -RunDiagnostics -Target $hgs03 -Path .\FabricTraces
```

The diagnostic cmdlet will identify all precollected hosts, and the one additional host that still needs to be traced and will perform the necessary tracing. The sum of all precollected and freshly gathered traces will then be diagnosed. The resulting trace folder will contain both the old and new traces.

## Known issues

The guarded fabric diagnostics module has known limitations when run on Windows Server 2019 or Windows 10, version 1809 and newer OS versions.
Use of the following features may cause erroneous results:

- Host key attestation
- Attestation-only HGS configuration (for SQL Server Always Encrypted scenarios)
- Use of v1 policy artifacts on an HGS server where the attestation policy default is v2

A failure in `Get-HgsTrace` when using these features doesn't necessarily indicate the HGS server or guarded host is misconfigured.
Use other diagnostic tools like `Get-HgsClientConfiguration` on a guarded host to test if a host has passed attestation.
