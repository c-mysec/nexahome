data "oci_core_images" "oracle_linux_arm" {
  compartment_id = var.compartment_ocid
  operating_system         = "Oracle Linux"
  operating_system_version = "9"
  shape                     = "VM.Standard.A1.Flex"
  sort_by                   = "TIMECREATED"
  sort_order                = "DESC"
}

resource "oci_core_instance" "a1" {
  compartment_id      = var.compartment_ocid
  availability_domain = local.ad
  display_name        = var.vm_name
  shape               = "VM.Standard.A1.Flex"

  shape_config {
    # Max Always Free OCPUs
    ocpus         = 4
    # Max Always Free Memory (6GB per OCPU)
    memory_in_gbs = 24
  }

  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.oracle_linux_arm.images[0].id
    # Max Always Free Block Storage
    boot_volume_size_in_gbs = 200
}

  create_vnic_details {
    subnet_id        = oci_core_subnet.public.id
    assign_public_ip = true
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    user_data = base64encode(file("../cloud-init/docker.sh"))
  }
}
