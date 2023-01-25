# aws-terra-dev-dp
#Get optimized image command
aws ssm get-parameter --name /aws/service/eks/optimized-ami/1.24/amazon-linux-2/recommended/image_id --region ap-northeast-2 --query "Parameter.Value" --output text