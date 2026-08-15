# HỆ THỐNG MÁY CHỦ CHẠY ERP (NẰM TRONG SPOKE 1)

# Giao diện mạng (NIC) cho máy chủ ERP
resource "azurerm_network_interface" "erp_nic" {
  name                = "logistics_corp-ERP-NIC"
  location            = azurerm_resource_group.logistics_corp_rg.location
  resource_group_name = azurerm_resource_group.logistics_corp_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.erp_app_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Máy chủ ảo Windows Server (Tiêu chuẩn cho phần mềm Kế toán/ERP VN)
resource "azurerm_windows_virtual_machine" "erp_vm" {
  name                = "logistics_corp-ERP-VM"
  resource_group_name = azurerm_resource_group.logistics_corp_rg.name
  location            = azurerm_resource_group.logistics_corp_rg.location
  size                = "Standard_D4s_v5" # Dòng CPU mạnh mẽ cho ERP
  admin_username      = "logistics_corpadmin"
  admin_password      = "P@ssw0rd1234!" # Trong thực tế dùng KeyVault

  network_interface_ids = [
    azurerm_network_interface.erp_nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS" # Ổ cứng SSD NVMe siêu tốc
    disk_size_gb         = 256
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }
}
