# Running Experiments with BLOCProxy

## Citation: `BLOC: Balancing Load with Overload Controls`

## Build the BLOC web tool and BLOCProxy docker images

### BLOCProxy

```bash
sudo docker build -t <insert_hub_name_here>/blocproxy:latest .
sudo docker push <insert_hub_name_here>/blocproxy:latest
```

### The BLOC web tool

```bash
export WEB_IMG_NAME=<web_tool_image_name> # format: hub_name/image_name:version

```