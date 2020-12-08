---
title: BitLocker Recovery starts when OEMs perform firmware updates for TPM 1.2
description: 
ms.date: 12/07/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: 
---
# BitLocker Recovery starts when OEMs perform firmware updates for TPM 1.2

_Original product version:_ &nbsp; Windows 10, version 1809, all editions, Windows 10  
_Original KB number:_ &nbsp; 3184518

## Symptoms

For Trusted Platform Module (TPM) 1.2, Windows does not know if the system is going through a firmware update. In this situation, the computer reboots into BitLocker Recovery. 

[https://technet.microsoft.com/library/ff829848(v=ws.11).aspx](https://na01.safelinks.protection.outlook.com/?url=https://technet.microsoft.com/library/ff829848%28v%3dws.11%29.aspx&data=01%7c01%7cmarikita%40microsoft.com%7c52528c7452d84136ba4908d39bf2e1ae%7c72f988bf86f141af91ab2d7cd011db47%7c1&sdata=mmq5wi%2bqplvf7calavpwxn3rffxgatmvi7/g8scpksq%3d) 

To suspend protection, run the following command line:

manage-bde -protectors -disable c: 
To resume protection, run the following:

manage-bde -protectors -enable c: 

## Workaround

For IT managers who are performing firmware updates for TPM 1.2 through Windows Update, make sure that you suspend BitLocker before you run the updates. This prevents BitLocker Recovery from starting. 

## More Information

Use TPM 2.0, as PCR 7 performs all these measurements automatically.
