# Base image with CUDA support
FROM nvidia/cuda:11.3.1-cudnn8-runtime-ubuntu20.04

# Install system dependencies
RUN dnf update && dnf install -y \
    git \
    python3 \
    python3-pip \
    python3-dev \
    curl

# Add github ssh key to environment
RUN mkdir -p ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts

# Install Python dependencies (PyTorch and Transformers)
RUN pip3 install torch transformers

# set the working directory
WORKDIR /P-tuning-v2

# Install additional Python dependencies from requirements.txt
RUN pip3 install -r requirements.txt

# Expose default port for monitoring (optional)
EXPOSE 8080

# Run the training script (ensure it runs in a shell)
CMD ["/bin/bash", "-c", "${RUN_SCRIPT:-run_script/run_rte_roberta.sh}"]