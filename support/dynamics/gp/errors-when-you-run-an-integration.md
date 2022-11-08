---
title: Errors when you run an integration
description: Provides solution to errors that occur when you run an integration in Integration Manager for Microsoft Dynamics GP.
ms.reviewer: kvogel, dlanglie
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# Error messages when you run an integration in Integration Manager for Microsoft Dynamics GP

This article provides solution to errors that occur when you run an integration in Integration Manager for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 942750

## Symptoms

When you run an integration in Integration Manager for Microsoft Dynamics, you may receive one or more of the following error messages.

Error message 1

> The destination could not be initialized due to the following problem: Object reference not set to an instance of an object.

Error message 2

> The destination could not be initialized due to the following problem: Unable to cast COM object of type 'System_ComObject' to interface type 'Dynamics Application'. This operation failed because the Queryinterface call on the COM component for the interface with IID '{6D016638-BA35-11CF-827E-00001B27AB13}' failed due to the following error: Error loading type library/DLL. (Exception from HRESULT: 0X80029C4A (TYPE_E_CANTLOADLIBRARY))'

Error message 3

> The destination could not be initialized due to the following problem. 'DOC 1 ERROR: Unable to cast COM object of type 'MSScriptControl.ScriptControlClass' to interface type 'MSScriptControl.IScriptControl'. This operation failed because the QueryInterface call on the COM component for the interface with IID '{0E59F1D3-1FBE-11D0-8FF2-00A0D10038BC}' failed due to the following error: Error loading type library/DLL. (Exception from HRESULT: 0x80029C4A (TYPE_E_CANTLOADLIBRARY)).'

## Resolution

1. To resolve this problem, use the appropriate resolution.

### Resolution 1

To resolve this problem, obtain the latest update for Integration Manager. Follow the instructions that are in the Readme.txt file that is included in the update.

### Resolution 2

- Integration Manager for Microsoft Dynamics GP 10.0

    To resolve this problem, use the **Add or Remove Programs** item in Control Panel to repair Microsoft Dynamics GP 10.0.

    To do it in Windows Vista or Windows 7, select **Start**, type control in the **Start** Search box, and then select **Add or Remove Programs** in the Programs list. Select **Microsoft Dynamics GP 10.0**, select **Change**, and then select **Repair**.

- Integration Manager for Microsoft Dynamics GP 2010

    To resolve this problem, use the **Add or Remove Programs** item in Control Panel to repair Microsoft Dynamics GP 2010.

    To do it in Windows Vista or Windows 7, select **Start**, type control in the **Start** Search box, and then select **Add or Remove Programs** in the Programs list. Select **Microsoft Dynamics GP 2010**, select **Change**, and then select **Repair**.

    > [!NOTE]
    > If you're prompted for an administrator password or for a confirmation, type the password, or select **Allow**.

### Resolution 3

To resolve this problem, reregister the MSScript.ocx file. To do it, follow these steps:

1. Sign in to the computer as the domain administrator. The domain administrator must have full administrator permissions.

2. Register the MSScript.ocx file. To do it, select **Start**, select **Run**, type `regsvr32 C:\Windows\System32\MSScript.ocx` in the Open box, and then select **OK**.
    > [!NOTE]
    > If you're on a 64-bit computer, use this command:  
        `regsvr32 C:\Windows\sysWOW64\MSScript.ocx`.

3. Run an integration as the domain administrator.
