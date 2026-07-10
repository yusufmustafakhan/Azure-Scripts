# ============================================================
# Azure RBAC - Owner Role Assignment (Subscription Scope)
# ============================================================
#
# Purpose
# -------
# Assigns the Owner role at the Subscription level.
#
# Prerequisites
# -------------
# ✓ The customer tenant must be onboarded under your CSP
#   Partner Center tenant.
#
# ✓ A GDAP relationship (or equivalent delegated administration)
#   must exist with sufficient permissions to manage Azure RBAC.
#
# ✓ The target Azure Subscription must be active.
#
# ✓ The account running this script must have:
#     • Owner
#     • User Access Administrator
#   on the target subscription.
#
# Best Practice
# -------------
# Do NOT assign RBAC permissions directly to individual users.
#
# Instead assign permissions to:
#   • Admin Agents Security Group
#   • Dedicated Azure AD Security Group (Recommended)
#
# This simplifies user lifecycle management and aligns with
# Microsoft CSP best practices.
#
# ============================================================

Connect-AzAccount

$SubscriptionId = "<Subscription ID>"
$PrincipalId    = "<Azure AD Object ID>"
$PrincipalName  = "<Display Name>"
$RoleName       = "Owner"

Set-AzContext -SubscriptionId $SubscriptionId

$Scope = "/subscriptions/$SubscriptionId"

New-AzRoleAssignment `
    -ObjectId $PrincipalId `
    -RoleDefinitionName $RoleName `
    -Scope $Scope

Write-Host "Owner role assigned successfully." -ForegroundColor Green
