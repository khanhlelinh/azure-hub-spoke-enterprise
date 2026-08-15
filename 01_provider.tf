# KHỞI TẠO NHÀ CUNG CẤP DỊCH VỤ ĐÁM MÂY
# Nền tảng: Microsoft Azure

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Tạo Resource Group tập trung cho toàn bộ Dự án Chuyển đổi số
resource "azurerm_resource_group" "logistics_corp_rg" {
  name     = "logistics_corp-Digital-Transformation-RG"
  location = "Southeast Asia" # Máy chủ đặt tại Singapore để tốc độ về VN nhanh nhất
  
  tags = {
    Environment = "Production"
    Project     = "Comprehensive Digital Transformation"
    Department  = "IT"
  }
}
