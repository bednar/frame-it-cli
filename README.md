
# FrameIt CLI Docker Image

[![Docker Image Version](https://img.shields.io/docker/v/bednar/frame-it-cli)](https://hub.docker.com/r/bednar/frame-it-cli)

This Docker image is designed to simplify the use of the FrameIt command in [Fastlane](https://fastlane.tools), which automates the process of adding device frames to screenshots.

## Prerequisites

Ensure you have Docker installed on your system to use this image. Download Docker from [Docker's official site](https://www.docker.com/get-started).

## Getting the Docker Image

The Docker image is hosted on Docker Hub and can be pulled using the following command:

```bash
docker pull bednar/frame-it-cli
```

## Building the Docker Image Locally

If you prefer to build the image locally, clone this repository and navigate to the directory containing the Dockerfile. Run the following command:

```bash
docker build -t bednar/frame-it-cli .
```

## Usage

With the Docker image, you can execute various commands using Fastlane's [FrameIt](https://docs.fastlane.tools/actions/frameit/#frameit). Here are some example commands:

### Adding Frames to Screenshots

To add device frames to your screenshots, use the following command:

```bash
docker run -it --rm -v $(pwd):/app bednar/frame-it-cli frameit
```

### Specifying a Custom Configuration File

If you have a custom FrameIt configuration file, you can specify it using the following command:

```bash
docker run -it --rm -v $(pwd):/app bednar/frame-it-cli frameit --config path/to/your/Framefile.json
```

### Specifying a Screenshots Directory

You can specify the directory where your screenshots are located:

```bash
docker run -it --rm -v $(pwd):/app bednar/frame-it-cli frameit --path path/to/your/screenshots
```

## Contributing

We welcome contributions from the community. Whether it's improving the Dockerfile, adding more examples, or reporting issues, your input is appreciated.

## License

This project is released under the MIT License. See the [`LICENSE`](https://github.com/bednar/frame-it-cli/blob/main/LICENSE) file in the repository for more details.

## Contact

If you have any questions or need help, please open an issue in this GitHub repository for support and inquiries. Follow this link to create a new issue: [Open an Issue](https://github.com/bednar/frame-it-cli/issues/new).
