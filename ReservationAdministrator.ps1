# ============================================================
# Azure RBAC - Reservation Administrator
# Subscription Scope
# ============================================================
#
# Purpose
# -------
# Assigns the Reservation Administrator role at the
# Subscription level.
#
# This role allows users to:
#   • Manage existing Azure Reservations
#   • Modify reservation scope
#   • Split or merge reservations
#   • Exchange reservations
#   • Manage reservation settings
#
# Prerequisites
# -------------
# ✓ Customer tenant must be onboarded in Microsoft CSP Partner Center.
#
# ✓ A GDAP relationship (or equivalent delegated administration)
#   must exist with sufficient permissions.
#
# ✓ The target Azure Subscription must be active.
#
# ✓ The executing account must have:
#     • Owner
#     • User Access Administrator
#   on the target subscription.
#
# Best Practice
# -------------
# Assign this role to an Azure AD Security Group rather than
# individual users.
#
# Recommended:
#   • Admin Agents Security Group
#   • Dedicated Reservations Security Group
#
# ============================================================

Connect-AzAccount

$SubscriptionId = "<Subscription ID>"
$PrincipalId    = "<Azure AD Object ID>"
$PrincipalName  = "<Display Name>"
$RoleName       = "Reservation Administrator"

Set-AzContext -SubscriptionId $SubscriptionId

$Scope = "/subscriptions/$SubscriptionId"

New-AzRoleAssignment `
    -ObjectId $PrincipalId `
    -RoleDefinitionName $RoleName `
    -Scope $Scope

Write-Host ""
Write-Host "Reservation Administrator role assigned successfully." -ForegroundColor Green
