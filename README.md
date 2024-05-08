<div align=center style="text-align: center;">
<h1>FIKA Tarkov - Dockerized (Stay in Tarkov fork)</h1>
Platform independent. / Unofficial.
</div>

---

## How to use this Repo?

1. Install [DOCKER](https://docs.docker.com/engine/install/)
2. `git clone https://github.com/SangBinSong/FIKA.Docker.git`
3. `cd FIKA.Docker`

Editing...

## Use Link

[FIKA Server](https://github.com/project-fika/Fika-Server)

[SPT-AKI Server](https://dev.sp-tarkov.com/SPT-AKI/Server)

---
## Original README

1. Build the server 
	
   Equivalent to release SITCoop-1.6.4-WithAki-3.8.0-2dd4d9 (0.14.1.3.29351):
   ```bash
   docker build \
      --no-cache \
      --build-arg SIT=26b9c364963ba49de71d5761bed1135ddad50f77  \
      --build-arg SPT=2dd4d914382657378d9cdec173039d771fe33220 \
      --label SITCoop \
      -t sitcoop .
   ```
   Same, but in one line:
   ```bash
   docker build --no-cache --build-arg SIT=26b9c364963ba49de71d5761bed1135ddad50f77 --build-arg SPT=2dd4d914382657378d9cdec173039d771fe33220 --label SITCoop -t sitcoop .
   ```
   
   > Windows dont handle the \\, use the oneliner!

   > For version SITCoop-1.5.1 (0.13.9.1.27622), go [here](https://github.com/stayintarkov/SIT.Docker/tree/82727f8dea553a5294b321590d933d9722c26b53)

2. Run the image once:
   ```bash
   docker run --pull=never -v $PWD/server:/opt/server -p 6969:6969 -p 6970:6970 -p 6971:6971 -it --name sitcoop sitcoop
   ```
   - ⚠️ If you don't set the -v (volume), you won't be able to do a required step!

   - On **Linux** you can include `--user $(id -u):$(id -g)`, this way, file ownership will be set to the user who started the container.
   ```bash
   docker run --pull=never --user $(id -u):$(id -g) -v $PWD/server:/opt/server -p 6969:6969 -p 6970:6970 -p 6971:6971 -it --name sitcoop sitcoop
   ```

3. Go to your `./server` directory, delete `delete_me`, and optionally install additional mods, make config changes, etc.
    > Using `-p6969:6969`, you expose the port to `0.0.0.0` (meaning: open for LAN, localhost, VPN address, etc).
    > 
    > You can specify `-p 192.168.12.34:6969:6969` for each port if you don't want the ports to listen on all interfaces. 
   
4. Start your server (and enable auto restart):
 ```bash
docker start sitcoop
docker update --restart unless-stopped sitcoop
```
1. ... wait a few seconds, then you can connect to `http://YOUR_IP:6969`

## Bugs and Issues
No Feedback
