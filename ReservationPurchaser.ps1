# ============================================================
# Azure RBAC - Reservation Purchaser
# Subscription Scope
# ============================================================
#
# Purpose
# -------
# Assigns the Reservation Purchaser role at the
# Subscription level.
#
# NOTE
# ----
# Azure does NOT have a built-in role named
# "Reservation Owner".
#
# The correct built-in role for purchasing Azure
# Reservations is "Reservation Purchaser".
#
# This role allows users to:
#   • Purchase Azure Reservations
#   • Purchase Savings Plans
#
# It does NOT provide administrative control over
# existing reservations.
#
# Prerequisites
# -------------
# ✓ Customer tenant must be onboarded in Microsoft CSP Partner Center.
#
# ✓ A GDAP relationship (or equivalent delegated administration)
#   must exist with sufficient permissions.
#
# ✓ Active Azure Subscription.
#
# ✓ Executing account must have:
#     • Owner
#     • User Access Administrator
#
# Best Practice
# -------------
# Assign this role to an Azure AD Security Group
# instead of individual users.
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
$RoleName       = "Reservation Purchaser"

Set-AzContext -SubscriptionId $SubscriptionId

$Scope = "/subscriptions/$SubscriptionId"

New-AzRoleAssignment `
    -ObjectId $PrincipalId `
    -RoleDefinitionName $RoleName `
    -Scope $Scope

Write-Host ""
Write-Host "Reservation Purchaser role assigned successfully." -ForegroundColor Green
