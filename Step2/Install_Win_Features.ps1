# Import the configuration
Import-Module -Name .\Config.ps1

# Function to handle logging and console output
function Log-Message {
    param (
        [string]$Message
    )
    
    $Timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    "$Timestamp - $Message" | Out-File -FilePath $Global:LogFilePath -Append
    Write-Host $Message
}

function Install-WindowsFeatures {
    param (
        [string[]]$Features
    )
    
    # Validate that $Features is an array and contains non-empty strings
    if (-not ($Features -is [array])) {
        Log-Message "Error: Features parameter is not an array."
        return $false
    }
    # Check if the $Features array is empty
    if ($Features.Count -eq 0) {
        Log-Message "Error: No features specified for installation."
        return $false
    }

    foreach ($Feature in $Features) {
     # Check if the current feature name is null, empty, or contains only whitespace
        if ([string]::IsNullOrWhiteSpace($Feature)) {
            Log-Message "Error: Invalid feature name: '$Feature'. Skipping..."
            $InstallationSuccessful = $false
            continue
        }
        try {
            Log-Message "Installing feature: $Feature"
            Install-WindowsFeatures -Name $Feature -Verbose
            Log-Message "Feature $Feature installed successfully."
        } catch {
            Log-Message "Failed to install feature $Feature. Error: $_"
            $InstallationSuccessful = $false
        }
    }

    return $InstallationSuccessful
}

function Rename_Server {
    param (
        [string]$NewName
    )
    
    try {
        Log-Message "Renaming server to: $NewName"
        Rename-Computer -NewName $NewName -Force
        Log-Message "Server renamed to $NewName successfully."
        return $true
    } catch {
        Log-Message "Failed to rename server. Error: $_"
        return $false
    }
}

function Restart_Server {
    try {
        Log-Message "Restarting the computer..."
        Restart-Computer -Force
        # No need for further code as restart is initiated
        return $true
    } catch {
        Log-Message "Failed to restart the computer. Error: $_"
        return $false
    }
}

# Main script execution
$FeaturesArray = $Global:DefaultFeatures
$NewServerName = $Global:DefaultServerName

$InstallationResult = Install_Win_Features -Features $FeaturesArray

if ($InstallationResult) {
    $RenameResult = Rename_Server -NewName $NewServerName

    if ($RenameResult) {
        if ($Global:AutoRestart) {
            $RestartResult = Restart_Server

            if (-not $RestartResult) {
                Log-Message $Global:ErrorMessages.RestartFailed
            }
        }
    } else {
        Log-Message $Global:ErrorMessages.ServerRenameFailed
    }
} else {
    Log-Message $Global:ErrorMessages.FeatureInstallFailed
}
