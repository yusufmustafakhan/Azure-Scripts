# ============================================
# Azure Lighthouse - Contributor Access Assignment
# ============================================
#
# Purpose:
# Assigns the Contributor RBAC role to a User, Security Group,
# or Service Principal at the Subscription or Resource Group scope.
#
# Best Practice (CSP / Azure Lighthouse):
# ---------------------------------------
# Avoid assigning permissions directly to individual users.
#
# Instead, assign the role to:
#   • Admin Agents Security Group
#   • Dedicated Azure AD Security Group (Recommended)
#
# Using Security Groups provides:
#   • Simplified access management
#   • Easier onboarding/offboarding
#   • Improved security and auditing
#   • Alignment with Microsoft CSP and Azure Lighthouse best practices
#
# Provide the Security Group Object ID in $PrincipalId.
#
# ============================================

# Connect to Azure
Connect-AzAccount

# -----------------------------
# Variables
# -----------------------------
$SubscriptionId = "<Subscription-ID>"

# Leave blank for Subscription scope
# Specify Resource Group name for RG scope
$ResourceGroup = ""

# Azure AD Object ID
# Can be User, Security Group (Recommended), or Service Principal
$PrincipalId = "<Azure AD Object ID>"

# Friendly name for logging
$PrincipalName = "<Display Name>"

# RBAC Role
$RoleDefinition = "Contributor"

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
Write-Host "Contributor role assigned successfully." -ForegroundColor Green
Write-Host "Principal : $PrincipalName"
Write-Host "Scope     : $Scope"
Write-Host "Role      : $RoleDefinition"
Write-Host "======================================"
