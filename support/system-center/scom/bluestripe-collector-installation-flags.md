---
title: Installation flags of BlueStripe Collector
description: Describes how to see the installation flags of BlueStripe Collector on Linux, Solaris, and AIX.
ms.date: 08/13/2020
ms.custom: linux-related-content
---
# The installation flags of BlueStripe Collector on Linux, Solaris and AIX

This article describes the installation flags of BlueStripe Collector on Linux, Solaris, and AIX.

_Original product version:_ &nbsp; BlueStripe  
_Original KB number:_ &nbsp; 3134881

## See a list of the installation flags

To see a list of the installation flags, run the installation program with the `-help` flag:

```console
InstallBlueStripeCollector-AIX.bin -help
InstallBlueStripeCollector-Linux.bin -help
InstallBlueStripeCollector-Solaris.bin -help
```

All arguments are case-sensitive.

On Linux, Solaris, and AIX, the installation program accepts the [core collector options](#core-collector-options). The silent flag must be specified for an uninterrupted installation void of prompts.

## Core collector options

|Flag|Possible values|Description|Default value |
|---|---|---|---|
|`-s`||Silent flag required for silent installations. It implicitly means agreement to the end-user license agreement (EULA), and requires no user prompts.||
|`--upgrade`||Upgrades and preserves all configuration and data files from the current installation. Reinstalls into the same location.||
|`--replace`||||
|`--config=`|myconfigfile|Modify the default settings in `BlueStripeCollector.properties` after installation using the values in _myconfigfile_.<br/><br/>For example, if a file named _myprops.txt_ contained the line `protocol.mssql.trigger = remote_port==1061`, use the command line `argument -config=<full-path>/myprops.txt` to specify that the SQL Server is listening to port 1061.<br/><br/>The full path to the file must be given.||
|`--base-dir=`||Base Installation directory to use.|/|
|`--cert=`|customcert.cert|Filename to a custom certificate to be installed. File extension must be .cer.<br/><br/>Flag and value can be specified multiple times for multiple custom certificates<br/><br/>The full path to the file must be given.||
|`--cacert=`|ca_certs.pem|Optional if `/Cert` specified. File should be a concatenation of all required CA certificates into a file with the file extension of .pem.<br/><br/>The full path to the file must be given.||
|`--defaultcert`||Install the default BlueStripe self-signed certificate.<br/><br/>Required if no custom certificate is specified, but optional otherwise.||
|`--check`||Checks permissions and operating system but doesn't install the collector.||
  
If the `-s (silent)` flag isn't given, the user will be prompted to accept the EULA before continuing even if all the other configuration options are defined on the command line.

## Transaction plugin options

Since the Windows Collector requires a reboot to active, the web server is restarted as part of the reboot.

|Flag|Possible values|Description|Default values |
|---|---|---|---|
|`--apache=`|auto<br/><br/>manual<br/><br/>off|If set to **auto**, the transaction plugin is installed, and Apache is gracefully restarted.<br/><br/>If set to **manual**, the transaction plugin is installed but the user must restart Apache.<br/><br/>If set to **off**, the transaction plugin isn't installed.|auto|
|`--apache-flags=`|"_options_"|Optional flags must be inside single or double quotes.||
|`--sunone`|auto<br/><br/>manual<br/><br/>off|If set to **auto**, the transaction plugin is installed, and SunOne web server is gracefully restarted.<br/><br/>If set to **manual**, the transaction plugin is installed but the user must restart the SunOne web server.<br/><br/>If set to **off**, the transaction plugin isn't installed.|auto|
|`-sunoneflags`|"_options_"|||
|`--websphere=`|auto<br/><br/>manual<br/><br/>off|If set to **manual**, the transaction plugin is installed but the user must restart WebSphere.<br/><br/>If set to **off**, the transaction plugin isn't installed.|manual|
|`--websphere-flags=`|"_options_"|Optional flags must be inside single or double quotes.||
|`--weblogic=`|auto<br/><br/>manual<br/><br/>off|If set to **manual**, the transaction plugin is installed but the user must restart WebLogic.<br/><br/>If set to **off**, the transaction plugin isn't installed.|manual|
|`--weblogic-flags=`|"_options_"|Optional flags must be inside single or double quotes.||
  
During an upgrade of the collector, any web/app servers with the transaction plugin installed will be gracefully restarted regardless of which mode is selected. It's necessary to completely shut down the Collector and to ensure a successful upgrade.

## Collector initiated connections

By default, after a BlueStripe Collector is installed, the FactFinder management server uses UDP port 7561 to discover it and uses TCP port 7561 to start a connection to it.

While automatic collector discovery is recommended, it's also possible to turn off collector discovery and have the collector contact the management server to establish a connection using the command-line options in the following table:

|Flag| Options| Description| Default option |
|---|---|---|---|
|`--FFHostname`|<br/>Management server's IP addresses or host names|A comma-separated list of IPv4 address/port combinations, computer names, or fully qualified DNS names of FactFinder management server(s) to start connections to.<br/><br/>Only necessary if FactFinder can't use the discovery process to connect to it or if you want to configure it to start connections to FactFinder instances through firewalls.||
|`--FFPort=`|Management server's port|To be used with `/FFHostname` above to specify which port to use by default when initiating a connection with FactFinder servers. If a specific port is listed in the list of hosts in the `--FFHostname` parameter above, it will override the default value listed here for that machine only.|7560|
  
## Silent uninstall on Linux

Uninstall the collector on Linux by executing the following command as root:

```console
rpm -e bluestripe-collector
```

This command is already non-interactive, so it can be used for a silent uninstall.

## Silent uninstall on Solaris

Uninstall in silent mode on Solaris by executing the following command as root:

```console
pkgrm -na /etc/bluestripe-collector/bluestripe-pkgadmin BSSWcollSilent
```

## Uninstall on AIX

To uninstall the collector on AIX, execute the following command:

```console
installp -u bluestripe.collector
```

If a non-default install location was used, the uninstall command will be:

```console
installp_r -R base-dir -u bluestripe.collector
```
