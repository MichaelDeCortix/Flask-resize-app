terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
}

data "yandex_compute_image" "base_image" {
  family = var.yc_image_family
}

resource "yandex_compute_instance" "node" {
  count       = var.cluster_size
  name        = "yc-auto-instance-${count.index}"
  hostname    = "yc-auto-instance-${count.index}"
  description = "yc-auto-instance-${count.index} of my cluster"
  zone        = element(var.zones, count.index)

  resources {
    cores  = var.instance_cores
    memory = var.instance_memory
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.base_image.id
      type     = "network-hdd"
      size     = "10"
    }
  }


  network_interface {
    subnet_id = element(local.subnet_ids, count.index)[0]
    nat       = true
  }

  metadata = {
    ssh-keys  = "ubuntu:${file("${var.public_key_path}")}"
    user-data = "${file("init/metadata.yaml")}"
  }

  labels = {
    node_id = "${count.index}"
  }
}

locals {
  external_ips = ["${yandex_compute_instance.node.*.network_interface.0.nat_ip_address}"]
  internal_ips = ["${yandex_compute_instance.node.*.network_interface.0.ip_address}"]

}
