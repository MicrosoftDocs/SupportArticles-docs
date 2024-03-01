---
title: Can't use Vmconnect to connect to virtual machine
description: Describes an error message that you receive when you try to use Vmconnect.exe to connect to a virtual machine in Windows Server. To resolve this error, you must verify that the required registry keys are configured to enable remote authentication.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:configuration-of-virtual-machine-settings, csstroubleshoot
---
# "A connection will not be made because credentials may not be sent to the remote computer" when I use the Virtual Machine Connection tool to connect to a virtual machine on a Windows Server 2008 Hyper-V-based computer

This article provides help to fix an error that you receive when you try to use `Vmconnect.exe` to connect to a virtual machine.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 954357

## Error message description

When you use the Virtual Machine Connection tool (Vmconnect.exe) to connect to a virtual machine on a Windows Server 2008 Hyper-V-based computer, you may receive the following error message:  
> A connection will not be made because credentials may not be sent to the remote computer. For assistance, contact your system administrator.
>
> Would you like to try connecting again?

## Cause

This error occurs if the Credential Security Service Provider (CredSSP) policy on the Windows Server 2008 Hyper-V-based computer is not enabled to authenticate user credentials from a remote location.

## Resolution

You can configure CredSSP policy at the time of the Hyper-V role Setup to enable authentication of credentials from a remote user. However, if any of the registry entries that are described in the "Configure the registry" section are not present, the error that is described in the "Symptoms" section will occur. To configure remote user authentication, use one of the following methods.

### Method 1: Configure the registry

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

If the CredSSP policy is not set up correctly, you can manually create the policy. To do this, create the following registry entry under several registry subkeys:

Name: Hyper-V  
Value type: String Value  
Value data: Microsoft Virtual Console Service/*  

This registry entry must be created under the following registry subkeys:  

- `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\Credssp\PolicyDefaults\AllowDefaultCredentials`  
- `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\Credssp\PolicyDefaults\AllowDefaultCredentialsDomain`  
- `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\Credssp\PolicyDefaults\AllowFreshCredentials`  
- `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\Credssp\PolicyDefaults\AllowFreshCredentialsDomain`  
- `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\Credssp\PolicyDefaults\AllowFreshCredentialsWhenNTLMOnly`  
- `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\Credssp\PolicyDefaults\AllowFreshCredentialsWhenNTLMOnlyDomain`  
- `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\Credssp\PolicyDefaults\AllowSavedCredentials`  
- `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\Credssp\PolicyDefaults\AllowSavedCredentialsDomain`  
- `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\Credssp\PolicyDefaults\AllowSavedCredentialsWhenNTLMOnly`  

The "How to create the registry entry" section describes how to create the registry entry under the first registry subkey in the list. You must repeat these steps for the remaining registry subkeys.

#### How to create the registry entry

Follow these steps, and then quit **Registry Editor**:

1. Click **Start**, click **Run**, type *regedit*, and then click **OK**.

2. Locate and then click the following key in the registry:
 `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\Credssp\PolicyDefaults\AllowDefaultCredentials`  

3. On the **Edit** menu, point to **New**, and then click **String Value**.
4. Type *Hyper-V*, and then press ENTER.

5. On the **Edit** menu, click **Modify**.

6. Type *Microsoft Virtual Console Service/\**, and then click **OK**.

### Method 2: Use Group Policy settings

To enable authentication of remote credentials, you can use the Gpedit tool to configure Group Policy settings on the Windows Server 2008 Hyper-V-based computer. To do this, follow these steps:  

1. Start Gpedit.msc.
2. Expand **Computer Configuration**, and then expand **Administrative Templates**.
3. Expand **System**, and then click **Credentials Delegation**.
4. In the Details pane, double-click **Allow Delegating Default Credentials**.

    > [!NOTE]
    > If you are using NTLM authentication, use the **Allow Default Credentials with NTLM-only Server Authentication** entry.  

5. Click **Enabled**, and then click to select the **Concatenate OS defaults with inputs above** check box.
6. Click **Show**, and then verify that the computer of the remote user is included in the list. If it is necessary, click **Add**, and then include the computer of the remote user. You can also use wildcard characters. For example, to select all computers, add the following wildcard character: \*.
7. Click **OK** two times.
8. Close Group Policy.

    > [!IMPORTANT]
    > This method differs from the method that is described in the "Configure the registry entry" section. The Group Policy configuration will use any Service Principal Name (SPN) from any computer to enable authentication of remote credentials. The method that is described in the "Configure the registry entry" section will enable only authentication of the Microsoft Virtual Console Service.
