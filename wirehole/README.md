# WireHole

[From Wirehole](https://github.com/IAmStoxe/wirehole)

## Features

- Wireguard VPN
- PiHole (DNS Sinkhole)
- Unbound (DNS Resolver)
- [Restic Backup Server](https://github.com/restic/restic) (Additional)
- [Docker Registry](https://hub.docker.com/_/registry) (Additional)

## Usage

1. Clone this repository
2. Copy `env.tmpl` to `.env` and fill in the variables

   1. `WIREGUARD_SERVER_URL` should be the public IP address of your server (or the domain name if you have one)
   2. `WIREGUARD_PEERS` comma separated list of peer names or just a number of peers to generate
   3. `PIHOLE_WEBPASSWORD` is the password for the PiHole web interface (Optional - can be generated with `openssl rand -base64 32`)
   4. `TIMEZONE` is the timezone for the server (Europe/Berlin)

3. Run `docker-compose up -d`
4. Configure Wireguard client:

   1. Phone:
      1. Run `docker-compose logs` to see the qr code for your Wireguard client
      2. Use the qr code to add the Wireguard client to your phone
   2. Computer:
      1. Use the config in `./wireguard/peer_<peer_name>/peer_<peer_name>.conf`
      2. Import the config into your Wireguard client

5. Run `docker-compose exec wireguard wg` to see the current status of your Wireguard server
