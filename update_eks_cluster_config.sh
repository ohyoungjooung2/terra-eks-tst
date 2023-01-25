#!/bin/bash
echo $KUBECONFIG
aws eks update-kubeconfig --region ap-northeast-2 --name $1
