---
title: Introduction to TroubleShootingScript toolset (TSSv2)
description: Introduces the TroubleShootingScript Version 2 (TSSv2) toolset and provides answers to frequently asked questions about the toolset.
ms.date: 03/31/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika, muratka, waltere
ms.custom: sap:windows-troubleshooters, csstroubleshoot
ms.technology: windows-client-troubleshooter
---
# Introduction to TroubleShootingScript toolset (TSSv2)

This article introduces the TroubleShootingScript Version 2 (TSSv2) toolset and provides answers to frequently asked questions.

_Applies to:_ &nbsp; Supported versions of Windows Server and Windows Client

The TSSv2 toolset includes PowerShell-based tools and a framework for data collection and diagnostics. The toolset aims to resolve customer support cases efficiently and securely.

The toolset includes several PowerShell scripts and executable files, which are all signed by Microsoft. Depending on how the toolset is started, it uses one or more of those scripts and executables to collect the required logs.

You can download the toolset as a zip file (*TSSv2.zip*) from https://aka.ms/getTSS.  

## Prerequisites

Here are some prerequisites for the toolset to run properly:

- The TSSv2 toolset must be run by accounts with administrator privileges on the local system, and the end-user license agreement (EULA) must be accepted. Once the EULA is accepted, the TSSv2 toolset won't prompt the EULA again.

- The PowerShell script execution policy should be set to `RemoteSigned` for the process level by running the cmdlet `Set-ExecutionPolicy -scope Process -ExecutionPolicy RemoteSigned -Force` from an elevated PowerShell command prompt.

    > [!NOTE]  
    > The process level changes only affect the current PowerShell session.

## Logs collection and sharing process

The TSSv2 toolset supports collecting various logs for troubleshooting purposes. Microsoft support representatives may provide you with a certain TSSv2 cmdlet to collect logs for a problem when working on a support case, such as:

- Event logs
- System configuration
- Configuration details for installed Microsoft services
- Performance monitor logs
- Windows Performance Recorder (WPR) traces
- Network traces
- Memory dumps
- Event Tracing for Windows (ETW) traces for various components

Here are the steps for the logs collection and sharing process:

> [!NOTE]
> The support representative will provide you with complete steps for downloading and data collection.

1. The support representative identifies the problem and provides a certain TSSv2 cmdlet to collect the proper logs.
2. Download the *TSSv2.zip* file and copy the file to the affected systems.
3. Extract the *TSSv2.zip* file to a local folder in the affected systems, and run the TSSv2 cmdlet(s) from an elevated PowerShell command prompt simultaneously.  
4. When the issue is reproduced, stop the TSSv2 toolset by pressing any key. The logs are automatically zipped by TSSv2 afterwards.
5. Upload the logs to a Microsoft secure file transfer site, which the support representative provides.

The support representative will work on the logs for further troubleshooting and provide the next action plan.

## Frequently asked questions (FAQs)

- Q1: Does the TSSv2 script change any setup or configuration of my system?

    A1: No, but a registry setting is required for enabling debug logging in some scenarios. The script sets the necessary key at the start of the data collection and reverts the key to the default value at the end of the data collection. It may also delete some caches (for example, the ARP cache or the name resolution cache) at the start of the data collection to observe the problem from the logs.

- Q2: Does the TSSv2 toolset put an additional load on the server?

    A2: Some loggings (for example, network capturing, ETW tracing collection, and so on) that are started by the TSSv2 toolset might put a minor load on the system. The load is usually at ignorable levels. Contact your support representative when you see high CPU, memory, or disk usage after starting the TSSv2 toolset.

- Q3: Why can't we reproduce the issue when the TSSv2 toolset is running?

    A3: The TSSv2 toolset may delete all cached information at the start. It also starts the network capturing in a promiscuous mode, which changes the Network Interface Card (NIC) default behaviors. These changes might affect the issue, and the problems may disappear. Especially for particular timing issues, problems disappear because of the TSSv2 toolset's data collection. The data collection starts logging, which might affect the issue indirectly and change the situation.

- Q4: Why is the TSSv2 toolset not responding for a long time?

    A4: In some cases, the operating system's built-in commands run by the TSSv2 toolset might not respond or take a long time to complete. Contact your support representative if you experience this issue.

- Q5: Do I need to worry about disk space or anything else when I run the TSSv2 toolset for a long time?

    A5: All TSSv2 tracing is configured to run with ring buffers, so you can run the toolset for a long time if needed. The TSSv2 toolset also calculates disk space at the beginning of the data collection and may exit if there isn't sufficient disk space. If you see high disk usage after starting the TSSv2 toolset or have any other concerns about the disk usage of the toolset, contact your support representative.

- Q6: What should I do if I receive the following security warning when running the *.\\TSSv2.ps1* script?

    `Security Warning: Run only scripts that you trust. While scripts from the Internet can be useful, this script can potentially harm your computer. Do you want to run .\TSSv2.ps1? [D] Do not run [R] Run once [S] Suspend [?] Help (default is "D")`

    A6: In rare situations, you may receive this security warning. You may unblock the script by using the cmdlet `PS C:\> Unblock-File -Path C:\TSSv2\TSSv2.ps1`. This script will unblock all other modules by using the cmdlet `Get-ChildItem -Recurse -Path C:\TSSv2\*.ps* | Unblock-File -Confirm:$false`.

## End User License Agreement (EULA)

Select below to view MICROSOFT SOFTWARE LICENSE TERMS.
<br>
<details>
<summary><b>Microsoft Diagnostic Scripts and Utilities</b></summary>

These license terms are an agreement between you and Microsoft Corporation (or one of its affiliates). IF YOU COMPLY WITH THESE LICENSE TERMS, YOU HAVE THE RIGHTS BELOW. BY USING THE SOFTWARE, YOU ACCEPT THESE TERMS.

1. INSTALLATION AND USE RIGHTS. Subject to the terms and restrictions set forth in this license, Microsoft Corporation ("Microsoft") grants you ("Customer" or "you") a non-exclusive, non-assignable, fully paid-up license to use and reproduce the script or utility provided under this license (the "Software"), solely for Customer's internal business purposes, to help Microsoft troubleshoot issues with one or more Microsoft products, provided that such license to the Software does not include any rights to other Microsoft technologies (such as products or services). "Use" means to copy, install, execute, access, display, run or otherwise interact with the Software.  

    You may not sublicense the Software or any use of it through distribution, network access, or otherwise. Microsoft reserves all other rights not expressly granted herein, whether by implication, estoppel or otherwise. You may not reverse engineer, decompile or disassemble the Software, or otherwise attempt to derive the source code for the Software, except and to the extent required by third party licensing terms governing use of certain open source components that may be included in the Software, or remove, minimize, block, or modify any notices of Microsoft or its suppliers in the Software. Neither you nor your representatives may use the Software provided hereunder: (i) in a way prohibited by law, regulation, governmental order or decree; (ii) to violate the rights of others; (iii) to try to gain unauthorized access to or disrupt any service, device, data, account or network; (iv) to distribute spam or malware; (v) in a way that could harm Microsoft's IT systems or impair anyone else's use of them; (vi) in any application or situation where use of the Software could lead to the death or serious bodily injury of any person, or to physical or environmental damage; or (vii) to assist, encourage or enable anyone to do any of the above.
2. DATA. Customer owns all rights to data that it may elect to share with Microsoft through using the Software. You can learn more about data collection and use in the help documentation and the privacy statement at https://aka.ms/privacy. Your use of the Software operates as your consent to these practices.
3. FEEDBACK. If you give feedback about the Software to Microsoft, you grant to Microsoft, without charge, the right to use, share and commercialize your feedback in any way and for any purpose.  You will not provide any feedback that is subject to a license that would require Microsoft to license its software or documentation to third parties due to Microsoft including your feedback in such software or documentation.  
4. EXPORT RESTRICTIONS. Customer must comply with all domestic and international export laws and regulations that apply to the Software, which include restrictions on destinations, end users, and end use. For further information on export restrictions, visit https://aka.ms/exporting.
5. REPRESENTATIONS AND WARRANTIES. Customer will comply with all applicable laws under this agreement, including in the delivery and use of all data. Customer or a designee agreeing to these terms on behalf of an entity represents and warrants that it (i) has the full power and authority to enter into and perform its obligations under this agreement, (ii) has full power and authority to bind its affiliates or organization to the terms of this agreement, and (iii) will secure the permission of the other party prior to providing any source code in a manner that would subject the other party's intellectual property to any other license terms or require the other party to distribute source code to any of its technologies.
6. DISCLAIMER OF WARRANTY. THE SOFTWARE IS PROVIDED "AS IS," WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL MICROSOFT OR ITS LICENSORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THE SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
7. LIMITATION ON AND EXCLUSION OF DAMAGES. IF YOU HAVE ANY BASIS FOR RECOVERING DAMAGES DESPITE THE PRECEDING DISCLAIMER OF WARRANTY, YOU CAN RECOVER FROM MICROSOFT AND ITS SUPPLIERS ONLY DIRECT DAMAGES UP TO U.S. .00. YOU CANNOT RECOVER ANY OTHER DAMAGES, INCLUDING CONSEQUENTIAL, LOST PROFITS, SPECIAL, INDIRECT, OR INCIDENTAL DAMAGES. This limitation applies to (i) anything related to the Software, services, content (including code) on third party Internet sites, or third party applications; and (ii) claims for breach of contract, warranty, guarantee, or condition; strict liability, negligence, or other tort; or any other claim; in each case to the extent permitted by applicable law. It also applies even if Microsoft knew or should have known about the possibility of the damages. The above limitation or exclusion may not apply to you because your state, province, or country may not allow the exclusion or limitation of incidental, consequential, or other damages.
8. BINDING ARBITRATION AND CLASS ACTION WAIVER. This section applies if you live in (or, if a business, your principal place of business is in) the United States.  If you and Microsoft have a dispute, you and Microsoft agree to try for 60 days to resolve it informally. If you and Microsoft can't, you and Microsoft agree to binding individual arbitration before the American Arbitration Association under the Federal Arbitration Act ("FAA"), and not to sue in court in front of a judge or jury. Instead, a neutral arbitrator will decide. Class action lawsuits, class-wide arbitrations, private attorney-general actions, and any other proceeding where someone acts in a representative capacity are not allowed; nor is combining individual proceedings without the consent of all parties. The complete Arbitration Agreement contains more terms and is at https://aka.ms/arb-agreement-4. You and Microsoft agree to these terms.  
9. LAW AND VENUE. If U.S. federal jurisdiction exists, you and Microsoft consent to exclusive jurisdiction and venue in the federal court in King County, Washington for all disputes heard in court (excluding arbitration). If not, you and Microsoft consent to exclusive jurisdiction and venue in the Superior Court of King County, Washington for all disputes heard in court (excluding arbitration).
10. ENTIRE AGREEMENT. This agreement, and any other terms Microsoft may provide for supplements, updates, or third-party applications, is the entire agreement for the software.
    
</details>
