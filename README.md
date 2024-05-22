<div align=center style="text-align: center;">
<h1>FIKA Tarkov - Dockerized (Stay in Tarkov fork)</h1>
Platform independent. / Unofficial.
</div>

---

## How to use this Repo?

1. Install [DOCKER](https://docs.docker.com/engine/install/)
2. `git clone https://github.com/SangBinSong/FIKA.Docker.git`
3. `cd FIKA.Docker/FIKA`
4. Modify version, image name for context
   * Default version
     * spt: 3.8.3
     * fika: v2.1.0
   * Default image name
     * spt : spt/spt-server:3.8.3
     * fika : spt/fika-server:v2.0
5. `docker compose build`
    1. If not first build, `docker compose build `
6. If build success, `docker compose up -d`
7. enjoy!

---

## Additional actions

#### Docker command

```bash
# Show ps
docker compsoe ps

# Show log
docker compsoe logs -f -n 300

# server stop
docker compsoe stop

# remove build cache
docker buildx prune
```

#### Docker compose args

```docker
args: 
SPT : tag name
SPT_COMMIT : commit hash
FIKA : tag name
FIKA_COMMIT : commit hash
```
---

## Use Link

[FIKA Server](https://github.com/project-fika/Fika-Server)
[SPT-AKI Server](https://dev.sp-tarkov.com/SPT-AKI/Server)

## Bugs and Issues

No Feedback
