# Webtop

Build a secure development environment on macOS using [OrbStack](https://orbstack.dev/) (a fast and lightweight Docker environment that simplifies container management) and the [VSCode Dev Container](https://code.visualstudio.com/docs/remote/containers) (which provides isolated and reproducible development environments, enhancing security and consistency).

> This container is built based on the [linuxserver's webtop container](https://github.com/linuxserver/docker-webtop) (a docker linux image with desktop environment), hence the name "webtop". This base image is suitable for developing GUI programs on Linux, but you can choose your own base image according to your needs.

## Usage

Step 1: Build the Docker image for the development environment to ensure all necessary dependencies and configurations are included.

```bash
docker compose build
```

Step 2: Edit VSCode remote container config

Config location: The configuration file is typically stored in the VSCode global storage directory. You can locate it by navigating to `$HOME/Library/Application Support/Code/User/globalStorage/ms-vscode-remote.remote-containers/imageConfigs/` and finding the file corresponding to your container image (e.g., `your-image-name.json`).

```json
{
    "extensions": [
        "editorconfig.editorconfig",
        "github.copilot",
        "github.copilot-chat",
        "golang.go",
        "jinliming2.vscode-go-template",
        "ms-ceintl.vscode-language-pack-zh-hans",
        "ms-python.black-formatter",
        "ms-python.debugpy",
        "ms-python.isort",
        "ms-python.python",
        "ms-python.vscode-pylance"
    ],
    // The "remoteUser" specifies the default user inside the container.
    // Replace "abc" with the username you want to use in the container.
    "remoteUser": "abc"
}
```

Step 3: Start container

```bash
docker compose up -d
```

Step 4: Prepare Development Environment

Run the following scripts in sequence to configure the development environment: `01-install-ohmyzsh.sh`, `02-relink-ohmyzsh.sh`, and `03-install-conda.sh`.

If this is your second time creating the environment, you only need to run the second script `02-relink-ohmyzsh.sh`. This allows you to reuse the previous environment without reinstalling oh-my-zsh or Miniforge.

Step 5: Connect VSCode to the Container

Click to open the remote window -> Attach to the running container.

Then you can develop in a secure Linux container environment without worrying about polluting your macOS environment.

## Issues

Issue 1: The host filesystem must be case-sensitive; otherwise, the Miniforge installation may fail. This is because Miniforge creates and accesses files with names that differ only in letter casing, which can cause conflicts or errors on case-insensitive filesystems.

Solution: Add an APFS case-sensitive volume mount to /Volume/DATA, and then put the `/opt` directory to this volume. 
To create an APFS case-sensitive volume, you can use Disk Utility on macOS. Refer to this guide for detailed steps: 
[Create a case-sensitive APFS volume](https://support.apple.com/guide/disk-utility/create-and-delete-apfs-volumes-dsku19ed921c/mac).
