---
title: Sending many emails takes long time to run
description: Provides a resolution for the issue that sending lots of emails such as PM EFT remittances takes a long time to run or stops responding in Microsoft Dynamics GP.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Performance issue with sending a large volume of emails such as PM EFT remittances in Microsoft Dynamics GP

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 5012985

## Symptoms

When you send PM EFT remittance emails in mass for a large check run in Microsoft Dynamics GP, it's taking forever and just stops responding.

This same concept would apply for any emails send in Microsoft Dynamics GP for any module such as SOP invoices, RM statements, and so on.

## Resolution

The emails will send faster if you do smaller check runs, versus one large check run, which would be the recommended solution. For example, process a check run for vendors A-G, then for vendors H-R, then S-Z (or as needed, per your volume so that there are less than 150-200 emails to be sent for each check run.)

## More information

Understanding how the process works behind the scenes on how every template is created will help users to understand why generating so many emails at once can tax the system. Here's the process:

- With every EFT Remittance that is emailed, the user's %TEMP% directory will create a blank Word Template report with XXXXXX in for every field and an XML file as .tmp files that contain the data from their report writer report for each specific remittance. The Template processing engine then fills in all the fields from the XML in their respective areas.  So the %TEMP% folder can get filled up fast and slow the system down.

- Once that is complete, the XML and template in the %TEMP% directory are merged and converted to the file format DOCX or PDF as specified.

  > 1-Report definition > XML Document (with data) > Template processing engine
  >
  > 2-Microsoft Word template > Fills in with XXXX > Template processing engine
  >
  > < Template processing engine merges the two = completed report

- The more templates processed at the same time, the more taxed your %TEMP% folder gets on the workstation and this is where performance issues can occur and processes are slower.

Running smaller check runs won't overload the %TEMP% folder so much, so they can process faster. It's recommended to keep your check runs to less than 150-200 documents being emailed. So your %TEMP% folder isn't so overloaded and it helps improve performance within your system so the emails can be sent out faster.
