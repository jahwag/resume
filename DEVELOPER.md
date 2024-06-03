
## Usage
The GitHub Actions workflow automates the following steps:

- Checks out the repository.
- Creates an output directory.
- Compiles the LaTeX resume to a PDF (English).
- Translates the LaTeX file to Swedish using the OpenAI API.
- Compiles the translated LaTeX file to a PDF (Swedish).
- Uploads the generated PDFs to the gh-pages branch for easy access.

### Building and Pushing the Docker Image

To build and push the Docker image to Docker Hub, follow these steps:

**Build the Docker Image**

Navigate to the directory containing the Dockerfile and run:

   ```sh
   docker build -t <your-dockerhub-username>/latex-openai:latest .
   ```

**Log in to Docker Hub**

Log in to your Docker Hub account using the Docker CLI:

```sh
docker login
```
Enter your Docker Hub username and password when prompted.

**Push the Docker Image**

Push the newly built image to your Docker Hub repository:

```sh
docker push <your-dockerhub-username>/latex-openai:latest
```

### Contributing
Feel free to fork this repository and make your own version. I appreciate it if you include a credit thanking me.






----

I want to split it up in a public part that links to my github page for cv, and a technical part with the instructions