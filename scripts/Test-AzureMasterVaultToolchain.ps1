[CmdletBinding()]
param(
    [Alias("Profile")]
    [ValidateSet("Learner", "Contributor")]
    [string]$ToolProfile = "Learner"
)

$ErrorActionPreference = "Stop"
$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path

$requiredCommands = @("pwsh", "terraform", "az", "git", "code", "node", "npm")
if ($ToolProfile -eq "Contributor") {
    $requiredCommands += "func"
}

$issues = [System.Collections.Generic.List[string]]::new()

function Get-CommandVersion {
    param([Parameter(Mandatory)][string]$Name)

    try {
        $raw = switch ($Name) {
            "pwsh"      { $PSVersionTable.PSVersion.ToString() }
            "terraform" { (& terraform version -json | ConvertFrom-Json).terraform_version }
            "az"        { (& az version --output json | ConvertFrom-Json)."azure-cli" }
            "git"       { (& git --version | Select-Object -First 1) }
            "code"      { (& code --version | Select-Object -First 1) }
            "node"      { (& node --version | Select-Object -First 1) }
            "npm"       { (& npm --version | Select-Object -First 1) }
            "func"      { (& func --version | Select-Object -First 1) }
            default     { $null }
        }
        if (-not $raw) { return "version unavailable" }
        return [string]$raw
    }
    catch {
        return "version check failed: $($_.Exception.Message)"
    }
}

Write-Host "Azure Master Vault workstation audit — $ToolProfile profile"
Write-Host "Repository: $repoRoot"
Write-Host "This check only reads local tool versions and the current Azure CLI session."
Write-Host ""

foreach ($name in $requiredCommands) {
    $command = Get-Command $name -ErrorAction SilentlyContinue
    if (-not $command) {
        $issues.Add("$name is not installed or is not available on PATH.")
        Write-Host "[MISSING] $name"
        continue
    }

    $version = Get-CommandVersion -Name $name
    Write-Host "[FOUND]   $name $version"

    if ($name -eq "terraform") {
        $match = [regex]::Match($version, '\d+(?:\.\d+){1,3}')
        if ($match.Success -and [version]$match.Value -lt [version]"1.9.0") {
            $issues.Add("Terraform $($match.Value) is older than the required minimum 1.9.0.")
            Write-Host "[ERROR]   Terraform 1.9.0 or later is required."
        }
    }

    if ($name -eq "node") {
        $match = [regex]::Match($version, '\d+(?:\.\d+){1,2}')
        if ($match.Success -and ([version]$match.Value).Major -lt 22) {
            $issues.Add("Node.js $($match.Value) is older than the required major version 22.")
            Write-Host "[ERROR]   Node.js 22 or later is required."
        }
    }
}

try {
    $subscriptionId = & az account show --query id --output tsv 2>$null
    if ($LASTEXITCODE -eq 0 -and $subscriptionId) {
        Write-Host "[INFO]    Azure CLI has an active subscription. Run the Azure context preflight before deployment."
    }
    else {
        Write-Host "[INFO]    Azure CLI is not signed in. This is fine for the local demo."
    }
}
catch {
    Write-Host "[INFO]    Azure CLI is not signed in. This is fine for the local demo."
}

if ($issues.Count -gt 0) {
    Write-Host ""
    Write-Host "$($issues.Count) workstation requirement(s) need attention:"
    $issues | ForEach-Object { Write-Host " - $_" }
    exit 1
}

Write-Host ""
Write-Host "Workstation toolchain audit passed. No tools were installed or modified."
