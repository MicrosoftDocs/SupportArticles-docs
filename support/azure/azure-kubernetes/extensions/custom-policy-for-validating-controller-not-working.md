---
title: Custom Azure Policy for validating controllers fails
description: Learn how to fix a custom Azure Policy for validating controllers in AKS. Follow these steps to resolve syntax errors and get your policy working.
ms.date: 04/12/2024
ms.reviewer: momajed, cssakscic
ms.service: azure-kubernetes-service
ms.custom: sap:Extensions, Policies and Add-Ons
---
# Custom Azure Policy for validating controllers fails

## Summary

This article explains how to fix a custom Azure Policy for validating controllers that fails when used with an Azure Kubernetes Service (AKS) cluster. Follow the steps below to resolve syntax errors and ensure your policy works correctly.

## Symptoms

A custom policy created for validating controllers fails with an error.

## Cause

The custom policy isn't defined using the correct syntax.

## Solution

To resolve this issue, follow these steps to ensure that the custom policy works correctly and meets the necessary requirements:

1. Generate the custom policy definition with the correct syntax by using Visual Studio Code extension for Azure Policy.

    Using this tool to generate a custom policy ensures that it can be properly defined and adhere to the required format.
   
3. Create and validate the custom policy by referencing [Azure Policy for Kubernetes releases support for custom policy](https://techcommunity.microsoft.com/t5/azure-governance-and-management/azure-policy-for-kubernetes-releases-support-for-custom-policy/ba-p/2699466).


 
