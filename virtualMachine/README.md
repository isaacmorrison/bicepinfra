# Virtual Machine Module

Deploys one or more **Azure Virtual Machines** with optional domain-join support into an existing resource group and virtual network.

## Resources Deployed

| Resource | Type |
|----------|------|
| Virtual Machine(s) | `Microsoft.Compute/virtualMachines` |
| Network Interface(s) | `Microsoft.Network/networkInterfaces` |
| OS Disk(s) | Managed disk attached to each VM |

## Module Reference

```
br:ayapocacr.azurecr.io/bicepmodules/virtualmachine:v1
```

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `location` | string | `'westus'` | Azure region for all VM resources |
| `adminUsername` | string | _(required)_ | Local administrator username for the VM(s) |
| `adminPassword` | string | _(required, secure)_ | Local administrator password for the VM(s) |
| `domainJoinUserName` | string | _(required)_ | Username used to perform domain join |
| `domainJoinUserPassword` | string | _(required, secure)_ | Password for the domain join user |
| `vmList` | array | _(required)_ | Array of VM names to deploy (e.g. `["vm-01", "vm-02"]`) |
| `vNet` | string | _(required)_ | Full resource ID of the subnet to attach the VM network interfaces to |

## Usage

### Bicep

```bicep
module vm 'br:ayapocacr.azurecr.io/bicepmodules/virtualmachine:v1' = {
  name: 'vmDeploy'
  params: {
    location: 'westus'
    adminUsername: 'myadmin'
    adminPassword: 'P@ssw0rd!'
    domainJoinUserName: 'domain\\joinuser'
    domainJoinUserPassword: 'D0mainP@ss!'
    vmList: ['vm-01']
    vNet: '/subscriptions/<sub-id>/resourceGroups/<rg>/providers/Microsoft.Network/virtualNetworks/<vnet>/subnets/<subnet>'
  }
}
```

> **Security best practice:** Never hard-code credentials in your Bicep files or parameter files. Use Key Vault secret references instead (see below).

### Azure CLI

```bash
az deployment group create \
  --resource-group <resource-group> \
  --template-file virtualMachine/default/main.bicep \
  --parameters virtualMachine/poc/parameters.json
```

## Key Vault Secret References

The included `parameters.json` files retrieve sensitive values directly from Azure Key Vault at deployment time, avoiding any plain-text secrets:

```json
{
  "adminUsername": {
    "reference": {
      "keyVault": {
        "id": "/subscriptions/<sub-id>/resourceGroups/<rg>/providers/Microsoft.KeyVault/vaults/<vault-name>"
      },
      "secretName": "vmadminUsername"
    }
  },
  "adminPassword": {
    "reference": {
      "keyVault": {
        "id": "/subscriptions/<sub-id>/resourceGroups/<rg>/providers/Microsoft.KeyVault/vaults/<vault-name>"
      },
      "secretName": "vmAdminPassword"
    }
  }
}
```

Required secrets in Key Vault (names must match exactly as shown, including casing):

| Secret Name | Description |
|-------------|-------------|
| `vmadminUsername` | Local administrator username |
| `vmAdminPassword` | Local administrator password |
| `domainJoinUserName` | Domain join username |
| `domainJoinUserPassword` | Domain join password |

## Environment Parameter Files

| Environment | Parameters File | Notes |
|-------------|-----------------|-------|
| PoC | `poc/parameters.json` | Uses Key Vault references; vNet points to PoC subnet |
| Dev | `dev/parameters.json` | Uses Key Vault references |
| Int | `int/parameters.json` | Uses Key Vault references |
| Prod | `prod/parameters.json` | Uses Key Vault references |
| Default | `default/parameters.json` (root) | Root-level template with full Key Vault references |

## Pipeline

The Azure DevOps pipeline is defined in `.azurepipelines/vm-pipeline.yaml`. It deploys to the PoC environment using `poc/main.bicep` and `poc/parameters.json`.

## Notes

- The deploying identity (service principal) must have **Get** permission on the Key Vault secrets used in parameter references.
- The `vNet` parameter must be the **subnet** resource ID (not the VNet resource ID) so the NIC can be placed directly in the correct subnet.
- Multiple VMs can be deployed in a single operation by adding names to the `vmList` array.
