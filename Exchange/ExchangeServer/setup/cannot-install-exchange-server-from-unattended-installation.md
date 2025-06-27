---
title: Can't install Exchange from unattended installation
description: You can't install an Exchange Server 2010 Service Pack 1 server from an unattended installation. Provides resolutions.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Plan and Deploy\Exchange Install Issues, Cumulative or Security updates
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: anfowler, gugavaro, v-six
appliesto: 
  - Exchange Server 2010 Service Pack 1
search.appverid: MET150
---
# You can't install an Exchange Server 2010 SP1 server from an unattended installation

_Original KB number:_ &nbsp; 2280782

## Symptoms 1

Consider the following scenario:  

- You run the `Setup /PrepareAD` cmdlet without the `hosting` parameter to install Exchange Server 2010 SP1.
- You run the `setup.com` cmdlet with the `hosting` parameter to install the first Exchange Server 2010 SP1 server. This installation fails.

In this scenario, you receive the following error message:

> Active Directory wasn't prepared using hosting mode. To install server roles for hosting mode, you need to clean up Active Directory and prepare it again for hosting mode.

## Symptoms 2

Consider the following scenario:

- You run the `Setup /PrepareAD` cmdlet with the `hosting` parameter to install Exchange Server 2010 SP1.
- You run the `setup.com` cmdlet without the `hosting` parameter to install the first Exchange Server 2010 SP1 server. This installation fails.

In this scenario, receive the following error message:

> Active Directory was prepared using the /hosting parameter. You must run the command again with the '{0}' parameter to continue. If you didn't intend to use Hosting mode, you need to clean up Active Directory and prepare it again without using the /hosting parameter.

## Resolution

> [!WARNING]
> If you use the ADSI Edit snap-in, the LDP utility, or any other LDAP version 3 client, and you modify the attributes of Active Directory objects incorrectly, you can cause serious problems. These problems may require you to reinstall Microsoft Windows 2000 Server, Microsoft Windows Server 2003, Microsoft Exchange 2000 Server, Microsoft Exchange Server 2003, or both Windows and Exchange. Microsoft can't guarantee that problems that occur if you modify Active Directory object attributes incorrectly can be solved. Modify these attributes at your own risk.

### Resolution 1

To clean up the environment and install Exchange Server 2010 SP1 in hosting mode, follow these steps:

1. Remove Exchange Server 2010 SP1 from the first server. For more information about how to remove Exchange Server 2010, see [Modify or Remove Exchange 2010](/previous-versions/office/exchange-server-2010/ee332361(v=exchg.141)).
2. Install Active Directory Service Interfaces Editor (ADSI Edit). For more information about ADSI Edit, see [ADSI Edit (adsiedit.msc)](/previous-versions/windows/it-pro/windows-server-2003/cc773354(v=ws.10)).
3. Open **ADSI Edit**, expand **Default naming context**.
4. Locate and then delete the following two objects:

    Microsoft Exchange Security Groups  
    Microsoft Exchange System Objects

5. Expand the **Configuration** container in **ADSI Edit**.
6. Locate and then delete the following two objects:

    - Microsoft Exchange  
    - Microsoft Exchange Autodiscover

7. Run the `Setup /PrepareAD` cmdlet with using the `hosting` parameter.
8. Run the `setup.com` cmdlet with using the `hosting` parameter to install Exchange Server 2010 SP1 in hosting mode.

### Resolution 2

To clean up the environment and install Exchange Server 2010 SP1 in non-hosting mode:

1. Remove Exchange Server 2010 SP1 from the first server. For more information about how to remove Exchange Server 2010, see [Modify or Remove Exchange 2010](/previous-versions/office/exchange-server-2010/ee332361(v=exchg.141)).
2. Install Active Directory Service Interfaces Editor (ADSI Edit). For more information about ADSI Edit, see [ADSI Edit (adsiedit.msc)](/previous-versions/windows/it-pro/windows-server-2003/cc773354(v=ws.10)).
3. Open **ADSI Edit**, expand **Default naming context**.
4. Locate and then delete the following two objects:

    Microsoft Exchange Security Groups  
    Microsoft Exchange Hosted Organizations

    Microsoft Exchange System Objects

5. Expand the **Configuration** container in **ADSI Edit**.
6. Locate and then delete the following two objects:

    Microsoft Exchange  
    Microsoft Exchange Autodiscover

7. Install Exchange Server 2010 SP1 in non-hosting mode. For more information about how to deploy an Exchange Server 2010 server, see [Deploying Exchange 2010](/previous-versions/office/exchange-server-2010/dd351084(v=exchg.141)?).

## More information

There's another article that also resolves the problem of the Exchange Server 2010 SP1 installation failure. For more information, see ["Active Directory wasn't prepared using hosting mode" error when you install Exchange Server 2010 SP1 from an unattended installation](active-directory-wasnt-prepared-using-hosting-mode-error.md).
