<#
.SYNOPSIS
    Disables the local, built-in administrator account on the system.

.DESCRIPTION
    This script remediates the DISA STIG finding WN10-SO-000005 by disabling the built-in
    administrator account. It identifies the account using its well-known Security Identifier (SID)
    S-1-5-21...-500 to ensure the correct account is targeted, even if it has been renamed.

.NOTES
    Author          : Jorge Juarez
    LinkedIn        : linkedin.com/in/jorgejuarez1
    GitHub          : github.com/jorjuarez
    Date Created    : 2025-07-14
    Last Modified   : 2025-07-14
    Version         : 1.0
    STIG-ID         : WN10-SO-000005
    Vulnerability-ID: V-220864

.LINK
    https://www.stigviewer.com/stig/windows_10/2021-08-18/finding/V-220864

.EXAMPLE
    PS C:\> .\'Set-StigCompliance.WN10-SO-000005.ps1'

    Executes the script from an elevated PowerShell prompt to disable the built-in administrator account.

.REQUIREMENTS
    - Requires administrative privileges to run.
    - The script must not be run by the built-in administrator account itself.
#>

# --- Start of Script ---

# This command ensures that the script will stop if any command fails.
$ErrorActionPreference = "Stop"

# --- Main Logic ---
Write-Host "--- Applying STIG WN10-SO-000005 Remediation ---" -ForegroundColor Yellow

try {
    # Find the built-in administrator account using its well-known SID (ends in -500)
    $AdminSID = "S-1-5-21-*-500"
    $AdminAccount = Get-LocalUser | Where-Object { $_.SID -like $AdminSID }

    if ($null -eq $AdminAccount) {
        throw "Could not find the built-in administrator account (SID ending in -500)."
    }

    Write-Host "Found built-in administrator account: $($AdminAccount.Name)"

    # Check if the account is already disabled
    if (-not $AdminAccount.Enabled) {
        Write-Host "Administrator account is already disabled. No action needed." -ForegroundColor Green
    } else {
        # Disable the account
        Write-Host "Administrator account is currently enabled. Disabling it now..."
        Disable-LocalUser -Name $AdminAccount.Name
        Write-Host "Successfully disabled the administrator account." -ForegroundColor Green
    }
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
}

# --- Verification ---
Write-Host "`n--- Verifying Changes ---" -ForegroundColor Yellow
try {
    # Re-fetch the account to get the current state
    $AdminAccount = Get-LocalUser | Where-Object { $_.SID -like "S-1-5-21-*-500" }
    Write-Host "Current Status for account '$($AdminAccount.Name)': Enabled = $($AdminAccount.Enabled)"

    if (-not $AdminAccount.Enabled) {
        Write-Host "SUCCESS: Remediation for WN10-SO-000005 verified. Account is disabled." -ForegroundColor Green
    } else {
        Write-Warning "WARNING: Verification failed. The account is still enabled."
    }
}
catch {
    Write-Error "Failed to verify account status. An error occurred: $($_.Exception.Message)"
}

Write-Host "`n--- Script Complete ---"

# --- End of Script ---
