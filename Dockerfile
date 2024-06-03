# Use the official LaTeX image from the Docker Hub
FROM kjarosh/latex:2024.2-basic

# Update package list and install Python and pip
RUN apk update && \
    apk add --no-cache python3 py3-pip

# Install OpenAI library
RUN pip3 install --break-system-packages openai

# Install additional LaTeX packages
RUN tlmgr install parskip etoolbox needspace enumitem

# Set the working directory
WORKDIR /workspace

# Copy the local files to the container
COPY . /workspace

# Default command to compile the LaTeX document
CMD ["sh"]
