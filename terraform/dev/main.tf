terraform {
  backend "remote" {
    organization = "KiwiSheets"

    workspaces {
      name = "KiwiSheets-GraphQL-Server-Dev"
    }
  }
}

provider "nomad" {
  ca_file = "nomad-ca.pem"
}

resource "nomad_job" "gql_server" {
  jobspec = templatefile("${path.module}/jobs/gqlserver.hcl", {
    version = var.image_version
  })
  detach = false
}
