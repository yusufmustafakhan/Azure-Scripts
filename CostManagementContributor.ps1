# ============================================================
# Azure RBAC - Cost Management Contributor
# Subscription Scope
# ============================================================
#
# Prerequisites
# -------------
# ✓ Customer tenant onboarded in CSP Partner Center.
# ✓ GDAP or delegated administrative permissions.
# ✓ Active Azure Subscription.
# ✓ User Access Administrator or Owner permissions.
#
# Best Practice
# -------------
# Use an Azure AD Security Group instead of assigning
# permissions directly to individual users.
#
# ============================================================

Connect-AzAccount

$SubscriptionId = "<Subscription ID>"
$PrincipalId    = "<Azure AD Object ID>"
$PrincipalName  = "<Display Name>"
$RoleName       = "Cost Management Contributor"

Set-AzContext -SubscriptionId $SubscriptionId

$Scope = "/subscriptions/$SubscriptionId"

New-AzRoleAssignment `
    -ObjectId $PrincipalId `
    -RoleDefinitionName $RoleName `
    -Scope $Scope

Write-Host "Cost Management Contributor role assigned successfully." -ForegroundColor Green
