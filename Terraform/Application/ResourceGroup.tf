resource "azurerm_resource_group" "AppResourceGroup" {
    name = "${var.AppName}-${var.Environment}-RG"
    location = var.Location
    tags = {
        Environment = var.Environment
        CreatedBy = "Terraform"
    }
 }

 resource "random_integer" "random_int" {
  min     = 1
  max     = 100
}