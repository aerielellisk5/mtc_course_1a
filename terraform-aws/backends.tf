terraform {
  cloud {
    organization = "akawasaki-terraform-sandbox"

    workspaces {
      name = "mtc-dev-1"
    }
  }
}