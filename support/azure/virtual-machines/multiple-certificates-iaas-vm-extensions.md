---
title: Multiple certificates on an Azure IaaS VM that uses extensions
description: Fix an issue that involves multiple certificates generated on an Azure infrastructure as a service virtual machine that uses extensions.
ms.date: 05/05/2023
editor: v-jsitser
ms.reviewer: kegregoi, axelg, scotro, v-leedennis
ms.service: virtual-machines
ms.subservice: vm-extensions-not-operating
---
# Multiple certificates on an Azure IaaS VM that uses extensions

This article discusses how to handle an issue in which multiple certificates are generated on a Microsoft Azure infrastructure as a service (IaaS) virtual machine (VM) that uses extensions.

## Symptoms

The symptoms of this issue vary depending on which platform you use for the IaaS VM, as shown in the following table.

| IaaS VM platform | Symptoms |
|-|-|
| Windows | When you browse the Certificates snap-in of the Microsoft Management Console, you find numerous instances of certificates that have a subject name of **Windows Azure CRP Certificate Generator**. (On a classic RedDog Front End (RDFE) VM, the certificates have a subject name of **Windows Azure Service Management for Extensions**.) |
| Linux | In the */var/lib/waagent* folder, you find several files that have names that contain 40 hexadecimal digits and a *.crt* (certificate) file name extension (for example, *0123456789ABCDEF0123456789ABCDEF01234567.crt*). |

For Windows VMs, see the following section to learn how to verify these symptoms.

#### Windows

In Windows, if you view the *C:\\WindowsAzure\\logs\\WaAppAgent.log* log file, you notice a pattern that resembles the following text:

```output
[01/16/2017 21:42:25.50] [INFO]  Imported Certificate: DC=Windows Azure CRP Certificate Generator.
[01/16/2017 21:42:25.50] [INFO]  Certificate thumbprint: 1D59A4E7F60F6D978124ED7D3E177B0D6A6806C9
[01/16/2017 21:42:25.50] [INFO]  Comparing normalizedHash: 1D59A4E7F60F6D978124ED7D3E177B0D6A6806C9 and hash 1D59A4E7F60F6D978124ED7D3E177B0D6A6806C9.
[01/16/2017 21:42:25.50] [INFO]  Certificate 1D59A4E7F60F6D978124ED7D3E177B0D6A6806C9 is found.
[01/16/2017 21:42:25.50] [INFO]  Comparing normalizedHash: 1D59A4E7F60F6D978124ED7D3E177B0D6A6806C9 and hash FC2FFCDEE6A8C6033EE4986B4D5080E3E2083CC9.
...
[01/16/2017 21:42:25.50] [INFO]  Comparing normalizedHash: 1D59A4E7F60F6D978124ED7D3E177B0D6A6806C9 and hash 1E1A0BF89A1FDD0722F4F94083A6CCDF94EFC78A.
[01/16/2017 21:42:25.50] [INFO]  Comparing normalizedHash: 1D59A4E7F60F6D978124ED7D3E177B0D6A6806C9 and hash 1D59A4E7F60F6D978124ED7D3E177B0D6A6806C9.
[01/16/2017 21:42:25.50] [INFO]  Certificate 1D59A4E7F60F6D978124ED7D3E177B0D6A6806C9 is found.
[01/16/2017 21:42:25.50] [INFO]  Certificate with the subject: DC=Windows Azure CRP Certificate Generator will not be added because it already exists in the store.
[01/16/2017 21:42:25.50] [INFO]  Successfully imported cert TenantEncryptionCert into the store My
```

If you see this kind of pattern, follow these steps to verify that you have multiple certificates that have the same subject name:

1. On the Windows **Start** menu, search for and select *MMC.exe* to open the Microsoft Management Console.

1. On the **File** menu of the Microsoft Management Console, select **Add/Remove Snap-in**.

1. In the **Add or Remove Snap-ins** dialog box, under the list of **Available snap-ins**, select **Certificates**, and then select the **Add** button.

1. In the **Certificates snap-in** dialog box, select **Computer Account**, and then select **Next** > **Finish**.

1. In the **Add or Remove Snap-ins** dialog box, select the **OK** button.

1. In the console tree, expand **Certificates (Local Computer)**, expand **Personal**, and then select **Certificates**. A list of certificates appears. All the certificates have an **Issued By** column value of **Windows Azure CRP Certificate Generator** (or **Windows Azure Service Management for Extensions** if you're using a classic RDFE VM).

## Cause: Stopping and starting the VM every day

The multiple-certificate issue can occur if you stop and start the VM every day. When you use the VM in this manner, a new certificate must be issued after each VM restart.

## Solution 1: Delete the old certificates

You can delete the old certificates and keep only the latest certificates. The VM agent automatically re-creates the certificate if it's necessary.

## Solution 2: Update the VM agent

You can update to a more recent version of the VM agent so that the old certificates are automatically deleted. For more information, refer to the following table.

| VM operating system | Link to VM agent installation instructions                                          |
|---------------------|-------------------------------------------------------------------------------------|
| Windows             | [Azure Windows VM Agent overview](/azure/virtual-machines/extensions/agent-windows) |
| Linux               | [Azure Linux VM Agent overview](/azure/virtual-machines/extensions/agent-linux)     |

## References

- [Troubleshoot extension certificate issues on a Windows VM in Azure](./troubleshoot-extension-certificates-issues-windows-vm.md)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
