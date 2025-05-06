# docker-headless-automation
An Ubuntu 20.04 Docker image with a virtual desktop (Xvfb) and Crontab, enabling the execution of automated Python3 scripts that require a graphical user interface (GUI). It supports Selenium for web automation (along with Chrome, ChromeDriver) and PyAutoGUI for GUI-based automation tasks.

## Features

- **Ubuntu 20.04** base image
- **Xvfb** (X Virtual Frame Buffer) for virtual desktop support
- **Crontab** to schedule and automate tasks
- **Selenium** for web automation in a headless Chrome environment
- **Chrome** and **ChromeDriver** for browser automation
- **PyAutoGUI** for GUI automation tasks
- Configurable time zone and volume paths
- Ability to run custom Python scripts with Docker exec (or automated with `Crontab`)

## Getting Started

### Prerequisites

Make sure you have Docker and Docker Compose installed on your system.

### Building and Running the Container

To build and start the container, use the following command:

```bash
docker compose up --build -d
````

This will build the container and run it in detached mode.

### Configuration

#### 1. **Volume Configuration**

By default, the volume that holds the application code (e.g., your Python scripts) is mounted from the `./app` directory. If you want to configure a different volume or directory for your application, you can adjust the volume mapping in your `docker-compose.yml` file.

For example, to change the volume location:

```yaml
volumes:
  - /opt/docker/volumes/docker-headless-automation:/app  # Change '/opt/docker/volumes/docker-headless-automation' to your desired directory
```

Alternatively, you can use a **symbolic link** to point to the desired directory. If you have the volume in a different location (e.g., `/opt/docker/volumes/docker-headless-automation`), you can create a symlink:

```bash
ln -s ./volumes /opt/docker/volumes/docker-headless-automation
```

Please make sure the desired directory is available. As example you can create it with:

```bash
sudo mkdir -p /opt/docker/volumes/docker-headless-automation
```

#### 2. **Changing the Time Zone**

To configure the time zone for the container, you can modify the environment variable in the `docker-compose.yml` file:

```yaml
environment:
  - TZ=Europe/Berlin  # Change 'Europe/Berlin' to your desired time zone
```

You can find a list of supported time zones [here](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones).

#### 3. **Editing Cron Jobs**

To edit the cron jobs, modify the `crontab.txt` file located in the `./app` directory. Any changes made to this file require a **restart of the container** to take effect.

### Running Python Scripts Manually

To execute a script manually inside the container, you can use the `docker exec` command:

```bash
docker exec -it <container_name> /usr/bin/python3 /app/script.py
```

Replace `<container_name>` with the name of the running container. If you're not sure of the container name, use `docker ps` to list the running containers.

### Adding Custom Python Scripts

To add custom Python scripts, simply place them in the `/opt/docker/volumes/docker-headless-automation` directory (or your `volumes` directory). The files will automatically be available inside the container at `/app`.

If you want to run a new script manually, use the `docker exec` command as shown above.

Make sure your Python scripts uses `pyvirtualdesktop`:

```
#!/usr/bin/env python3
from pyvirtualdisplay import Display

# Start Xvfb via pyvirtualdisplay
display = Display(visible=0, size=(1024, 768))
display.start()

os.system("xauth generate :99 . trusted")

...

display.stop()
```

### Crontab and Automation

The container includes **Crontab** for scheduling automated tasks. Once you've added or modified the cron jobs in `crontab.txt`, restart the container to apply the changes.

### Stopping and Restarting the Container

To stop the container, use:

```bash
docker compose down
```

To restart the container:

```bash
docker compose restart
```

### Viewing Logs

To view the container logs:

```bash
docker logs -f <container_name>
```

### Debugging Inside the Container

You can access the container's shell for debugging or manual tasks by running:

```bash
docker exec -it <container_name> /bin/bash
```

## Troubleshooting

* **Changes to `crontab.txt` not being applied:** Remember to restart the container after modifying `crontab.txt`.
* **Chromedriver not found:** Make sure `chromedriver` is correctly installed and available in the PATH. This is set up in the Dockerfile, but you can verify by running `which chromedriver` inside the container.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
