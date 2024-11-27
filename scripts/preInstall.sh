#set env vars
set -o allexport; source .env; set +o allexport;


mkdir -p ./langflow-data
chown -R 1000:1000 ./langflow-data

# Check if LANGFLOW_SECRET_KEY already exists in the .env file
if ! grep -q "^LANGFLOW_SECRET_KEY=" .env; then
    # Generate a new LANGFLOW_SECRET_KEY if not already set
    LANGFLOW_SECRET_KEY=$(openssl rand -hex 32)

    # Append the key to the .env file
    cat <<EOT >> ./.env

LANGFLOW_SECRET_KEY=${LANGFLOW_SECRET_KEY}

EOT
else
    echo "LANGFLOW_SECRET_KEY already exists in .env. Skipping key generation."
fi


cat <<EOT > ./servers.json
{
    "Servers": {
        "1": {
            "Name": "local",
            "Group": "Servers",
            "Host": "172.17.0.1",
            "Port": 40211,
            "MaintenanceDB": "postgres",
            "SSLMode": "prefer",
            "Username": "postgres",
            "PassFile": "/pgpass"
        }
    }
}
EOT
