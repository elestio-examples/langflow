#set env vars
set -o allexport; source .env; set +o allexport;

LANGFLOW_SECRET_KEY=$(openssl rand -hex 32)

cat << EOT >> ./.env

LANGFLOW_SECRET_KEY=${LANGFLOW_SECRET_KEY}

EOT


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