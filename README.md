# BLOCProxy Performance

The entire experiment can be run on an existing 4 node cluster ([look here](#assumptions)) by running the `run.sh` script.

## Get All the Repos

```bash
git clone --recurse-submodules -j4 https://github.com/MSrvComm/Experiments
```

## Citation: 
```None
BLOC: Balancing Load with Overload Control In the Microservices Architecture
```

## Build and Deploy

### Assumptions

- We assume that the experiments will be running on a Kubernetes cluster able to run 50-60 pods with 2 containers each. Further details on configuration can be found in the deployement yaml files. In our experiments, we used 4 Cloudlab servers, each with four 10 core sockets and 196 GB of RAM.

- The experiments are being run from an Ubuntu machine

- Python3 is installed on the system

### Define Image Names as Environment Variables

```bash
# format: hub_name/image_name:version
export WEB_IMG_NAME=ratnadeepb/testapp:latest
export BLOC_PROXY_IMG_NAME=ratnadeepb/micoproxy:latest
export LC_PROXY_IMG_NAME=ratnadeepb/micoproxy:leastconn
```

### Build the Docker Images

```bash
cd BLOC/app && ./docker_build.sh $WEB_IMG_NAME && cd $OLDPWD
cd BLOCProxy && ./build_proxy.sh $BLOC_PROXY_IMG_NAME && cd $OLDPWD
```

### Deploy the Control Plane

```bash
cd BLOCControl/restEpWatcher && ./deploy.sh && cd $OLDPWD
```

### Remove taint and Label the nodes

```bash
kubectl taint nodes --all node-role.kubernetes.io/master-
```

We labeled the nodes so that 10 backend servers can run on one physical node.

Example command (node names will have to be changed):
```bash
kubectl label nodes node0,node1,node2 workload=svc1
kubectl label nodes node3 workload=svc2
```

### Install the hey load generator

```bash
wget https://hey-release.s3.us-east-2.amazonaws.com/hey_linux_amd64
chmod +x hey_linux_amd64
sudo mv hey_linux_amd64 /usr/local/bin/hey
```

### Install Python Requirements

```bash
pip install -r requirements.txt
```

### Running the experiments

```bash
./run.sh
```

### Graphing the results as in Figure 8 of the paper

This will store the results in a file called `BLOCProxyVsLeastConn.pdf`

```bash
./graph.py
```