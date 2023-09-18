---
title: Fail to insert a smart card in a reader
description: Provides a solution to an error that occurs when you insert a smart card in a reader.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:devices-and-drivers, csstroubleshoot
ms.technology: windows-server-deployment
---
# Error message when you insert a smart card in a reader: Device driver software was not successfully installed

This article provides a solution to an error that occurs when you insert a smart card in a reader.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 976832

## Symptoms

When you insert a smart card into a smart card reader, Windows tries to download and install the smart card minidrivers for the card through Plug and Play services. If the driver for the smart card is not available at any of the preconfigured locations, such as Windows Update, WSUS, or intranet paths, and a custom Crypto service provider is not already installed on the system, you receive the following error message in the notification area:

> Device driver software was not successfully installed
>
> Click here for details.

This error message disappears after several seconds.

Additionally, in Device Manager, under **Other devices**, the Smart Card device has a status of *DNF* (Driver not found).

This frequently requires the user to obtain one of the following items from the smart card issuer to resolve this error:

1. A Windows logged smart card minidriver.
2. A custom cryptographic service provider (CSP) for the Smart card.
3. A Windows non-logoed smart card minidriver.
4. Other middleware such as an ActiveX control, PKCS#11 software, or other custom software.

However, if the user is provided with only item 3 or 4 from this list, the smart card continues to work on the system. However, the user will receive the error message that is mentioned in this section every time that they insert the smart card.

This issue affects all releases of Windows 7, Windows Server 2008 R2, and in later versions of both operating systems.

## Cause

All smart cards require additional software to work in Windows unless there is an inbox driver that lets the user use the card without installing additional software. The Windows Smart Card Framework was improved in Windows 7 to enable the automatic downloading of smart card minidrivers from Windows Update or from other similar locations such as a WSUS server when the smart card is inserted into the reader. All smart cards that successfully pass the logo requirements, as published by the Windows Logo Program, benefit from this feature.

However, if the software that is required to use a smart card in Windows is not logoed or is of a type that differs from a minidriver, such as a PKCS#11 driver, a custom CSP, middleware, or an ActiveX control, the automatic download option fails because Microsoft certifies only smart card minidrivers. Therefore, if the user inserts a card for which a custom CSP is not already registered, the user receives an error message that states that the driver software is missing for the smart card device even though the user can use the smart card through additional software that was installed on the user's computer from a custom installation.

## Resolution

Although the smart cards continue to work despite the error message that the user sees, a smart card issuer, vendor, or manufacturer can use one of the following methods to resolve this error.

### Implement a smart card minidriver

We recommend that card issuers, vendors, and manufacturers implement smart card minidrivers and participate in the Windows Logo Program to benefit from the improvements that are introduced in the platform such as Smart Card Plug and Play, Device Stage for Smart Cards, and so on.

### Implement a NULL driver for your smart card

If custom software such a PKCS#11 driver, an ActiveX control, or some other middleware is required to enable the use of smart card on Windows, and implementing a smart card minidriver or a custom CSP is not a practical option, we recommend that card issuers, vendors, or manufacturers consider submitting NULL drivers to Windows Update. The typical process for making sure that a NULL driver is available on Windows Update requires a successful unclassified device submission through Winqual. If in the future, there is a minidriver available for these cards, the new driver can be uploaded to Windows Update by participating in the Windows Logo Program. The NULL drivers can then be manually downloaded by the end users or can made available by using optional updates.

The following is a sample template for a NULL driver for a smart card.

```ini
;  
; Null Driver for Fabrikam Smartcard installation x86 and x64 package.  
;

[Version]  
Signature="$Windows NT$"  
Class=SmartCard  
ClassGuid={990A2BD7-E738-46c7-B26F-1CF8FB9F1391}  
Provider=%ProviderName%  
CatalogFile=delta.cat  
DriverVer=4/21/2006,1.0.0.0

[Manufacturer]  
%ProviderName%=Minidriver,NTamd64,NTamd64.6.1,NTx86,NTx86.6.1

[Minidriver.NTamd64]  
;This driver has no applicability on OS versions earlier than Windows 7

[Minidriver.NTx86]  
;This driver has no applicability on OS versions earlier than Windows 7

[Minidriver.NTamd64.6.1]  
%CardDeviceName%=Minidriver64_Install,<DEVICE_ID>  
;%CardDeviceName%=Minidriver64_Install,<DEVICE_ID2>  
;%CardDeviceName%=Minidriver64_Install,<DEVICE_ID3>  
;...

[Minidriver.NTx86.6.1]  
%CardDeviceName%=Minidriver32_Install,<DEVICE_ID>  
;%CardDeviceName%=Minidriver32_Install,<DEVICE_ID2>  
;%CardDeviceName%=Minidriver32_Install,<DEVICE_ID3>  
;...

;Leave the following sections blank  
[DefaultInstall]  
[DefaultInstall.ntamd64]  
[DefaultInstall.NTx86]  
[DefaultInstall.ntamd64.6.1]  
[DefaultInstall.NTx86.6.1]  
[Minidriver64_Install.NT]  
[Minidriver64_61_Install.NT]  
[Minidriver32_Install.NT]  
[Minidriver32_61_Install.NT]

[Minidriver64_61_Install.NT.Services]  
AddService = ,2

[Minidriver32_61_Install.NT.Services]  
AddService = ,2

; =================== Generic ==================================

[Strings]  
ProviderName ="Microsoft"  
CardDeviceName="Fabrikam Generic Smart card"
```

To generate the hardware device ID that is referenced by the DEVICE_ID string in the sample, follow the instructions in the smart card minidriver's specification.

For detailed information about how to submit a NULL driver to Microsoft, please contact Microsoft Customer Support Services.

### Disable Smart Card Plug and Play through Group Policy for managed computers

This option is recommended only for enterprise deployments where the computers are managed by administrators and all the necessary software to work with the smart cards that are being used in the enterprise is installed by using software management tools such as SMS.

This procedure is discouraged in the following environments because it will affect all the smart cards in your environment:

- Commercial deployments that target end-users, such as online banking.
- Environments that include both Plug and Play smart cards and non-Plug and Play smart cards that use Group Policy to disable Plug and Play for smart cards.

Smart Card Plug and Play can be disabled in enterprises where the end user's computer is managed by mechanisms such as Group Policy.

If your deployment uses only non-Plug and Play smart card solutions, Smart Card Plug and Play can be disabled by a local administrator on a client computer. Disabling Smart Card Plug and Play prevents smart card drivers, also known as smart card minidrivers, from downloading. It also prevents Smart Card Plug and Play prompts.

To disable Smart Card Plug and Play in local Group Policy, follow these steps:

1. Click **Start**, type gpedit.msc in the **Search programs and files** box, and then press ENTER.

2. In the console tree under **Computer Configuration**, click **Administrative Templates**.

3. In the details pane, double-click **Windows Components**, and then double-click **Smart Card**.

4. Right-click **Turn on Smart Card Plug and Play service**, and then click **Edit**.

5. Click **Disabled**, and then click **OK**.

### Change the end user's system and disable Smart Card Plug and Play for specific cards

This is the least-recommended option. You should use this option only if the cards are legacy cards and there are no plans to implement smart card minidrivers in future. This option requires that the existing software that is already installed on the system notify Windows that there is a custom CSP installed on the system even though no such CSP exists on the end-user system. As soon as Windows determines that there is a custom CSP already installed on the system, Windows does not try to download and install a driver through Smart Card Plug and Play. No device node for the smart card device is created that is visible in Device Manager. This option results in the following changes to the system registry:

Subkey: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography\Calais\SmartCards\<Smart card name>`

Subkey registry entries:

- ATR=Hexadecimal DWORD: Comma delimited ATR of the smart card.

- ATRMask= Hexadecimal DWORD: Comma delimited mask to apply to the ATR to mask out insignificant bytes in the ATR.

- Crypto Provider=String value: Some string relevant to your smart card.

For example:

Subkey: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography\Calais\SmartCards\Fabrikam ATM card`

Subkey registry entries:

- ATR=Hexadecimal DWORD: 3b,dc,13,00,40,3a,49,54,47,5f,4d,53,43,53,50,5f,56,32
- ATRMask= Hexadecimal DWORD: ff,ff,ff,ff,ff,ff,ff,ff,ff,ff,ff,ff,ff,ff,ff,ff,ff,ff
- Crypto Provider=String value: Fabrikam ATM Dummy Provider

For x64-bit systems, identical changes must be made under the following subkey:  `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Cryptography\Calais\SmartCards`

We recommend that, instead of directly changing the system registry, you use WinSCard APIs to introduce these changes to the system. Here is sample code example that detects smart card insertion and then disables Smart Card Plug and Play for the particular card by creating a registry entry that associates the card with a non-existing provider.

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure. However, they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.

```cpp
//==============================================================;
//
// Disable Smart card Plug and Play for specific cards
//
// Abstract:
// This is an example of how to create a new
// Smart Card Database entry when a smart card is inserted
// into the computer.
//
// This source code is only intended as a supplement to existing Microsoft
// documentation.
//
// THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY
// KIND, EITHER EXPRESSED OR IMPLIED. THIS INCLUDES BUT NOT LIMITED TO THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
// PURPOSE.
//
// Copyright (C) Microsoft Corporation. All Rights Reserved.
//==============================================================;

// This code must be compiled with UNICODE support to work correctly
#ifndef UNICODE
#define UNICODE
#endif

#include <windows.h>
#include <winscard.h>
#include <stdio.h>
#include <strsafe.h>
#include <rpc.h>

// Change this prefix to specify what the beginning of the
// introduced card name in the registry will be. This is
// be prepended to a GUID value.
#define CARD_NAME_PREFIX L"MyCustomCard"

// This is the name that will be provided as the CSP for 
// the card when introduced to the system. This is provided
// in order to disable Smart Card Plug and Play for this
// card.
#define CARD_CSP L"$DisableSCPnP$"

// This special reader name is used to be notified when
// a reader is added to or removed from the system through
// SCardGetStatusChange.
#define PNP_READER_NAME L"\\\\?PnP?\\Notification"

// Maximum ATR length plus alignment bytes. This value is
// used in the SCARD_READERSTATE structure
#define MAX_ATR_LEN 36

LONG GenerateCardName(
 __deref_out LPWSTR *ppwszCardName)
{
    LONG lReturn = NO_ERROR;
    HRESULT hr = S_OK;
    DWORD cchFinalString = 0;
    WCHAR wszCardNamePrefix[] = CARD_NAME_PREFIX;
    LPWSTR pwszFinalString = NULL;
    UUID uuidCardGuid = {0};
    RPC_WSTR pwszCardGuid = NULL;
    RPC_STATUS rpcStatus = RPC_S_OK;

    // Parameter check
    if (NULL == ppwszCardName)
    {
    wprintf(L"Invalid parameter in GenerateCardName.\n");
    return ERROR_INVALID_PARAMETER;
    }

    // Generate GUID
    rpcStatus = UuidCreate(&uuidCardGuid);
    if (RPC_S_OK != rpcStatus)
    {
    wprintf(L"Failed to create new GUID with error 0x%x.\n");
    lReturn = (DWORD)rpcStatus;
    }
     else
     {
         // Convert GUID to string
         rpcStatus = UuidToString(&uuidCardGuid, &pwszCardGuid);
         if (RPC_S_OK != rpcStatus)
         {
             wprintf(L"Failed to convert new GUID to string with error 0x%x.\n", rpcStatus);
             lReturn = (DWORD)rpcStatus;
         }
         else
         {
             // Allocate memory for final string
             // Template is <prefix>-<guid>
             cchFinalString = (DWORD)(wcslen(wszCardNamePrefix) + 1 + wcslen((LPWSTR)pwszCardGuid) + 1);
             pwszFinalString = (LPWSTR)HeapAlloc(GetProcessHeap(), 0, cchFinalString * sizeof(WCHAR));
             if (NULL == pwszFinalString)
             {
                 wprintf(L"Out of memory.\n");
                 lReturn = ERROR_OUTOFMEMORY;
             }
             else
             {
                 // Create final string
                 hr = StringCchPrintf(
                 pwszFinalString,
                 cchFinalString,
                 L"%s-%s",
                 wszCardNamePrefix,
                 pwszCardGuid);
                 if (FAILED(hr))
                 {
                     wprintf(L"Failed to create card name with error 0x%x.\n", hr);
                     lReturn = (DWORD)hr;
                 }
                 else
                 {
                     // Set output params
                     *ppwszCardName = pwszFinalString;
                     pwszFinalString = NULL;
                 }
             }
         }
     }

    if (NULL != pwszCardGuid)
     {
         RpcStringFree(&pwszCardGuid);
     }

    if (NULL != pwszFinalString)
     {
         HeapFree(GetProcessHeap(), 0, pwszFinalString);
     }

    return lReturn;
}

LONG IntroduceCardATR(
 __in SCARDCONTEXT hSC,
 __in LPBYTE pbAtr,
 __in DWORD cbAtr)
{
    LONG lReturn = NO_ERROR;
    LPWSTR pwszCardName = NULL;

    // Parameter checks
    if (NULL == hSC || NULL == pbAtr || 0 == cbAtr)
    {
    wprintf(L"Invalid parameter in IntroduceCardATR.\n");
    return ERROR_INVALID_PARAMETER;
    }

    // Generate a name for the card
    lReturn = GenerateCardName(&pwszCardName);
    if (NO_ERROR != lReturn)
    {
        wprintf(L"Failed to generate card name with error 0x%x.\n", lReturn);
    }
     else
     {
         // Introduce the card to the system
         lReturn = SCardIntroduceCardType(
         hSC,
         pwszCardName,
         NULL,
         NULL,
         0,
         pbAtr,
         NULL,
         cbAtr);
         if (SCARD_S_SUCCESS != lReturn)
         {
             wprintf(L"Failed to introduce card '%s' to system with error 0x%x.\n", pwszCardName, lReturn);
         }
         else
         {
             // Set the provider name
             lReturn = SCardSetCardTypeProviderName(
             hSC,
             pwszCardName,
             SCARD_PROVIDER_CSP,
             CARD_CSP);
             if (SCARD_S_SUCCESS != lReturn)
             {
                 wprintf(L"Failed to set CSP for card '%s' with error 0x%x.\n", pwszCardName, lReturn);
             }
             else
             {
                 wprintf(L"Card '%s' has been successfully introduced to the system and has had Plug and Play disabled.\n", pwszCardName);
             }
         }
     }

    if (NULL != pwszCardName)
    {
    HeapFree(GetProcessHeap(), 0, pwszCardName);
    }

    return lReturn;
}

LONG ProcessCard(
 __in SCARDCONTEXT hSC,
 __in LPSCARD_READERSTATE pRdr)
{
    LONG lReturn = NO_ERROR;
    DWORD dwActiveProtocol = 0;
    DWORD cbAtr = MAX_ATR_LEN;
    DWORD dwIndex = 0;
    DWORD cchCards = SCARD_AUTOALLOCATE;
    LPWSTR pmszCards = NULL;
    BYTE rgbAtr[MAX_ATR_LEN] = {0};
    SCARDHANDLE hSCard = NULL;

    // Parameter checks
    if (NULL == hSC || NULL == pRdr)
    {
        wprintf(L"Invalid parameter in ProcessCard.\n");
    return ERROR_INVALID_PARAMETER;
     }

    // Connect to the card in the provided reader in shared mode
    lReturn = SCardConnect(
    hSC,
    pRdr->szReader,
    SCARD_SHARE_SHARED,
    SCARD_PROTOCOL_T0 | SCARD_PROTOCOL_T1,
    &hSCard,
    &dwActiveProtocol);
     if (SCARD_S_SUCCESS != lReturn)
     {
         wprintf(L"Failed to connect to card in reader '%s' with error 0x%x.\n", pRdr->szReader, lReturn);
     }
     else
     {
         wprintf(L"Connected to card in reader '%s'.\n", pRdr->szReader);

        /*
         * In this spot, put any necessary calls needed to identify that this
         * is the type of card you are looking for. Usually this is done via
         * SCardTransmit calls. For this example, we will grab the ATR of every
         * inserted card.
         */
    
        // Obtain the ATR of the inserted card
        lReturn = SCardGetAttrib(
        hSCard,
        SCARD_ATTR_ATR_STRING,
        rgbAtr,
        &cbAtr);
         if (SCARD_S_SUCCESS != lReturn)
         {
             wprintf(L"Failed to obtain ATR of card in reader '%s' with error 0x%x.\n", pRdr->szReader, lReturn);
         }
         else
         {
             // Output the ATR
             wprintf(L"ATR of card in reader '%s':", pRdr->szReader);
             for (dwIndex = 0; dwIndex < cbAtr; dwIndex++)
             {
                 wprintf(L" %02x", rgbAtr[dwIndex]);
             }
             wprintf(L"\n");

            // Determine if the ATR is already in the Smart Card Database
             lReturn = SCardListCards(
             hSC,
             rgbAtr,
             NULL,
             0,
             (LPWSTR)&pmszCards,
             &cchCards);
             if (SCARD_S_SUCCESS != lReturn)
             {
                 wprintf(L"Failed to determine if card in reader '%s' is currently recognized by the system with error 0x%x. Skipping.\n", pRdr->szReader, lReturn);
             }
             else if (NULL == pmszCards || 0 == *pmszCards)
             {
                 // Card not found. We need to add it.
                 wprintf(L"Card in reader '%s' is not currently recognized by the system. Adding ATR.\n", pRdr->szReader);
                 lReturn = IntroduceCardATR(
                 hSC,
                 rgbAtr,
                 cbAtr);

                 // If an error occurs here, we will continue so we can try the next time
                 // the card is inserted as well as examine other readers.
             }
            else
            {
                wprintf(L"Card in reader '%s' is already known by the system. Not adding ATR.\n", pRdr->szReader);
            }
         }
     }

    // Disconnect from the card. We do not need to reset it.
    if (NULL != hSCard)
    {
    SCardDisconnect(hSCard, SCARD_LEAVE_CARD);
    }

    // Free resources
    if (NULL != pmszCards)
    {
    SCardFreeMemory(hSC, pmszCards);
    }

    return lReturn;
}

LONG MonitorReaders(
 __in SCARDCONTEXT hSC)
{
    LPWSTR pwszReaders = NULL;
    LPWSTR pwszOldReaders = NULL;
    LPWSTR pwszRdr = NULL;
    DWORD dwRet = ERROR_SUCCESS;
    DWORD cchReaders = SCARD_AUTOALLOCATE;
    DWORD dwRdrCount = 0;
    DWORD dwOldRdrCount = 0;
    DWORD dwIndex = 0;
    LONG lReturn = NO_ERROR;
    BOOL fDone = FALSE;
    SCARD_READERSTATE rgscState[MAXIMUM_SMARTCARD_READERS+1] = {0};
    SCARD_READERSTATE rgscOldState[MAXIMUM_SMARTCARD_READERS+1] = {0};
    LPSCARD_READERSTATE pRdr = NULL;

    // Parameter check
    if (NULL == hSC)
    {
    wprintf(L"Invalid parameter in MonitorReaders.\n");
    return ERROR_INVALID_PARAMETER;
    }

    // One of the entries for monitoring will be to detect new readers
    // The first time through the loop will be to detect whether
    // the system has any readers.
    rgscState[0].szReader = PNP_READER_NAME;
    rgscState[0].dwCurrentState = SCARD_STATE_UNAWARE;
    dwRdrCount = 1;

    while (!fDone)
    {
         while (!fDone)
         {
             // Wait for status changes to occur
             wprintf(L"Monitoring for changes.\n");
             lReturn = SCardGetStatusChange(
             hSC,
             INFINITE,
             rgscState,
             dwRdrCount);
             switch (lReturn)
             {
                 case SCARD_S_SUCCESS:
                 // Success
                 break;
                 case SCARD_E_CANCELLED:
                 // Monitoring is being cancelled
                 wprintf(L"Monitoring cancelled. Exiting.\n");
                 fDone = TRUE;
                 break;
                 default:
                 // Error occurred
                 wprintf(L"Error 0x%x occurred while monitoring reader states.\n", lReturn);
                 fDone = TRUE;
                 break;
             }

            if (!fDone)
             {
                 // Examine the status change for each reader, skipping the PnP notification reader
                 for (dwIndex = 1; dwIndex < dwRdrCount; dwIndex++)
                 {
                     pRdr = &rgscState[dwIndex];

                    // Determine if a card is now present in the reader and
                    // it can be communicated with.
                     if ((pRdr->dwCurrentState & SCARD_STATE_EMPTY ||
                     SCARD_STATE_UNAWARE == pRdr->dwCurrentState) &&
                     pRdr->dwEventState & SCARD_STATE_PRESENT &&
                     !(pRdr->dwEventState & SCARD_STATE_MUTE))
                     {
                         // A card has been inserted and is available.
                         // Grab its ATR for addition to the database.
                         wprintf(L"A card has been inserted into reader '%s'. Grabbing its ATR.\n", pRdr->szReader);
                         lReturn = ProcessCard(hSC, pRdr);

                        // If an error occurs here, we will continue so we can try the next time
                        // the card is inserted as well as examine other readers.
                     }

                    // Save off the new state of the reader
                    pRdr->dwCurrentState = pRdr->dwEventState;
                 }

                // Now see if the number of readers in the system has changed.
                // Save its new state as the current state for the next loop.
                pRdr = &rgscState[0];
                pRdr->dwCurrentState = pRdr->dwEventState;
                if (pRdr->dwEventState & SCARD_STATE_CHANGED)
                {
                    wprintf(L"Reader change detected.\n");
                    break;
                }
            }  
         }

     if (!fDone)
     {
         // Clean up previous loop
         if (NULL != pwszOldReaders)
         {
         SCardFreeMemory(hSC, pwszOldReaders);
         pwszOldReaders = NULL;
         }
         pwszReaders = NULL;
         cchReaders = SCARD_AUTOALLOCATE;

        // Save off PnP notification reader state and and list of readers previously found in the system
         memcpy_s(&rgscOldState[0], sizeof(SCARD_READERSTATE), &rgscState[0], sizeof(SCARD_READERSTATE));
         memset(rgscState, 0, sizeof(rgscState));
         dwOldRdrCount = dwRdrCount;
         pwszOldReaders = pwszReaders;

        // Obtain a list of all readers in the system
         wprintf(L"Building reader list.\n");
         lReturn = SCardListReaders(
         hSC,
         NULL,
         (LPWSTR)&pwszReaders,
         &cchReaders);
         switch (lReturn)
         {
             case SCARD_S_SUCCESS:
             // Success
             break;
             case SCARD_E_NO_READERS_AVAILABLE:
             // No readers in the system. This is OK.
             lReturn = SCARD_S_SUCCESS;
             break;
             default:
             // Error occurred
             wprintf(L"Failed to obtain list of readers with error 0x%x.\n", lReturn);
             fDone = TRUE;
             break;
         }

         // Build the reader list for monitoring - NULL indicates end-of-list
         // First entry is the PnP Notification entry.
         pRdr = rgscState;
         memcpy_s(&rgscState[0], sizeof(SCARD_READERSTATE), &rgscOldState[0], sizeof(SCARD_READERSTATE));
         pRdr++;
         pwszRdr = pwszReaders;
         while ((NULL != pwszRdr) && (0 != *pwszRdr))
         {
             BOOL fFound = FALSE;
             dwRdrCount++;

            // Look for an existing reader state from a previous loop
             for (dwIndex = 1; dwIndex < dwOldRdrCount; dwIndex++)
             {
                 if ((lstrlen(pwszRdr) == lstrlen(rgscOldState[dwIndex].szReader)) &&
                 (0 == lstrcmpi(pwszRdr, rgscOldState[dwIndex].szReader)))
                 {
                     // Found a match. Copy it.
                     memcpy_s(pRdr, sizeof(SCARD_READERSTATE), &rgscOldState[dwIndex], sizeof(SCARD_READERSTATE));
                     fFound = TRUE;
                     break;
                 }
             }

            if (!fFound)
                {
                    // New reader
                    pRdr->szReader = pwszRdr;
                    pRdr->dwCurrentState = SCARD_STATE_UNAWARE;
                }

            // Increment reader indices
            pRdr++;
            pwszRdr += lstrlen(pwszRdr)+1;
         }
     }
}

    // Clean up resources
     if (NULL != pwszReaders)
     {
         SCardFreeMemory(hSC, pwszReaders);
     }

    if (NULL != pwszOldReaders)
     {
         SCardFreeMemory(hSC, pwszOldReaders);
     }

    return lReturn;
}

LONG __cdecl main(
 VOID)
{
     DWORD dwRet = ERROR_SUCCESS;
     SCARDCONTEXT hSC = NULL;
     LONG lReturn = NO_ERROR;
     HANDLE hStartedEvent = NULL;

    // Get handle to event that will be signaled when the Smart Card Service is available
     hStartedEvent = SCardAccessStartedEvent();

    // Wait for the Smart Card Service to become available
     dwRet = WaitForSingleObject(hStartedEvent, INFINITE);
     if (WAIT_OBJECT_0 != dwRet)
     {
         wprintf(L"Wait for Smart Card Service failed with error 0x%x.\n", dwRet);
         lReturn = dwRet;
     }
     else
     {
         // Establish a system-level context with the Smart Card Service
         lReturn = SCardEstablishContext(
         SCARD_SCOPE_SYSTEM,
         NULL,
         NULL,
         &hSC);
         if (SCARD_S_SUCCESS != lReturn)
         {
         wprintf(L"Failed to establish context with the Smart Card Service with error 0x%x.\n", lReturn);
         }
         else
         {
             // Begin monitoring the readers in the system
             // This routine could be done in a separate thread so it can be cancelled via SCardCancel().
             lReturn = MonitorReaders(hSC);
         }
     }

    // Cleanup resources
     if (NULL != hSC)
     {
        SCardReleaseContext(hSC);
     }

    if (NULL != hStartedEvent)
     {
        SCardReleaseStartedEvent();
     }

    wprintf(L"Done.\n");

    return lReturn;
}

```

## References

For more information about troubleshooting smart card Plug and Play issues, see [Smart Card Troubleshooting Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd979536(v=ws.10)).

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
