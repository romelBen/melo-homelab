terraform {
  required_version =  "1.7.2"

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "melo"

    workspaces {
      name = "melo-homelab-external"
    }
  }

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.11.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.9.0"
    }

    http = {
      source  = "hashicorp/http"
      version = "~> 3.2.0"
    }
  }
}

provider "cloudflare" {
  email   = var.cloudflare_email
  api_key = var.cloudflare_api_key
}

provider "kubernetes" {
    config_path = "${path.root}/metal/roles/k3s/kubeconfig.yaml"
    
  # Use KUBE_CONFIG_PATH environment variables
  # Or in cluster service account
}
