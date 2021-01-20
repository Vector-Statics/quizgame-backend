terraform {
  backend "remote" {
    organization = "Vector-Statics"

    workspaces {
      name = "gh-actions"
    }
  }
}
