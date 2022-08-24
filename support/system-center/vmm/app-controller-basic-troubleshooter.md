---
title: System Center App Controller basic troubleshooter
description: Describes the information that may be collected from a machine when running the System Center App Controller basic troubleshooter for Windows Server 2008 R2 Diagnostic Platform. 
ms.date: 08/18/2020
ms.reviewer: markstan
---
# [SDP 3][d2fe092f-bbe3-4e0b-88af-166e91e7e289]System Center App Controller basic troubleshooter

The System Center App Controller basic troubleshooter for Windows Server 2008 R2 Diagnostic Platform was designed to collect information to help troubleshoot most App Controller problems.

_Original product version:_ &nbsp; Microsoft System Center 2012 App Controller  
_Original KB number:_ &nbsp; 2708251

This article describes the information that may be collected from a machine when running the System Center App Controller basic troubleshooter for Windows Server 2008 R2 Diagnostic Platform.

## Event logs

| Description| File name |
|---|---|
|System event logs|{ComputerName}_evt_System.*|
|Application event Logs|{ComputerName}_evt_Application.*|
  
## SilverLight information

| Description| File name |
|---|---|
|Version information|Silverlight Wow6432 Version Information.txt|
  
## System information - General

| Description| File name |
|---|---|
|MSInfo|{ComputerName}_msinfo32.*|
  