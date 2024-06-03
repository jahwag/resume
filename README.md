# CV
This repository contains my latest CV.

[![Preview of CV](preview.png "Preview of CV")](resume-eng.pdf)

### Automation with GitHub Actions
This repository includes a GitHub Actions workflow to automatically generate and translate the CV into both English and Swedish, producing two PDF files: `resume-eng.pdf` and `resume-sve.pdf`.

### How to Set Up and Use the Custom Docker Image
To optimize the workflow and reduce setup time, follow these steps to create and use a custom Docker image with all the necessary dependencies.

#### Step 1: Build and Push the Docker Image
Build the Docker image and push it to Docker Hub.

# Build the Docker image
docker build -t jahwag/latex-openai:latest .

# Log in to Docker Hub
docker login

# Push the Docker image to Docker Hub
docker push jahwag/latex-openai:latest

### Credits
This is a fork of a fantastic LaTeX template by Trey Hunner.

### Contributing
Feel free to fork this repository and make your own version. I appreciate it if you include a credit thanking me.