---
title: Make several enhancements to the SQLIOSim utility
description: Describes the improvement that makes several enhancements to the SQLIOSim utility.
ms.date: 07/26/2024
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5028786
ms.reviewer: v-cuichen, rdorr
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---
# Improvement: Make several enhancements to the SQLIOSim utility

## Summary

This improvement makes the following enhancements to the SQLIOSim utility and fixes data integrity issues that might be caused by I/O handling. For more information about the SQLIOSim utility, see the [Introduction of the SQLIOSim utility](../../tools/sqliosim-utility-simulate-activity-disk-subsystem.md#introduction).

### Enhanced logging

- Adds a new ring buffer to track errors, in order to make it unlikely that errors in the history ring buffer are replaced because of the rollover.
- Adds various outputs that contain "tick count" and/or "date and time" to make debugging an issue easier.
- Adds the outputs of `fsutil` and volume information to the error file, in order to map the file offset to the offset on the physical disk and filter the I/O subsystem traces easier.
- Adds the output for Coordinated Universal Time (UTC) and local time.
- Breaks down the output of the page header to the error file, such as PageId, Checksum, and Timestamp.
- Displays a list of the pages of the `FILE HISTORY` ring buffer to more easily locate ring buffer entries.
- Displays Timestamp, Date Time, Logical CPU, and other columns in the *Sqliosim.log.xml* or *ErrorLog.xslt* view.
- Increases the size of the ring buffers and reduces the frequency of the rollover.
- Provides hexadecimal and decimal outputs for common outputs such as PageId, Checksum, and Timestamp.
- Updates the layout of *Sqliosim.log.xml* to make it easier to read the XML file in a text editor.
- Validated *Sqliosim.log.xml* and *ErrorLog.xslt* can be viewed correctly in Microsoft Edge that uses Internet Explorer (IE) mode.

### Page header timestamp

Stores the `GetTickCount64` value in the page header during the write operations. The tick count is useful for tracking when the page is written and filtering the I/O subsystem traces.

### BNR (Bytes-Not-Read)

The I/O issue causes the read operation to be returned as if the read operation is successful, but the actual buffer isn't updated or read. The SQLIOSim utility receives a successful read, but fails the validation checks.

The SQLIOSim utility now stamps the read buffers by using the BNR pattern before issuing a read. When the read operation returns successfully but fails to perform the actual read, the validation continues to fail. However, the bytes read shows the .BNR pattern that indicates an I/O subsystem issue.

### Write-retry

If the I/O subsystem encounters a reset (more common in direct-attached storage (DAS) installations), the write operation requests might complete incorrectly. The SQLIOSim utility doesn't guarantee write-retry capabilities. In some cases, the SQLIOSim utility tries to read and validate the data that fails to write.

The SQLIOSim utility is enhanced to log a write failure and then perform a write-retry operation.

### Enhanced locking

The internal locking mechanisms and page protection (VirtualProtect) activity are optimized and enhanced to ensure that an issue reported by the SQLIOSim utility isn't caused by a logic flaw in the SQLIOSim utility.

### Read-retry

Fixes an issue that causes the read-retry attempt to fail when retrying a failed LDX (log simulation) read.

### Examples of the enhanced outputs

The first example of the enhanced output includes the following enhancements:

- UTC Time
- Hexadecimal and decimal
- Timestamp/Tick count
- BNR
- Page header expansion

:::image type="content" source="../media/make-enhancements-sqliosim-utility/enhanced-output.png" alt-text="Screenshot of the enhanced output, which includes UTC Time, Hexadecimal and decimal, Timestamp/Tick count, BNR, and Page header expansion." lightbox="../media/make-enhancements-sqliosim-utility/enhanced-output.png":::

The second example of the enhanced output includes the following enhancements:

- Ring buffer
- UTC Time
- Page range breakout

:::image type="content" source="../media/make-enhancements-sqliosim-utility/enhanced-output-enhancements.png" alt-text="Screenshot of the enhanced output, which includes Ring buffer, UTC Time, and Page range breakout." lightbox="../media/make-enhancements-sqliosim-utility/enhanced-output-enhancements.png":::

The third example of the enhanced output includes the following enhancements:

- Tick count column
- Logical CPU column

:::image type="content" source="../media/make-enhancements-sqliosim-utility/tick-count-logical-cpu.png" alt-text="Screenshot of the enhanced output, which includes the columns for Tick count and Logical CPU." lightbox="../media/make-enhancements-sqliosim-utility/tick-count-logical-cpu.png":::

## More information

This improvement is included in the following cumulative update for SQL Server:

[Cumulative Update 7 for SQL Server 2022](cumulativeupdate7.md)

## About cumulative updates for SQL Server

Each new cumulative update for SQL Server contains all the hotfixes and security fixes that were in the previous build. We recommend that you install the latest build for your version of SQL Server:

[Latest cumulative update for SQL Server 2022](build-versions.md)

## References

Learn about the [terminology](../../../windows-client/deployment/standard-terminology-software-updates.md) that Microsoft uses to describe software updates.
