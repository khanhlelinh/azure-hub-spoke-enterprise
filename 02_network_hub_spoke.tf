# LỚP MẠNG: KIẾN TRÚC HUB-SPOKE DÀNH CHO TẬP ĐOÀN

# 1. HUB VNet (Trung tâm điều khiển và Firewall)
resource "azurerm_virtual_network" "hub_vnet" {
  name                = "logistics_corp-Hub-VNet"
  location            = azurerm_resource_group.logistics_corp_rg.location
  resource_group_name = azurerm_resource_group.logistics_corp_rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "gateway_subnet" {
  name                 = "GatewaySubnet" # Tên bắt buộc của Azure cho VPN
  resource_group_name  = azurerm_resource_group.logistics_corp_rg.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# 2. SPOKE 1 VNet (Dành riêng cho hệ thống ERP / Kế toán / Nhân sự)
resource "azurerm_virtual_network" "spoke_erp_vnet" {
  name                = "logistics_corp-Spoke-ERP-VNet"
  location            = azurerm_resource_group.logistics_corp_rg.location
  resource_group_name = azurerm_resource_group.logistics_corp_rg.name
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_subnet" "erp_app_subnet" {
  name                 = "ERP-App-Subnet"
  resource_group_name  = azurerm_resource_group.logistics_corp_rg.name
  virtual_network_name = azurerm_virtual_network.spoke_erp_vnet.name
  address_prefixes     = ["10.1.1.0/24"]
}

# 3. SPOKE 2 VNet (Dành riêng cho Data Lake / Kho dữ liệu Xây dựng & Vận tải)
resource "azurerm_virtual_network" "spoke_data_vnet" {
  name                = "logistics_corp-Spoke-Data-VNet"
  location            = azurerm_resource_group.logistics_corp_rg.location
  resource_group_name = azurerm_resource_group.logistics_corp_rg.name
  address_space       = ["10.2.0.0/16"]
}

# 4. KẾT NỐI CÁC MẠNG VỚI NHAU (VNet Peering)
# Nối Hub với Spoke ERP
resource "azurerm_virtual_network_peering" "hub_to_erp" {
  name                      = "Hub-to-Spoke-ERP"
  resource_group_name       = azurerm_resource_group.logistics_corp_rg.name
  virtual_network_name      = azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.spoke_erp_vnet.id
}

# Nối Hub với Spoke Data
resource "azurerm_virtual_network_peering" "hub_to_data" {
  name                      = "Hub-to-Spoke-Data"
  resource_group_name       = azurerm_resource_group.logistics_corp_rg.name
  virtual_network_name      = azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.spoke_data_vnet.id
}
