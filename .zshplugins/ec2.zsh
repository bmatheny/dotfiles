#-----------------------------------------------------------------------------
# Setup EC2 Variables
#-----------------------------------------------------------------------------
export EC2_CREDENTIALS="${HOME}/.ec2_credentials";
export EC2_HOME="${HOME}/bin/ec2-api-tools";

if [[ -d $EC2_HOME ]]; then
  path+=("${EC2_HOME}/bin")
  if [[ ! -f $EC2_CREDENTIALS ]]; then
    echo "export EC2_PRIVATE_KEY=~/.ssh/mobocracy.x509.pk.pem" > ${EC2_CREDENTIALS};
    echo "export EC2_CERT=~/.ssh/mobocracy.x509.pem" >> ${EC2_CREDENTIALS};
    echo "Setup some EC2 credentials in ${EC2_CREDENTIALS}";
    echo "Verify that they are correct";
  fi
  source ${EC2_CREDENTIALS}
fi
