# Base image with CUDA support
FROM nvidia/cuda:11.3.1-cudnn8-runtime-ubuntu20.04

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    python3 \
    python3-pip \
    python3-dev \
    curl

WORKDIR /P-tuning-v2

COPY . .

RUN pip3 install -r requirements.txt

# Run the training script (ensure it runs in a shell)
CMD ["/bin/bash", "-c", "${RUN_SCRIPT:-run_script/run_rte_roberta.sh}"]