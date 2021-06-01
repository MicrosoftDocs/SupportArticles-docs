---
title: Outlook Client Language Packs cannot be installed
description: This article provides a resolution for the problem that occurs after you install the Critical Update for the Microsoft Dynamics CRM 2011 Outlook Client Language Pack. 
ms.reviewer: debrau
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Microsoft Dynamics CRM 2011 Outlook Client Language Packs cannot be installed through Windows Update

This article helps you resolve the problem that occurs after you install the Critical Update for the Microsoft Dynamics CRM 2011 Outlook Client Language Pack.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2901828

## Symptoms

After you install the Critical Update for the Microsoft Dynamics CRM 2011 Outlook Client Language Pack, newer Language Pack Update Rollups are not retrieved by Windows Update or System Center Configuration Manager. However, newer Language Pack Update Rollups can be manually installed.

## Cause

The Critical Update patch does not allow newer Language Pack Update Rollups to be retrieved by Windows Update due to the presence of the `<blockFromUpdateKBs>` parameter in the MSI config.xml. This is by design.

## Resolution

Remove the Critical Update patch from the Language Pack installation. This can be accomplished using the steps below:

1. Click **Start** and then click **Run**.

2. Type *CMD* in the run window, click **Ok**.

3. In the **Command Prompt** window, enter the following command-line parameter:

    ```console
    msiexec.exe /uninstall {F1DC5663-5DD1-4E2A-A662-E26E8F5B7741} /package {0C524D20-0409-0050-8A9E-0C4C490E4E54}
    ```

## More information

The Critical Update patch for the Microsoft Dynamics CRM 2011 Outlook client installation can be removed using the following command-line parameter:

```console
msiexec.exe /uninstall {F1DC5663-5DD1-4E2A-A662-E26E8F5B7741} /package {0C524D20-0409-0050-8A9E-0C4C490E4E54}
```
