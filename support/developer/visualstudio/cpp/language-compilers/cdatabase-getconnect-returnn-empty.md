---
title: "CDatabase::GetConnect returns an empty string"
description: This article discusses that the GetConnect method returns an empty string in Visual Studio 2012, Visual Studio 2010, and Visual Studio 2008 after certain hotfixes are applied. Provides a resolution.
ms.date: 04/27/2020
ms.custom: sap:Language or Compilers\C++
ms.reviewer: aymans, scotbren
---
# The CDatabase::GetConnect method returns an empty string in Visual Studio

This article helps you resolve the problem where the `CDatabase::GetConnect()` method in Microsoft Foundation Class (MFC) Library always returns an empty string instead of the active database connection information in Visual Studio 2012.

_Original product version:_ &nbsp; Visual Studio Ultimate 2012, Visual Studio Premium 2012  
_Original KB number:_ &nbsp; 2915724

## Symptoms

In Visual Studio 2012, the `CDatabase::GetConnect()` method in MFC Library always returns an empty string instead of the active database connection information.

This problem also occurs in Visual Studio 2010 if a hotfix that is newer than hotfix 2607393 is installed.

This problem also occurs in Visual Studio 2008 if a hotfix that is newer than hotfix 2607389 is installed.

## Cause

For security reasons, the behavior of the `CDatabase` class was changed so that the `GetConnect` method returns an empty string.

To resolve this problem, use one of the following methods.

## Resolution 1: Modify your code

Modify your code to guard against the empty-string condition. To do this, create a class that is derived from `CDatabase`, and use this class as the database class in your application.

In this derived class, override the `OpenEx` method. In the override, first call the `CDatabase` version of `OpenEx` to make sure that the connection string is obtained from the call to `SQLDriverConnect`. Then, decrypt and store the connection string in a `CString` object that you can reference later.

## Resolution 2: Migrate to Visual Studio 2013

Use a more recent version of MFC. For example, use the version that is included in Visual Studio 2013.

In Visual Studio 2013, the `GetConnect()` method returns a `CString`. When the method is called, the encrypted connection string is decrypted and returned to the caller, who is then responsible for zeroing out the memory for security.

## Reference

[CDatabase::GetConnect](/previous-versions/tw69tzh9(v=vs.140))
