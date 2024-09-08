# Base image with CUDA support
FROM nvidia/cuda:11.3.0-cudnn8-runtime-ubuntu20.04

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    python3 \
    python3-pip \
    python3-dev \
    curl

# Install Python dependencies (PyTorch and Transformers)
RUN pip3 install torch transformers

# Clone the P-tuning v2 repo and set the working directory
RUN git clone git@github.com:omrirh/P-tuning-v2.git
WORKDIR /P-tuning-v2

# Install additional Python dependencies from requirements.txt
RUN pip3 install -r requirements.txt

# Expose default port for monitoring (optional)
EXPOSE 8080

# Run the training script (ensure it runs in a shell)
CMD ["/bin/bash", "-c", "${RUN_SCRIPT:-run_script/run_rte_roberta.sh}"]