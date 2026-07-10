# ============================================
# Azure Lighthouse - Owner Access Assignment
# ============================================
#
# Purpose:
# Assigns the Owner RBAC role to a User, Security Group,
# or Service Principal at the Subscription or Resource Group scope.
#
# Best Practice (CSP / Azure Lighthouse):
# ---------------------------------------
# Do NOT assign Owner access directly to individual users unless
# absolutely necessary.
#
# Microsoft recommends assigning access through:
#   • Admin Agents Security Group
#   • Dedicated Azure AD Security Group (Recommended)
#
# Benefits:
#   • Centralized permission management
#   • Easier user lifecycle management
#   • Reduced security risk
#   • Better auditing and governance
#
# Provide the Security Group Object ID in $PrincipalId.
#
# IMPORTANT:
# Owner grants full administrative control over Azure resources,
# including the ability to grant access to other identities.
# Assign this role only when required and follow the principle
# of least privilege.
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
$RoleDefinition = "Owner"

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
Write-Host "Owner role assigned successfully." -ForegroundColor Green
Write-Host "Principal : $PrincipalName"
Write-Host "Scope     : $Scope"
Write-Host "Role      : $RoleDefinition"
Write-Host "======================================"
