terraform {
  required_version = ">= 0.13"
  required_providers {
    azurerm = {
      # The "hashicorp" namespace is the new home for the HashiCorp-maintained
      # provider plugins.
      #
      # source is not required for the hashicorp/* namespace as a measure of
      # backward compatibility for commonly-used providers, but recommended for
      # explicitness.
      source  = "hashicorp/azurerm"
      version = ">= 2.0.0"
    }
  }
  # Backend for configuring remote state files to Azure Storage
  backend "azurerm" {
    resource_group_name   = "TerraformStateRG"
    storage_account_name  = "terraformstatesaae"
    container_name        = "tfstate"
    key                   = "application.tfstate"
  }
}

provider "azurerm" {
  # alias = "ShdSvc"
  # version = ">= 2.0.0"
  features {
    key_vault {
      // Should the azurerm_key_vault resource recover a Key Vault which has previously been Soft Deleted?
      recover_soft_deleted_key_vaults = true

      // Should the azurerm_key_vault resource be permanently deleted (e.g. purged) when destroyed?
      purge_soft_delete_on_destroy = true
    }

    virtual_machine {
      // Should the azurerm_linux_virtual_machine and azurerm_windows_virtual_machine resources delete the OS Disk 
      // attached to the Virtual Machine when the Virtual Machine is destroyed?
      delete_os_disk_on_deletion = true
    }

    virtual_machine_scale_set {
      // Should the azurerm_linux_virtual_machine_scale_set and azurerm_windows_virtual_machine_scale_set 
      // resources automatically roll the instances in the Scale Set when Required 
      // (for example when updating the Sku/Image)?
      roll_instances_when_required = true
    }
  }
  #(Optional) The Subscription ID which should be used. This can also be sourced from the ARM_SUBSCRIPTION_ID Environment Variable.
  // subscription_id = "subscription_id-example"

  #(Optional) The Client ID which should be used. This can also be sourced from the ARM_CLIENT_ID Environment Variable.
  // client_id = "client_id-example"

  // client_secret = "client_secret-example"

   #(Optional) The Tenant ID which should be used. This can also be sourced from the ARM_TENANT_ID Environment Variable.
  // tenant_id = "tenant_id-example"

  #(Optional) The Cloud Environment which should be used. Possible values are public, usgovernment, german and china. Defaults to public. This can also be sourced from the ARM_ENVIRONMENT environment variable.
  environment = "public"
}