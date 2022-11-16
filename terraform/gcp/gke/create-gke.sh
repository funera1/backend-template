TERRAFORM_SA_DEST=~/.gcp/terraform-service-acount.json

mkdir -p $(dirname $TERRAFORM_SA_DEST)

TERRAFORM_SA_EMAIL=$(gcloud iam service-accounts list \
    --filter="displayName:$TERRAFORM_SA" \
    --format='value(email)')

gcloud iam service-accounts keys create $TERRAFORM_SA_DEST \
    --iam-account $TERRAFORM_SA_EMAIL

export GOOGLE_APPLICATION_CREDENTIALS=$TERRAFORM_SA_DEST

terraform init
