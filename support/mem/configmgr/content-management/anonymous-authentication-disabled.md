---
title: SMS_DP_SMSPKG$ Anonymous Authentication disabled
description: Fixes an issue in which IIS application folder SMS_DP_SMSPKG$ Anonymous Authentication settings are disabled.
ms.date: 12/05/2023
ms.reviewer: kaushika, windsw
---
# IIS application folder SMS_DP_SMSPKG$ anonymous authentication settings periodically reset to Disabled

This article fixes an issue in which IIS application folder SMS_DP_SMSPKG$ Anonymous Authentication settings are disabled.

_Original product version:_ &nbsp; System Center Configuration Manager 2007  
_Original KB number:_ &nbsp; 2682514

## Symptoms

After enabling Anonymous Authentication in Internet Information Server 7.5 (IIS), randomly the IIS application folder **SMS_DP_SMSPKG\<Partition>$** Anonymous Authentication settings become Disabled.

## Cause

This problem can occur if System Center Configuration Manager 2007 is installed and Anonymous Authentication is disabled in the distribution point (DP) properties.

## Resolution

In the Configuration Manager console, check the distribution point configuration:

1. Go to **Site Database** > **Site Management** > *Site name* > **Site Settings** > **Site Systems** > *Site server*.
2. Right-click the distribution point, and then select **Properties**.
3. Verify whether the checkbox **Allow Clients to connect Anonymously** is selected. If it's unchecked, check it.
