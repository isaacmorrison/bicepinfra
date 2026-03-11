# Bicep Infrastructure Modules

A collection of reusable Azure Bicep modules for deploying common infrastructure resources. Each module is versioned and published to an Azure Container Registry (ACR) for use across environments.

## Modules

| Module | Description | Folder |
|--------|-------------|--------|
| [App Service](./appService/README.md) | Azure App Service Plan and Web App | `appService/` |
| [Key Vault](./keyVault/README.md) | Azure Key Vault | `keyVault/` |
| [Log Analytics](./LogAnalytics/README.md) | Azure Log Analytics Workspace | `LogAnalytics/` |
| [Network Security Group](./NSG/README.md) | Azure Network Security Group (NSG) | `NSG/` |
| [Storage Account](./storageAccount/README.md) | Azure Storage Account | `storageAccount/` |
| [Virtual Machine](./virtualMachine/README.md) | Azure Virtual Machine with optional domain join | `virtualMachine/` |

## Repository Structure

Each module follows a consistent folder layout:

```
<ModuleName>/
├── .azurepipelines/
│   └── <module>-pipeline.yaml   # Azure DevOps pipeline definition
├── default/
│   └── main.bicep               # Bicep template (references module in ACR)
├── poc/
│   └── parameters.json          # PoC environment parameters
├── dev/
│   └── parameters.json          # Dev environment parameters
├── int/
│   └── parameters.json          # Integration environment parameters
└── prod/
    └── parameters.json          # Production environment parameters
```

## Prerequisites

- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) ≥ 2.40
- [Bicep CLI](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/install) ≥ 0.15
- An Azure subscription with appropriate RBAC permissions
- Access to the ACR hosting the published module images (`pocacr.azurecr.io`)

## Usage

### Deploy a module manually

Log in to Azure and deploy a module to a resource group using the Azure CLI:

```bash
az login
az group create --name <resource-group> --location "West US"
az deployment group create \
  --resource-group <resource-group> \
  --template-file <ModuleName>/default/main.bicep \
  --parameters <ModuleName>/poc/parameters.json
```

### Reference a module from your own Bicep template

All modules are published to the private ACR at `pocacr.azurecr.io`. Reference them using the Bicep registry syntax:

```bicep
module myResource 'br:pocacr.azurecr.io/bicepmodules/<module-name>:v1' = {
  name: 'myDeploy'
  params: {
    // module-specific parameters
  }
}
```

Replace `<module-name>` with one of: `appservice`, `keyvault`, `loganalytics`, `nsg`, `storage`, `virtualmachine`.

## CI/CD Pipelines

Each module includes an Azure DevOps pipeline (`.azurepipelines/`) that:

1. Triggers manually (`trigger: none`) or on a schedule
2. Creates the target resource group if it does not exist
3. Runs `az deployment group create` with the environment-specific parameter file
4. Supports multi-stage deployments (PoC → Dev → Int → Prod)

**Service Connection:** `service-connection`  
**Default Resource Group:** `aya-devops-bicep-poc`  
**Default Location:** `West US`

## Environments

| Environment | Folder | Purpose |
|-------------|--------|---------|
| `poc` | `poc/` | Proof-of-Concept / sandbox testing |
| `dev` | `dev/` | Development |
| `int` | `int/` | Integration / staging |
| `prod` | `prod/` | Production |
| `default` | `default/` | Default template (used by PoC pipeline) |

## Contributing

1. Fork this repository.
2. Create a feature branch: `git checkout -b feature/my-new-module`.
3. Add your Bicep template under `<ModuleName>/default/main.bicep`.
4. Add environment parameter files as needed.
5. Update this README and the module-level README.
6. Open a pull request.

## License

This project is provided as-is for educational and demonstration purposes.
