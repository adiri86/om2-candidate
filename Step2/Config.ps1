
# Configuration settings for the main.ps1 script.
# Includes log file path, default features, default server name, auto restart setting, error messages, and optional backup path.

# Define the log file path
$Global:LogFilePath = "C:\Path\To\Your\LogFile.log"

# Define default features to install
$Global:DefaultFeatures = @(
    "NET-Framework-Features",
    "Web-Server"
)

# Define default server name or naming conventions
$Global:DefaultServerName = "NewServerName"

# Define whether to automatically restart the server
$Global:AutoRestart = $true

# Define error handling messages
$Global:ErrorMessages = @{
    FeatureInstallFailed = "Feature installation failed. Please check the system and address any issues before proceeding."
    ServerRenameFailed = "Server rename failed. Please check the system and rename manually if necessary."
    RestartFailed = "Server restart failed. Please check the system and restart manually if necessary."
}
