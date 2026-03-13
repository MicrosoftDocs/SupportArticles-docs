---
title: Synchronizing Between AD DS and AD LDS Enters Endless Loop if the base DN is a Grandchild OU
description: Discusses how to work around a behavior in the Adamsync tool in which the synchronization process enters an endless loop.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, herbertm, v-appelgatet
ms.custom:
- sap:active directory\active directory lightweight directory services (ad lds)
- pcy:WinComm Directory Services
appliesto:
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
---

# Endless loop in AD DS to AD LDS synchronization if base DN is a grandchild OU

_Original KB number:_ &nbsp; 926933

## Summary

When you use the Active Directory Application Mode (ADAM) Synchronizer (Adamsync) tool to synchronize data from Active Directory Domain Services (AD DS) to Active Directory Lightweight Directory Services (AD LDS), the synchronization process might enter an endless loop. This issue occurs when you specify a grandchild organizational unit (OU) as the base distinguished name (base DN) in the Adamsync configuration file.

This article describes the symptoms, cause, and workarounds for this known issue in the Adamsync tool.

## Symptoms

You have an Active Directory Domain Services (AD DS) forest and an Active Directory Lightweight Directory Service (AD LDS) instance. You use the Adamsync tool in Windows to synchronize data from the AD DS forest to the AD LDS instance. However, the synchronization never finishes. For a detailed walkthrough of this process, see [More information](#more-information).

This issue occurs if you specify a grandchild organizational unit (OU) in the AD DS forest as the base DN in Adamsync's XML configuration file. Such a configuration resembles the following example:

```xml
<base-dn>OU=Grandchild,OU=Child,DC=03child,DC=MyDomCon,DC=net</base-dn>
```

By default, the configuration file is named MS-AdamsyncConf.XML, and it resides in the %windir%\adam folder.

## Cause

This behavior is a known issue in the Adamsync tool.

## Workaround

To work around this issue, use one of the following methods:

- Before you run the Adamsync tool, create the grandchild OU in the AD LDS instance. Then, in the Adamsync configuration file, specify the grandchild OU as the base DN.

- Instead of specifying the grandchild OU as the base DN in the Adamsync configuration file, specify the child OU as the base DN. For example, use the following syntax to specify the base DN in the Adamsync configuration file:

  ```xml
  <base-dn>OU=Child,DC=03child,DC=MyDomCon,DC=net</base-dn>
  ```

## More information

You can reproduce the issue by following these steps:

1. Configure an AD LDS instance (or a configuration set of instances) as described in the [Preparing an AD LDS instance for synchronization](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc770408(v=ws.10)#preparing-an-adlds-instance-for-synchronization) section of "Synchronize with Active Directory Domain Services."

1. Edit the Adamsync tool configuration file to synchronize data from an Active Directory forest to the instance or configuration set. Set the base DN to be the grandchild OU.

   For example, include parameters that resemble the following example in the My-Custom-AdamsyncConf.XML configuration file:

   ```xml
   <source-ad-name>03child.MyDomCon.net</source-ad-name>
   <source-ad-partition>dc=03child,dc=MyDomCon,dc=net</source-ad-partition>
   <source-ad-account></source-ad-account>
   <account-domain></account-domain>
   <target-dn>dc=lds-target,dc=com</target-dn>
   <query>
     <base-dn>OU=Grandchild,OU=Child,DC=03child,DC=MyDomCon,DC=net</base-dn>
   ```

1. To install the Adamsync configuration, run the following command at a Windows command prompt:

   ```console
   Adamsync.exe /install <AdamServerName>:<PortNo> My-Custom-AdamsyncConf.XML
   ```

   > [!NOTE]  
   > In this command (and in the other steps of this procedure), `<AdamServerName>` represents the name of the computer that runs the Adamsync tool, and `<PortNo>` represents the number of the port that the Adamsync tool uses.

1. To start synchronizing, run the following command at the command prompt:

   ```console
   Adamsync /sync <AdamServerName>:<PortNo> "dc=lds-target,dc=com" /Log Synclog.txt
   ```

   > [!NOTE]  
   > In this command, `dc=lds-target,dc=com` represents the target naming context in the AD LDS instance. `Synclog.txt` is the file name of the synchronization log.

   The synchronization process runs for a much longer time than you expect.

1. After the synchronization process runs for a while, use Task Manager to end the Adamsync process.

1. Open the log file that you specified in step 4. The log file contains entries that resemble the following example:

   ```output
   Processing Entry: Page 1, Frame 2, Entry 0, Count 0, USN 3707635
   Processing source entry <guid=f356ef7ee6f25d46835363baa7d6de2c>
   Processing in-scope entry f356ef7ee6f25d46835363baa7d6de2c.
   Adding target object OU=Grandchild,OU=Child,dc=lds-target,dc=com.
   Adding attributes: objectClass, instanceType, sourceobjectguid, lastagedchange,
   Adding target object OU=Grandchild,OU=Child,dc=lds-target,dc=com. Requesting replication of parent.
   Previous entry took 0 seconds (16, 0) to process

   Processing Entry: Page 1, Frame 3, Entry 0, Count 0, USN 3704672
   Processing source entry <guid=8416cee1dc410d47a871c4905a7e3bda>
   Previous entry took 0 seconds (0, 0) to process

   Processing Entry: Page 1, Frame 2, Entry 0, Count 0, USN 3707635
   Processing source entry <guid=f356ef7ee6f25d46835363baa7d6de2c>
   Processing in-scope entry f356ef7ee6f25d46835363baa7d6de2c.
   Adding target object OU=Grandchild,OU=Child,dc=lds-target,dc=com.
   Adding attributes: objectClass, instanceType, sourceobjectguid, lastagedchange,
   Adding target object OU=Grandchild,OU=Child,dc=lds-target,dc=com. Requesting replication of parent.
   Previous entry took 0 seconds (4, 0) to process

   Processing Entry: Page 1, Frame 3, Entry 0, Count 0, USN 3704672
   Processing source entry <guid=8416cee1dc410d47a871c4905a7e3bda>
   Previous entry took 0 seconds (2, 0) to process
   ```

   This pattern of entries repeats throughout the log file.

## References

- [Synchronize with Active Directory Domain Services](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc770408(v=ws.10))
- [Adamsync](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc753547(v=ws.10))
- [Active Directory Lightweight Directory Services Overview](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831593(v=ws.11))
- [Active Directory Lightweight Directory Services](/previous-versions/windows/desktop/adam/active-directory-lightweight-directory-services)
- [Adamsync 101](https://techcommunity.microsoft.com/blog/askds/Adamsync-101/400165)
