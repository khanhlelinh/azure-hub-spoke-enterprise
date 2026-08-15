# HÀNG RÀO BẢO MẬT (NETWORK SECURITY GROUP)

# Tường lửa bảo vệ máy chủ ERP
resource "azurerm_network_security_group" "erp_nsg" {
  name                = "logistics_corp-ERP-NSG"
  location            = azurerm_resource_group.logistics_corp_rg.location
  resource_group_name = azurerm_resource_group.logistics_corp_rg.name

  # Cho phép Web Traffic
  security_rule {
    name                       = "Allow_HTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Cấm hoàn toàn Remote Desktop (RDP) từ Internet
  security_rule {
    name                       = "Block_Internet_RDP"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
}

# Gắn Tường lửa vào mạng lưới ERP
resource "azurerm_subnet_network_security_group_association" "erp_nsg_assoc" {
  subnet_id                 = azurerm_subnet.erp_app_subnet.id
  network_security_group_id = azurerm_network_security_group.erp_nsg.id
}
