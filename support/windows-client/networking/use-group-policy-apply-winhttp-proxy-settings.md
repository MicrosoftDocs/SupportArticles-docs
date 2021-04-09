---
title: Use Group Policy to apply WinHTTP proxy settings to clients
description: Describes how to use Group Policy to apply WinHTTP proxy settings to Windows clients. Applies to Windows 7/Windows Server 2008 R2 and later versions.
ms.date: 12/07/2020
author: Deland-Han
ms.author: delhan 
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika, arrenc, tfairman, dantes
ms.prod-support-area-path: Web Application Proxy (WAP) role service
ms.technology: windows-client-networking
---
# Use Group Policy to apply WinHTTP proxy settings to Windows clients

This article describes how to use Group Policy to apply WinHTTP proxy settings to clients in a Windows environment.

_Original product version:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 4494447

## Summary

This article applies to Windows 7 and later version of Windows clients, and Windows Server 2008 R2 and later version of Windows servers.

## More information

### Configure the proxy for WinHTTP Services

To Configure the proxy for WinHTTP Services, run the following command in a Command Prompt window that has elevated permissions:

```console
netsh winhttp set proxy "---"
```  

> [!Note]
> In this command, replace the three hyphens (---) with the following text, including the appropriate values for the placeholders:  
 \<server IP or FQDN>:\<Port> "\<Exclusion list, separated by ";">"
  
For example, the following command (shown in English) configures the address of `proxy.contoso.com` on port 8080, and has exclusions for "localhost" and the "`contoso.com`" domain:
  
```console
netsh winhttp set proxy proxy.contoso.com:8080 "localhost;*.contoso.com"
```

Other available parameters

The Help output for this command shows other parameters that you can use:

```console
C:\WINDOWS\system32>netsh winhttp set proxy ?  
Usage: set proxy [proxy-server=]<server name> [bypass-list=]<hosts list>  
Parameters:  
Tag Value  
proxy-server - proxy server for use for http and/or https protocol  
bypass-list - a list of sites that should be visited bypassing the  
proxy (use "<local>" to bypass all short name hosts)  
Examples:  
set proxy myproxy  
set proxy myproxy:80 "<local>;bar"  
set proxy proxy-server="http=myproxy;https=sproxy:88" bypass-list="*.foo.com"  
```

### Import the settings through Control Panel

You can also import the settings from the **Internet Options** item in Control Panel. You can use following command:

```console
netsh winhttp import proxy source=ie
```
  
> [!Note]
> This command does not support scripts, such as PAC or DAT files. This command works only for the manual proxy configuration in **Internet Properties** > **Connection**. It does not work for the **Use automatic configuration script** option. By default, Direct Access configuration tries to locate a proxy script by using the Web Proxy Auto-Discovery Protocol process.

To verify that the proxy settings are correctly applied to WinHTTP Services, run the following command:

```console
netsh winhttp show proxy
```
  
If no proxy setting is applied, you receive the following output:
> Current WinHTTP proxy settings:
>
> Direct access (no proxy server).

If a proxy setting is applied, you receive the following output:
> Current WinHTTP proxy settings:
>
> Proxy Server(s) : `proxy.contoso.com:8080`  
    Bypass List : localhost;*.contoso.com

> [!Note]
> If you have everything correctly set up and you want to restore a direct connection, run the following command: `netsh winhttp reset proxy`.  

### How proxy data is stored in Windows

All the configurations are stored in a registry value that is located in the following path:  
Registry Path: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Connections`  
Value: WinHttpSettings  
Type: Binary  
Data (for Direct Access or No Proxy): 1800000000000000010000000000000000000000

After you change the proxy settings, the registry value changes as follows:  
:::image type="content" source="./media/use-group-policy-apply-winhttp-proxy-settings/registry-value.png" alt-text="Registry value." border="false":::

### Use Group policy to deploy proxy settings to clients

After you set up the correct proxy configuration and the registry key, you can use Group Policy to deploy proxy settings to clients.

> [!Note]
> We recommend that you test these settings before you apply them to a production environment. Follow these steps first on an organizational unit that has **Block Inheritance** applied and has only a few computer objects assigned. Applying this setting in a domain-wide scope may affect core infrastructure server functionality (for example, DHCP servers or domain controllers) and may adversely affect your environment.

1. Open the Group Policy Management Console from a computer that has the correct proxy settings for WinHTTP Services. Then, create a Group Policy Object, such as **TestWinhttpProxy**.
2. Edit the GPO, and locate the following path: **Computer Configuration** > **Preferences** > **Windows Settings** > **Registry**  
3. Right-click **Registry**, and select **New** > **Registry Item**.
4. On the **General** tab, set the **Action**  value as **Update**, and then browse for your local **WinHttpSettings** registry key.

    :::image type="content" source="./media/use-group-policy-apply-winhttp-proxy-settings/browse-for-your-local-WinHttpSettings-registry-key.png" alt-text="Browse for your local WinHttpSettings registry key." border="false":::

5. Click **OK**, and close the editor. The following result is displayed.

    :::image type="content" source="./media/use-group-policy-apply-winhttp-proxy-settings/group-policy-result.png" alt-text="Group Policy result" border="false":::

6. Link the GPO to the desired OU.  

    :::image type="content" source="./media/use-group-policy-apply-winhttp-proxy-settings/link-the-gpo-to-the-desired-ou.png" alt-text="Link the GPO to the desired OU." border="false":::

You can either wait for the Group Policy Object to be applied to clients or you can run `GPUPDATE /FORCE` to apply the policy immediately.

From a computer that's located in the target OU, run the following command to make sure that WinHTTP Services proxy settings are applied successfully:  

```console
netsh winhttp show proxy
```
