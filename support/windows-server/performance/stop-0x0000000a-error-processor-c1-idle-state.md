---
title: You may receive a "Stop 0x0000000A" error message when a processor resumes from a C1 idle state
description: Provides a workaround for the error message "Stop 0x0000000A" when a processor resumes from a C1 idle state
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:blue-screen/bugcheck, csstroubleshoot
ms.subservice: performance
---
# You may receive a "Stop 0x0000000A" error message when a processor resumes from a C1 idle state

This article provides a workaround for the error message "Stop 0x0000000A" when a processor resumes from a C1 idle state.  

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 908369

## Symptoms

When a processor on a Microsoft Windows Server 2003-based computer resumes from a C1 idle state, the computer may stop responding. Additionally, you may experience one or more of the following symptoms:

- The computer automatically restarts.
- After you log on, you receive the following error message:  
  >Microsoft Windows  
  The system has recovered from a serious error.  
  A log of this error has been created.  
  Please tell Microsoft about this problem.  
  We have created an error report that you can send to help us improve Microsoft Windows. We will treat this report as confidential and anonymous.  
  To see what data this error report contains, click here.

  If the error message still appears and if you want to see the data that the error report contains, click the **Click here** link at the bottom of the message box. You then see error-signature information that is similar to the following:  
  > BCCode : 0000000A BCP1 : 0f6ff8c0 BCP2 : 000000ff BCP3 : 00000000 BCP4 : 8074867e OSVer : 5_2_3718 SP : 0_0 Product : 272_3

- You receive the following "Stop" error message on a blue screen:  
  > A problem has been detected and Windows has been shut down to prevent damage to your computer.  
  Technical information:  
  *** STOP: 0x0000000A (0x0f6ff8c0, 0x000000ff, 0x00000000, 0x8074867e)  
  IRQL_Not_Less_Or_Equal

- An error message that is similar to the following is logged in the System event log:  
  > Date: **date**  
    Source: System
    ErrorTime: **time**  
    Category: (102)  
    Type: Error  
    Event ID: 1003  
    User: N/A  
    Computer: **computer**  
    Description: Error code 0000000A, parameter1 0f6ff8c0, parameter2 000000ff, parameter3 00000000, parameter4 8074867e.For more information, see Help and Support Center at `https://support.microsoft.com.Data:0000:` 53 79 73 74 65 6d 20 45 System E0008: 72 72 6f 72 20 20 45 72 rror Er0010: 72 6f 72 20 63 6f 64 65 ror code0018: 20 30 30 30 30 30 30 35 00000 0A0020: 30 20 20 50 61 72 61 6d 0 Param0028: 65 74 65 72 73 20 66 66 eters ff0030: 66 66 66 66 64 31 2c

> [!NOTE]
>
> - The symptoms of a "Stop" error vary according to the computer's system failure options. For more information, click the following article number to view the article in the Microsoft Knowledge Base:
[307973](https://support.microsoft.com/help/307973) How to configure system failure and recovery options in Windows  
> - The four parameters that are included in the error signature information vary according to the computer's configuration.
> - Not all "Stop 0x0000000A" errors are caused by the problem that this article describes.

## Cause

This problem occurs because of a processor bug in some CPUs.

Instruction bytes are read into the instruction cache in fixed-size blocks (cache lines). When the bytes that make up an instruction cross a cache line boundary, the instruction bytes occupy multiple adjacent cache lines. If a certain specific processor error occurs, the processor may read in the second part of the instruction from the wrong cache line for execution. This behavior causes an incorrect instruction.

The Ntkrnlmp.exe file that is included in hotfix 840987 includes a sequence of instructions that reveal this bug.

> [!NOTE]
> This problem occurs only when the processor is handling an interprocessor interrupt (IPI) that causes the processor to resume from the C1 idle state.

## Workaround

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

To work around this problem, prevent the processor from entering the C1 idle state. To do this, follow these steps:

1. Start Registry Editor. To do this, click **Start**, click **Run**, type *regedt32*, and then click **OK**.
2. Locate and then click the following registry subkey: `HKEY_LOCAL_MACHINE\System\CurrentControlset\Control\Session Manager\Power`

3. Click **Edit**, point to **New**, click **DWORD Value**, and then type *IdleFrom0IdlePercent*.
4. Right-click **IdleFrom0IdlePercent**, and then click **Modify**. In the **Edit DWORD Value** dialog box, type a number that is more than 100 in the **Value data** box, click **Decimal** under **Base**, and then click **OK**.
    > [!NOTE]
    > The following two registry subkeys control when Windows causes the processor to enter a C1 idle state:
    `HKEY_LOCAL_MACHINE\System\CurrentControlset\Control\Session Manager\Power\IdleFrom0Delay`
    `HKEY_LOCAL_MACHINE\System\CurrentControlset\Control\Session Manager\Power\IdleFrom0IdlePercent`  
    For example, assume that you have set the IdleFrom0IdlePercent value to 10 and the IdleFrom0Delay value to 5. In this case, the system must be 10 percent idle over a period of 5 micrososeconds before the CPU enters the C1 idle state. Therefore, if you set the IdleFrom0IdlePercent value to a number that is more than 100, the CPU will never enter the C1 idle state.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.
