---
title: “The proxy server in your network requires authentication” or “The communication with the cloud services requires network proxy authentication” or “The proxy server in your network is blocking access to Microsoft cloud services” error
description: This article provides a resolution to proxy-related errors encountered in Microsoft Power Automate for desktop.
ms.reviewer: pefelesk
ms.date: 07/17/2023
ms.subservice: power-automate-desktop-flows
---
# “The proxy server in your network requires authentication” or “The communication with the cloud services requires network proxy authentication” or “The proxy server in your network is blocking access to Microsoft cloud services” error

This article provides a resolution to proxy-related errors encountered in Microsoft Power Automate for desktop.

_Applies to:_ &nbsp; Power Automate

## Symptoms

Power Automate for desktop console displays one of the following errors:

> The proxy server in your network requires authentication.
> 
> The communication with the cloud services requires network proxy authentication.
> 
> During startup Power Automate couldn't sign you in. The proxy server in your network requires authentication.
> 
> The proxy server in your network is blocking access to Microsoft cloud services.

## Cause

The machine running Power Automate for desktop is behind a proxy server, and either Power Automate for desktop cannot authenticate with the proxy server, or the proxy configuration prevents access to one or more cloud services.

## Resolution

> [!NOTE]
> Administrator rights are required for the below configurations.

Configure the proxy address and port that will be used to interact with the proxy server - [Configure Power Automate for desktop to interact with a corporate proxy server](/power-automate/desktop-flows/governance#configure-power-automate-for-desktop-to-interact-with-a-corporate-proxy-server).

If the error message is related to authentication, follow one of the below options:
- Option 1 - [Configure Power Automate for desktop to interact with a corporate proxy server using Windows Credentials](/power-automate/desktop-flows/governance#configure-power-automate-for-desktop-to-authenticate-to-a-corporate-proxy-server-using-windows-credentials)
- Option 2 - [Configure Power Automate for desktop to authenticate to a corporate proxy server using the current user's credentials](/power-automate/desktop-flows/governance#configure-power-automate-for-desktop-to-authenticate-to-a-corporate-proxy-server-using-the-current-users-credentials)
  
Alternatively, [Configure Power Automate for desktop to bypass a corporate proxy server](/power-automate/desktop-flows/governance#configure-power-automate-for-desktop-to-bypass-a-corporate-proxy-server)


## Workaround

If modifying the registry entries as described above does not provide the desired results, then take the following steps:
> [!NOTE]
> This method is not recommended, since the configuration files are not updated after a product update.

1. Close all instances of Power Automate for desktop.
   
   - Ensure that the icon does not exist in the system tray.
   - Ensure that no processes are running in the background using Windows Task Manager.

2. Navigate to the installation folder (_C:\Program Files (x86)\Power Automate Desktop_) and backup the following configuration files to recover them if something goes wrong:

   - PAD.Designer.exe.config
   - PAD.Console.Host.exe.config
   - PAD.Robot.exe.config

3. For all files, edit each file with administrator rights, and at the end of the root xml node (<configuration>), add the following child xml node:

```xml
<system.net> 
  <defaultProxy enabled="true" useDefaultCredentials="true" />
</system.net>
```

For example:
```xml
<configuration>
  <userSettings>
    <PAD.Console.Host.Properties.Settings>
      <setting name="DataCollectionActiveFileRetryInterval" serializeAs="String">
        <value>00:05:00</value>
      </setting>
      <setting name="DataCollectionBatchSize" serializeAs="String">
        <value>50</value>
      </setting>
    </PAD.Console.Host.Properties.Settings>
  </userSettings>
  <!-- Beginning of proxy authentication -->
  <system.net>
    <defaultProxy enabled="true" useDefaultCredentials="true" />
  </system.net>
  <!-- End of proxy authentication -->
</configuration>
```

4. Save the changes.
5. Restart Power Automate for desktop.
