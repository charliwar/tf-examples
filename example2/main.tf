module "cluster1" {
  source  = "./gcloud1/"
  servers = 2
  machine_type = "f1-micro"
}

module "cluster2" {
  source  = "./gcloud2/"
  servers = 2
}
