---
title: add MaxTokenSize registry entry
description: Describes how to use Group Policy on a domain controller to add the MaxTokenSize registry entry to multiple computers.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, muhasa
ms.custom: sap:Group Policy\Problems Applying Group Policy, csstroubleshoot
---
# How to use Group Policy to add the MaxTokenSize registry entry to multiple computers

This article describes how to use Group Policy to add the MaxTokenSize registry entry to multiple computers.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 938118

## Introduction

On a domain controller that is running Windows Server 2003, Windows Server 2008, Windows Server 2008 R2, or Windows Server 2012, you can use Group Policy to add the following registry entry to multiple computers:  

Key: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\Kerberos\Parameters`  
Entry: MaxTokenSize  
Data type: REG_DWORD  
Value: 48000  

This article describes how to do it, so that you can push this setting to all members of your domains easily. The process is different, depending on the version of Windows Server that the domain controller is running.

>[!NOTE]
>The maximum allowed value of MaxTokenSize is 65535 bytes. However, because of HTTP's base64 encoding of authentication context tokens, we do not recommend that you set the maxTokenSize registry entry to a value larger than 48000 bytes. Starting with Windows Server 2012, the default value of the MaxTokenSize registry entry is 48000 bytes.

## More information

### How to configure MaxTokenSize by using Group Policy Object (GPO) in Windows Server 2003

To add the registry entry to multiple computers in a domain that does not have a Windows Server 2012-based domain controller, follow these steps:  

1. Create an Administrative Template (ADM) file for the MaxTokenSize registry entry. To do it, follow these steps:  

    1. Start Notepad.
    2. Copy the following text, and then paste the text into Notepad:  

        >CLASS MACHINE
        >
        >CATEGORY !!KERB
        >
        >KEYNAME "SYSTEM\CurrentControlSet\Control\Lsa\Kerberos\Parameters"  
         POLICY !!MaxToken  
         VALUENAME "MaxTokenSize"  
         VALUEON NUMERIC 48000  
         VALUEOFF NUMERIC 0  
         END POLICY  
        >
        >END CATEGORY
        >
        >[strings]  
        KERB="Kerberos Maximum Token Size"  
        MaxToken="Kerberos MaxTokenSize"  

        > [!NOTE]
        > The value of the MaxTokenSize registry entry is set to 48000. This is the suggested value.  

    3. Save the Notepad document as MaxTokenSize.adm in the %windir%\Inf\ folder on the domain controller that you will use to configure the GPO to deploy the setting.
    4. Exit Notepad.
2. Import the ADM into a GPO and set the MaxTokenSize registry entry to the desired value. To do it, follow these steps:  

    1. Create a new Group Policy Object (GPO) that is linked at the domain level or that is linked to the organizational unit (OU) that contains your computer accounts. Or, select a GPO that is already deployed.
    2. Open the Group Policy Object Editor. To do it, click Start, click Run, type gpedit.msc, and then click OK.
    3. In the console tree, expand Computer Configuration, expand Administrative Templates, and then click Administrative Templates.
    4. On the Action menu, point to All Tasks, and then click Add/Remove Templates.
    5. Click Add.
    6. Click to select the MaxTokenSize.adm file that you created in step 1, and then click Open.
    7. Click Close.
    8. On the View Menu, click Filtering.
    9. Click to clear the Only show policy settings that can be fully managed check box, and then click OK.
    10. Expand Administrative Templates, and then click Kerberos Maximum Token Size.
    11. Right-click Kerberos MaxTokenSize in the right-side pane, then click Properties to open the Properties dialog box.
    12. Click Enabled, and then click OK.

        > [!NOTE]
        > For the GPO take effect, the GPO change must be replicated to all domain controllers in the domain, and affected computers must be restarted after the policy is applied to them.

### How to configure the MaxTokenSize registry entry by using GPO in Windows Server 2008 and in Windows Server 2008 R2

In Windows Server 2008 domains and in Windows Server 2008 R2 domains, you can use the Registry Client-Side Extension to deploy the MaxTokenSize registry value to multiple computers in a domain. To create the MaxTokenSize value setting in a GPO, follow these steps:  

1. Click Start, click Run, type gpmc.msc, and then click OK to open the Group Policy Management Console.
2. In the Group Policy Management Console, create a new GPO that is linked at the domain level or that is linked to the OU that contains your computer accounts. Or you can select a GPO that is already deployed.
3. Right-click the GPO, and then click Edit to open the Group Policy Management Editor window.
4. Expand Computer Configuration, expand Preferences, and then expand Windows Settings.
5. Right-click Registry, point to New, and then click Registry Item. The New Registry Properties dialog box appears.
6. In the Action list, click Create.
7. In the Hive list, click HKEY_LOCAL_MACHINE.
8. In the Key Path list, click SYSTEM\CurrentControlSet\Control\Lsa\Kerberos\Parameters.
9. In the Value name box, type MaxTokenSize.
10. In the Value type box, click to select the REG_DWORD check box.
11. In the Value data box, type 48000.
12. Next to Base, click to select the Decimal check box.
13. Click OK.

>[!NOTE]
>For the GPO take effect, the GPO change must be replicated to all domain controllers in the domain, and affected computers must be restarted after they apply the policy.

### How to configure the MaxTokenSize registry entry by using GPO in Windows Server 2012

To deploy the value of the MaxTokenSize registry entry in a domain that has Windows Server 2012-based domain controllers, follow these steps:  

1. Open Server Manager, click Tools, and then click Group Policy Management to open the Group Policy Management console.
2. In the Group Policy Management Console, create a new GPO that is linked at the domain level or that is linked to the OU that contains your computer accounts. Or, select a GPO that is already deployed.
3. Right-click the GPO, and then click Edit to open the Group Policy Management Editor window.
4. Expand Computer Configuration, expand Policies, and then expand Administrative Templates.
5. Expand System, and then click Kerberos.  
6. Right-click Set maximum Kerberos SSPI context token buffer size on the right side pane, and then click Edit.
7. Click Enabled, and then type 48000 in the Maximum size box.
8. Click OK.  

>[!Note]  
>
>- For the GPO take effect, the GPO change must be replicated to all domain controllers in the domain, and affected computers must be restarted after they apply the policy.  
>
>- The Set maximum Kerberos SSPI context token buffer size policy setting is added in Windows Server 2012 and in Windows 8. The policy setting is supported in Windows XP, in Windows Server 2003, in Windows Vista, in Windows Server 2008, in Windows 7, and in Windows Server 2008 R2. To use this Group Policy setting, you must edit the GPO in a version of Windows Server 2012 or in Windows 8 that has the RSAT tools installed.

## References

For more information about the MaxTokenSize registry entry, click the following article number to view the article in the Microsoft Knowledge Base:  
[327825](https://support.microsoft.com/help/327825) New resolution for problems with Kerberos authentication when users belong to many groups
