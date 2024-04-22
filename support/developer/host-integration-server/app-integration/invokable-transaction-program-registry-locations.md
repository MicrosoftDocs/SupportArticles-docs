---
title: Invokable Transaction Program registry locations
description: This article describes invokable Transaction Program registry locations that Tpsetup.exe creates under different running environments.
ms.date: 10/13/2020
ms.custom: sap:Application Integration (Transaction Integrator)
---
# Invokable Transaction Program registry locations that Tpsetup.exe creates

This article describes invokable Transaction Program registry locations that Tpsetup.exe creates under different running environments.

_Original product version:_ &nbsp; Host Integration Server  
_Original KB number:_ &nbsp; 316787

## Summary

A Transaction Program (TP) that can be invoked (called upon to start a conversation) by another TP is known as an Invokable TP. Invokable TPs are generally server-type applications.

A TP that is automatically started when invoked is known as an autostarted TP.

Tpsetup.exe is a utility that is included with Host Integration Server 2000 and with the SNA Server 4.0 Software Development Kit (SDK). You can use Tpsetup.exe to install autostarted invokable TPs. Autostarted invokable TPs can be either queued or nonqueued.

Queued and nonqueued TPs function differently:

- When a queued TP is invoked multiple times, it loads one time and then queues up requests after that to be dealt with one at a time.

- When a nonqueued TP is invoked multiple times, it loads multiple times, one time for every time that it is invoked.

## More information

Microsoft recommends that you use the Tpsetup.exe program to install autostarted invokable TPs. The registry locations that Tpsetup.exe creates under different running environments are listed as follows:

## Host Integration Server Administrator client with SNA Server 4.0 Windows NT client

- **With SNABASE running as a service**

  - With TP running as a service:

      `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TPNAME\Parameters`

  - With TP running as an application:

       `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SnaBase\Parameters\TPs\TPNAME\Parameters`

- **With SNABASE Running as an application**

  - With TP running as a service:

    - `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\TPNAME\Parameters`
    - `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TPNAME`

- With TP running as an application:

  - `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SnaBase\Parameters\TPs\TPNAME\Parameters`

  > [!NOTE]
  > The version of Tpsetup.exe that is included with Host Integraton Server includes an extra parameter named `Accessible by All Users`. This parameter is checked by default with the Host Integration Server Administrator Client and cannot be modified. With the Host Integration Server End-User Client, by default, this parameter is clear (not checked).

## Under Host Integration Server end-user client

- **With SNABASE running only as an application**

  - With TP running only as an application (the `Accessible by All Users` check box is clear)

  - `HKEY_CURRENT_USER\SOFTWARE\Microsoft\SnaBase\Parameters\TPs\TPNAME\Parameters`

- **With Accessible by All Users checked on Host Integration Server end-user client**

  - SNA Server 4.0 Windows 95, Windows 98, Windows Millennium Edition Client
  - With SNABASE runs only as an application
  - With TP running only as an application
  - `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SnaBase\Parameters\TPs\TPNAME\Parameters`

## Reference

For more information, see the online books on this subject, and the SDKs for both Host Integration Server and SNA Server 4.0.
