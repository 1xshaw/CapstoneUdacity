aws cloudformation update-stack \
 --stack-name $1 \
 --template-body file://$2 \
 --region=us-west-2

 aws cloudformation create-stack \
--stack-name udacityclouddevopscapstone \
--region us-west-2 \
--template-body file://infrastructure/aws-eks.yml \
--parameters file://infrastructure/eks-params.json \
--capabilities CAPABILITY_IAM