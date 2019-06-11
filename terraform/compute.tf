module "bastion" {
	source	= "modules/bastion"
	instances = "1"
	region = "${var.region}"
	compartment_ocid = "${var.compartment_ocid}"
	subnet_id = "${module.network.bastion-id}" 
	availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.availability_domain - 1],"name")}"
	image_ocid = "${var.InstanceImageOCID[var.region]}"
	ssh_keypath = "${var.ssh_keypath}" 
        ssh_private_key = "${var.ssh_private_key}"
	ssh_public_key = "${var.ssh_public_key}"
	private_key_path = "${var.private_key_path}"
	bastion_instance_shape = "${var.bastion_instance_shape}" 
        log_volume_size_in_gbs = "${var.log_volume_size_in_gbs}"
        cloudera_volume_size_in_gbs = "${var.cloudera_volume_size_in_gbs}"
	user_data = "${base64encode(file("../scripts/boot.sh"))}"
	cloudera_manager = "cdh-utility-1.public${var.availability_domain}.${module.network.vcn-dn}"
	cm_version = "${var.cm_version}"
	cdh_version = "${var.cdh_version}"
}

module "utility" {
        source  = "modules/utility"
        instances = "1"
	region = "${var.region}"
	compartment_ocid = "${var.compartment_ocid}"
        subnet_id = "${module.network.public-id}"
	availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.availability_domain - 1],"name")}"
	image_ocid = "${var.InstanceImageOCID[var.region]}"
	ssh_keypath = "${var.ssh_keypath}"
	ssh_private_key = "${var.ssh_private_key}"
        ssh_public_key = "${var.ssh_public_key}"
        private_key_path = "${var.private_key_path}"
        utility_instance_shape = "${var.utility_instance_shape}"
        log_volume_size_in_gbs = "${var.log_volume_size_in_gbs}"
        cloudera_volume_size_in_gbs = "${var.cloudera_volume_size_in_gbs}"
        user_data = "${base64encode(file("../scripts/cloudera_manager.sh"))}"
	cm_install = "${base64gzip(file("../scripts/cm_boot_mysql.sh"))}"
	deploy_on_oci = "${base64gzip(file("../scripts/deploy_on_oci.py"))}"
        cloudera_manager = "cdh-utility-1.public${var.availability_domain}.${module.network.vcn-dn}"
        cm_version = "${var.cm_version}"
        cdh_version = "${var.cdh_version}"
	worker_shape = "${var.worker_instance_shape}"
	block_volume_count = "${var.block_volume_count}"
	AD = "${var.availability_domain}"
}

module "master" {
        source  = "modules/master"
        instances = "${var.master_node_count}"
	region = "${var.region}"
	compartment_ocid = "${var.compartment_ocid}"
        subnet_id = "${module.network.private-id}"
        availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.availability_domain - 1],"name")}"
	image_ocid = "${var.InstanceImageOCID[var.region]}"
	ssh_keypath = "${var.ssh_keypath}"
        ssh_private_key = "${var.ssh_private_key}"
        ssh_public_key = "${var.ssh_public_key}"
        private_key_path = "${var.private_key_path}"
        master_instance_shape = "${var.master_instance_shape}"
        log_volume_size_in_gbs = "${var.log_volume_size_in_gbs}"
        cloudera_volume_size_in_gbs = "${var.cloudera_volume_size_in_gbs}"
        user_data = "${base64encode(file("../scripts/boot.sh"))}"
        cloudera_manager = "cdh-utility-1.public${var.availability_domain}.${module.network.vcn-dn}"
        cm_version = "${var.cm_version}"
        cdh_version = "${var.cdh_version}"
}

module "worker" {
        source  = "modules/worker"
        instances = "${var.worker_node_count}"
	region = "${var.region}"
	compartment_ocid = "${var.compartment_ocid}"
        subnet_id = "${module.network.private-id}"
        availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.availability_domain - 1],"name")}"
	image_ocid = "${var.InstanceImageOCID[var.region]}"
        ssh_keypath = "${var.ssh_keypath}"
        ssh_private_key = "${var.ssh_private_key}"
        ssh_public_key = "${var.ssh_public_key}"
        private_key_path = "${var.private_key_path}"
        worker_instance_shape = "${var.worker_instance_shape}"
	log_volume_size_in_gbs = "${var.log_volume_size_in_gbs}"
	cloudera_volume_size_in_gbs = "${var.cloudera_volume_size_in_gbs}"
	block_volumes_per_worker = "${var.block_volumes_per_worker}"
	data_blocksize_in_gbs = "${var.data_blocksize_in_gbs}"
        user_data = "${base64encode(file("../scripts/boot.sh"))}"
        cloudera_manager = "cdh-utility-1.public${var.availability_domain}.${module.network.vcn-dn}"
        cm_version = "${var.cm_version}"
        cdh_version = "${var.cdh_version}"
	block_volume_count = "${var.block_volumes_per_worker}"
}
