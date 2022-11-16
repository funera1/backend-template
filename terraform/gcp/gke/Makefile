GCP_PROJECT=$(shell gcloud info --format='value(config.project)')
TERRAFORM_SA=terraform-service-account

# アカウント作成
.PHONY: init/gcp
init/gcp: create-account role-binding

.PHONY: create-account
create-account:
	gcloud iam service-accounts create $(TERRAFORM_SA) \
		--project=$(GCP_PROJECT) \
		--display-name $(TERRAFORM_SA)
.PHONY: create-account
role-binding: 
	TERRAFORM_SA_EMAIL := \
	  $(shell gcloud iam service-accounts list \
		--project=$(GCP_PROJECT) \
		--filter="displayName:$(TERRAFORM_SA)" \
		--format=value(email))
role-binding:
	gcloud projects add-iam-policy-binding $(GCP_PROJECT) \
		--role roles/iam.serviceAccountUser \
		--member serviceAccount:$(TERRAFORM_SA_EMAIL)
	gcloud projects add-iam-policy-binding $(GCP_PROJECT) \
		--role roles/compute.admin \
		--member serviceAccount:$(TERRAFORM_SA_EMAIL)
	gcloud projects add-iam-policy-binding $(GCP_PROJECT) \
		--role roles/storage.admin \
		--member serviceAccount:$(TERRAFORM_SA_EMAIL)
	gcloud projects add-iam-policy-binding $(GCP_PROJECT) \
		--role roles/container.clusterAdmin \
		--member serviceAccount:$(TERRAFORM_SA_EMAIL)

.PHONY: create-gke
create-gke: TERRAFORM_SA_DEST := ~/.gcp/terraform-service-acount.json
create-gke:
	TERRAFORM_SA_EMAIL := $(shell gcloud iam service-accounts list \
		--filter="displayName:$(TERRAFORM_SA)" \
		--format=value(email))
	gcloud iam service-accounts keys create $(TERRAFORM_SA_DEST) \
		--iam-account $(TERRAFORM_SA_EMAIL)
	export GOOGLE_APPLICATION_CREDENTIALS=$(TERRAFORM_SA_DEST)
	terraform init
