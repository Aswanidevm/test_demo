resource "google_compute_instance" "vm" {
  name         = "my-instance"
  machine_type = "n2-standard-2"
  zone         = "asia-south1-a"

  tags = ["foo", "bar"]


    boot_disk {
      initialize_params {
        image = "debian-cloud/debian-11"
        labels = {
        my_label = "value"
      }
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "NVME"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = "sa-iap-proxy-accessor@jmc-devsecops.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }
}
resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = "true"
}