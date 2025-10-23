# Use the official LaTeX image from the Docker Hub
FROM kjarosh/latex:2025.1-basic

# Update package list and install Python and pip
RUN apk update && \
    apk add --no-cache python3 py3-pip git

# Install OpenAI library
RUN pip3 install --break-system-packages openai

# Install additional LaTeX packages
# Update tlmgr itself first and then install packages with verification
RUN tlmgr update --self || true && \
    tlmgr install --verify-repo=none parskip etoolbox needspace enumitem lineno xcolor && \
    echo "Verifying package installation..." && \
    kpsewhich etoolbox.sty || (echo "ERROR: etoolbox.sty not found after installation" && exit 1)

# Set the working directory
WORKDIR /workspace

# Copy the local files to the container
COPY . /workspace

# Default command to compile the LaTeX document
CMD ["sh"]
