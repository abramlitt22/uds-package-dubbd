#!/bin/bash


# Check if the runtime environment is Darwin (Mac OS X) or Linux
if [[ "$OSTYPE" == "darwin"* ]]; then
  ARCH_NAME=darwin
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  ARCH_NAME=linux
else
  echo "The OS is not supported"
  exit 1
fi

# Check the processor architecture
if [[ $(uname -m) == "x86_64" ]]; then
  echo "The processor architecture is 64-bit"
  ARCH_PROC=amd64
elif [[ $(uname -m) == "i686" || $(uname -m) == "i386" ]]; then
  echo "The processor architecture is 32-bit"
  echo "The processor is not AMD or ARM"
elif [[ $(uname -m) == "arm64" ]]; then
  ARCH_PROC=arm64
else
# default...
  ARCH_PROC=amd64
fi

ARCH_NAME=linux
ARCH_PROC=amd64

echo "HI!"
echo "ARCH_NAME: ${ARCH_NAME}"
echo "ARCH_PROC: ${ARCH_PROC}"

unzip tmp/terraform_${1}_${ARCH_NAME}_${ARCH_PROC}.zip -d .
mkdir -p run/loki/tf-plugins/registry.terraform.io/hashicorp/aws/${2}/${ARCH_NAME}_${ARCH_PROC}
unzip -xf tmp/terraform-provider-aws_${2}_${ARCH_NAME}_${ARCH_PROC}.zip -d run/loki/tf-plugins/registry.terraform.io/hashicorp/aws/${2}/${ARCH_NAME}_${ARCH_PROC}