---
title: Configure DFS to use domain names
description: Describes how to configure a DFSN server to operate in a DNS-only environment.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:access-to-remote-file-shares-smb-or-dfs-namespace, csstroubleshoot
---
# How to configure DFS to use fully qualified domain names in referrals

This article describes how to configure a DFSN server to operate in that environment.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 244380

## Summary

By default, a Microsoft Distributed File System Namespace (DFSN) root referral reply to a DFS root referral query is in NetBIOS name format (`\\<Server>\<Share>`). It's necessary in certain environments that rely on NetBIOS and makes it possible for clients that support NetBIOS-only name resolution to locate and connect to targets in the DFS namespace. By default, Windows clients work fine with it.

However, some clients don't use NetBIOS. Two examples are clients that aren't running Windows and clients that operate in an environment without WINS or that use DNS name suffixes. Those clients are incompatible with the default DFSN behavior.

In these cases, the client may be unable to resolve the server name that is returned from the root referral query. However, this problem can be addressed easily, because DFSN can be configured to operate in a DNS-only environment.

> [!NOTE]
> For namespace servers that are hosting only stand-alone namespaces, some steps that are described in this article are unnecessary. (Such namespace servers include clustered namespaces.) By default, DFSN clients can access such stand-alone namespaces through either `\\< Server-NetBIOS>\\<Namespace>` or `\\<Server-FQDN>\\<Namespace>` namespace paths. However, namespace server configuration is still required for stand-alone namespaces in order to provide correct referrals.

The steps that are described in this article apply to all DFS namespace servers, regardless of whether such namespace servers also act as Active Directory domain controllers.

## Four stages

The overall approach consists of the following four stages:

1. Configure a DNS suffix for resolution of qualified names on the client.
2. Verify DNS records of file server targets, and create host records as required.
3. Configure the DFSN server to respond by using FQDN referrals for root targets.
4. If it's required, update the namespace metadata for each folder target so that the folder referrals use appropriate FQDN names for folder targets.

## Steps for stage 3: Configure the DFSN server to respond by using FQDN referrals for root targets

> [!NOTE]
> Before you continue with the following steps for stage 3, we recommend that you back up the namespace metadata to guard against unexpected failures or accidents. The backup steps, together with the other restore steps if you ever need them, are covered in steps A and C of the [Steps for stage 4](#steps-for-stage-4-update-the-namespace-metadata-for-each-folder-target-so-that-the-metadata-uses-appropriate-fqdn-names) section.

> [!NOTE]
> The DFSN Windows PowerShell cmdlets that are mentioned in this section are available only starting with Windows Server 2012 or Windows 8.

1. Obtain the list of domain-based namespaces that are hosted on the server. To do it, use one of the following methods:

    ```powershell
    Get-DfsnRoot - ComputerName ServerName |Where type -NotMatch "Standalone"
    ```

    ```powershell
    dfsutil.exe server ServerName and manually identify the domain-based namespaces
    ```

    > [!NOTE]
    > If there are no domain-based namespaces that are hosted on this namespace server, you don't have to follow some steps in this article.

2. > [!NOTE]
   > You can skip the following step for namespace servers that host only stand-alone namespaces.

   Generally, domain-based namespaces are hosted on multiple namespace servers. So when you remove the namespace from one namespace server, as you do in this step, namespace availability isn't affected. However, you should make sure that there is in fact more than one namespace server that is hosting your namespace. To do it, use one of the following methods:

    ```powershell
    (Get-DfsnRootTarget -Path Namespace).Count
    ```

    ```powershell
    dfsutil.exe root Namespace
    ```

    For example, the placeholder `<Namespace>` could represent the following:  
        `\\contoso.com\DomainNamespace`
    If you confirm that there are multiple namespace servers hosting your namespace, you can skip step C that follows.

3. > [!NOTE]
   > You can skip the following step for namespace servers that host only stand-alone namespaces. You can also skip this step if you confirm that there are multiple namespace servers that are hosting your namespace.

    If there's only one namespace server for your namespace, you should temporarily add a new namespace server before you remove the existing server. (See [Add Namespace Servers to a Domain-based DFS Namespace](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc732807(v=ws.11)) or [New-DfsnRootTarget cmdlet](/powershell/module/dfsn/new-dfsnroottarget?view=winserver2012-ps&preserve-view=true).) Or, you must save the namespace metadata for a re-creation later. (To do it, see steps A and C of the [Steps for stage 4](#steps-for-stage-4-update-the-namespace-metadata-for-each-folder-target-so-that-the-metadata-uses-appropriate-fqdn-names) section.) However, you should be aware that the second approach will cause a transient downtime for the namespace.

4. > [!NOTE]
   > You can skip the following step for namespace servers that host only stand-alone namespaces.

    Remove each hosted domain-based namespace from the server. To do it, use one of the following methods:

    ```powershell
    Remove-DfsnRootTarget -TargetPath NamespaceRootTarget
    ```

    ```powershell
    dfsutil.exe target Remove NamespaceRootTarget
    ```

    For example, the placeholder `<NamespaceRootTarget>` could represent the following:  
    `\\Contoso-FS.contoso.com\AccountingSoftware`

5. Enable the DFSN FQDN root referral behavior. To do it, use one of the following methods:

    ```powershell
    Set-DfsnServerConfiguration -ComputerName ServerName -UseFqdn $true
    ```

    ```powershell
    Dfsutil.exe server registry dfsdnsconfig set ServerName
    ```

6. Restart the DFSN service. To do it, use one of the following methods:

    ```powershell
    Stop-Service dfs; Start-Service dfs
    ```

    ```powershell
    Net stop dfs; Net start dfs
    ```

7. > [!NOTE]
   > You can skip the following step for namespace servers that are hosting only stand-alone namespaces.

    Restore each namespace that you previously removed from this namespace server. To do this, use one of the following methods:

    ```powershell
    New-DfsnRootTarget - TargetPath RootTarget [-Path Namespace]
    ```

    ```powershell
    Dfsutil target add \\RootTarget
    ```

8. Depending on what you did in step B, follow these optional steps:

    1. If you took a backup of your namespace metadata in step B, you can import the metadata into the namespace that you just re-created. Before you import the metadata, you can also make any necessary adjustments as part of the same step. (See the [Steps for stage 4](#steps-for-stage-4-update-the-namespace-metadata-for-each-folder-target-so-that-the-metadata-uses-appropriate-fqdn-names) section.)
    2. If you temporarily added a namespace server in step B, you may remove it now.

## Steps for stage 4: Update the namespace metadata for each folder target so that the metadata uses appropriate FQDN names

Follow these steps for each namespace that is hosted on the namespace server:

1. Export the namespace metadata:

    ```xml
    dfsutil.exe root export \\contoso.com\DomainNamespace1 C:\dir1\a.txt
    ```

2. Make any necessary FQDN-related adjustments to folder targets. For each "Target" XML element that is contained in a "Link" XML element, change its NetBIOS reference to its equivalent FQDN reference.

    For example, before the update, the element is as follows:

    ```xml
    <Target State="ONLINE" >\\FileServer-NetBIOS\Share1</Target>
    ```

    After the update, the element is as follows:

    ```xml
    <Target State="ONLINE" >\\FileServer-FQDN\Share1</Target>
    ```

3. Import the updated namespace metadata:

    ```xml
    dfsutil.exe root import set C:\dir1\a.txt \\contoso.com\DomainNamespace1
    ```

## References

For more information about related topics, see:

- [Overview of DFS Namespaces](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc730736(v=ws.11))
- [Dfsutil Syntax](/previous-versions/windows/it-pro/windows-server-2003/cc736784(v=ws.10))
