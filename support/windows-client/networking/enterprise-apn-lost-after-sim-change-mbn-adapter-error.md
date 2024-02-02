---
title: Windows 10 Enterprise APN lost after SIM change or MBN adapter error
description: A provisioning approach can help prevent a Windows 10 client from losing its enterprise APN information after a change or error in the SIM or MBN adapter.
ms.date: 12/03/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, marcussa, v-tea
ms.custom: sap:tcp/ip-communications, csstroubleshoot
---
# Windows 10: Enterprise APN lost after SIM change or MBN adapter error

This article provides a solution to an issue that enterprise APN lost after SIM change or MBN adapter error.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 4487376

## Symptoms

A Windows 10 client that previously connected to the enterprise wireless network can no longer connect after the SIM was removed or the MBN adapter encountered an error or failure, even if the SIM or MBN adapter is now working correctly.

This situation applies if the wireless connection, including the enterprise access point name (APN), was configured at the time of provisioning by using either of the following methods:

- Using a provisioning package that was built by using Windows Configuration Designer (for more information, see [Configure cellular settings for tablets and PCs](/windows/configuration/provisioning-apn))
- Using the following command at the Windows command prompt:

    ```console
    netsh mbn add profile interface="MBN IF name" name="path to profile.xml"
    ```

The initial provisioning successfully created a profile.xml file that listed the enterprise APN. However, after the SIM was removed or after the MBN adapter experienced an error or failure (for example, after a power transition occurred), the computer can no longer use the enterprise APN. The `netsh mbn show profile` command cannot show the profile information. This is because the profile.xml file has been deleted.

## Cause

Windows 10 manages enterprise APNs in the same manner that it manages OEM-provisioned APNs: It associates the APN with the SIM. If the SIM is removed, so is the APN.

## Resolution

To configure a Windows 10 client to associate the APN with any SIM that is used on the MBN adapter, you must create a new provisioning package that includes a customized answer file.

> [!Important]
> To make these modifications, you must edit the answer file manually, and use the Windows Configuration Designer command-line interface (CLI) to rebuild the provisioning package. For more information about how to use the Windows Designer CLI, see [Windows Configuration Designer command-line interface (reference)](/windows/configuration/provisioning-packages/provisioning-command-line).

The process of customizing the APN configuration resembles the process that is described in [Create a provisioning package with multivariant settings](/windows/configuration/provisioning-packages/provisioning-multivariant). However, instead of creating variants of a configuration for variants in hardware, you define a wildcard to apply the same configuration to any hardware.

## Example

Consider the following segment of an answer file:

```xml
<Customizations> 
  <Common> 
    <Connections> 
      <EnterpriseAPN> 
        <EnterpriseConnection EnterpriseConnectionName="Contoso" Name="Contoso">
          <APNName>Contoso</APNName>
          <AlwaysOn>True</AlwaysOn>
          <AuthType>None</AuthType>
          <Enabled>True</Enabled>
        </EnterpriseConnection>
      </EnterpriseAPN>
    </Connections>
  </Common>
</Customizations>
```

To support any SIM, edit the answer file segment as follows:

```xml
<Settings xmlns="urn:schemas-microsoft-com:windows-provisioning">
  <Customizations>
    <Targets>
      <Target Id="AnyUicc">
        <TargetState>
          <Condition Name="iccid" Value="pattern:.*" />
        </TargetState>
      </Target>
    </Targets>
    <Variant>
     <TargetRefs>
       <TargetRef Id="AnyUicc" />
     </TargetRefs>
     <Settings>
       <Connections>
         <EnterpriseAPN>
           <EnterpriseConnection EnterpriseConnectionName="Contoso" Name="Contoso">
             <APNName>Contoso</APNName>
             <AlwaysOn>True</AlwaysOn>
           </EnterpriseConnection>
         </EnterpriseAPN>
       </Connections>
     </Settings>
    </Variant>
  </Customizations>
</Settings>
```

To rebuild the provisioning package that contains the edited answer file, run the following command:

```console
Icd.exe /build-provisioningpackage /CustomizationXML:c:\temp\enterprise_anysim.xml /PackagePath:x:\ppkgs\enterprise_anysim [optional /StoreFile:Microsoft-Desktop-Provisioning.dat] +Overwrite
```

## References

- [Windows Configuration Designer command-line interface (reference)](/windows/configuration/provisioning-packages/provisioning-command-line)
- [Configure cellular settings for tablets and PCs](/windows/configuration/provisioning-apn)
- [How to Create a provisioning package with multivariant settings](/windows/configuration/provisioning-packages/provisioning-multivariant)
