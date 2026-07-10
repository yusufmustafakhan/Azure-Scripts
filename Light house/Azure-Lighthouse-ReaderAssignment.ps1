# ============================================
# Azure Lighthouse - Reader Access Assignment
# ============================================
#
# Purpose:
# Assigns the Reader RBAC role to a User, Security Group,
# or Service Principal at the Subscription or Resource Group scope.
#
# Best Practice (CSP / Azure Lighthouse):
# ---------------------------------------
# It is NOT recommended to assign permissions directly to an individual user.
#
# Instead, assign the role to:
#   • An Admin Agents Security Group, OR
#   • A dedicated Azure AD Security Group created for Azure Lighthouse access.
#
# Benefits:
#   ✓ Easier user lifecycle management
#   ✓ No script changes when team members join or leave
#   ✓ Better security and auditing
#   ✓ Aligns with Microsoft CSP and Azure Lighthouse best practices
#
# Simply provide the Object ID of the Security Group in the
# $PrincipalId variable below.
#
# Example:
# $PrincipalId = "<Security Group Object ID>"
#
# ============================================

# Connect to Azure
Connect-AzAccount

# -----------------------------
# Variables
# -----------------------------
$SubscriptionId = "<Subscription-ID>"

# Leave blank to assign at Subscription scope.
# Specify a Resource Group name to assign only at RG level.
$ResourceGroup = ""

# Azure AD Object ID
# Can be:
#   • User Object ID
#   • Security Group Object ID (Recommended)
#   • Service Principal Object ID
$PrincipalId = "<Azure AD Object ID>"

# Friendly display name (for logging only)
$PrincipalName = "<Display Name>"

# RBAC Role
$RoleDefinition = "Reader"

# -----------------------------
# Set Subscription Context
# -----------------------------
Set-AzContext -SubscriptionId $SubscriptionId

# -----------------------------
# Determine Scope
# -----------------------------
if ([string]::IsNullOrWhiteSpace($ResourceGroup)) {
    $Scope = "/subscriptions/$SubscriptionId"
}
else {
    $Scope = "/subscriptions/$SubscriptionId/resourceGroups/$ResourceGroup"
}

# -----------------------------
# Get Role Definition
# -----------------------------
$Role = Get-AzRoleDefinition -Name $RoleDefinition

# -----------------------------
# Create Role Assignment
# -----------------------------
New-AzRoleAssignment `
    -ObjectId $PrincipalId `
    -RoleDefinitionId $Role.Id `
    -Scope $Scope

Write-Host ""
Write-Host "======================================" -ForegroundColor Green
Write-Host "Reader role assigned successfully." -ForegroundColor Green
Write-Host "Principal : $PrincipalName"
Write-Host "Scope     : $Scope"
Write-Host "Role      : $RoleDefinition"
Write-Host "======================================"
