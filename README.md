# Windows STIG Hardening Script - WN10-SO-000005

## Overview
This repository contains a PowerShell script designed to automate the remediation of security findings based on the Defense Information Systems Agency (DISA) Security Technical Implementation Guides (STIGs) for Windows systems.

The goal of this script is to provide a reliable and efficient way to apply security configurations, ensuring compliance and hardening systems against vulnerabilities.

---

## Script
This repository contains the script for the following STIG:

| STIG ID | Description | Script File |
| :--- | :--- | :--- |
| **WN10-SO-000005** | The built-in administrator account must be disabled. | [`Set-StigCompliance.WN10-SO-000005.ps1`](./Set-StigCompliance.WN10-SO-000005.ps1) |

---

## Usage
The script is designed to be run individually with administrative privileges in a PowerShell console.

**Example:**

To apply the remediation for STIG `WN10-SO-000005`:

```powershell
# First, open PowerShell as an Administrator.

# Navigate to the folder where you saved the script.
cd C:\Path\To\Your\Scripts

# If you downloaded the script from the internet, unblock it first.
Unblock-File -Path '.\Set-StigCompliance.WN10-SO-000005.ps1'

# Execute the script to apply the remediation.
.\'Set-StigCompliance.WN10-SO-000005.ps1'
